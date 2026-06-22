import AppKit
import SwiftUI
import ApplicationServices

@Observable
class AppTerminatorManager {
    
    enum TerminationError: Error {
        case accessibilityPermissionDenied
        case appNotFound
        case terminationFailed
    }
    
    var hasAccessibilityPermission: Bool {
        AXIsProcessTrusted()
    }
    
    func requestAccessibilityPermissionIfNeeded() {
        guard !hasAccessibilityPermission else { return }
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue(): true] as CFDictionary
        AXIsProcessTrustedWithOptions(options)
    }
    
    func fecharApp(bundleIdentifier: String) throws {
        guard hasAccessibilityPermission else {
            throw TerminationError.accessibilityPermissionDenied
        }
        
        guard let app = NSRunningApplication
            .runningApplications(withBundleIdentifier: bundleIdentifier)
            .first else {
            throw TerminationError.appNotFound
        }
        
        // AXUIElement envia o evento quit nativo (equivalente a Cmd+Q)
        let axApp = AXUIElementCreateApplication(app.processIdentifier)
        let result = AXUIElementPerformAction(axApp, kAXPressAction as CFString)
        
        // Fallback gracioso via terminate() — funciona se AX falhar por quirks do app
        if result != .success {
            let terminated = app.terminate()
            if !terminated { throw TerminationError.terminationFailed }
        }
    }
}

// MARK: - UI
struct FechaUmApp: View {
    @State private var logica = AppTerminatorManager()
    @State private var statusMessage: String = ""
    
    var body: some View {
        VStack(spacing: 12) {
            if !logica.hasAccessibilityPermission {
                VStack(spacing: 8) {
                    Text("Permissão de Acessibilidade necessária.")
                        .foregroundStyle(.secondary)
                    Button("Abrir Configurações") {
                        logica.requestAccessibilityPermissionIfNeeded()
                    }
                }
            }
            
            Button("Fechar Calculadora") {
                do {
                    try logica.fecharApp(bundleIdentifier: "com.apple.calculator")
                    statusMessage = "App fechado com sucesso."
                } catch AppTerminatorManager.TerminationError.accessibilityPermissionDenied {
                    statusMessage = "Permissão de Acessibilidade negada."
                } catch AppTerminatorManager.TerminationError.appNotFound {
                    statusMessage = "Calculadora não está aberta."
                } catch {
                    statusMessage = "Erro ao fechar o app."
                }
            }
            .disabled(!logica.hasAccessibilityPermission)
            
            if !statusMessage.isEmpty {
                Text(statusMessage).foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .onAppear {
            logica.requestAccessibilityPermissionIfNeeded()
        }
    }
}

#Preview {
    FechaUmApp()
}
