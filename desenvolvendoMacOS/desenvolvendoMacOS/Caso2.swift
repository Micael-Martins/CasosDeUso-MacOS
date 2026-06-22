//
//  Caso2.swift
//  desenvolvendoMacOS
//
//  Created by Micael Martins de Moura on 29/05/26.
//

import SwiftUI
import AppKit
import ApplicationServices

struct Caso2: View {
    var body: some View {
        VStack {
            Button {
                minimizeApp(bundleID: "com.apple.systempreferences")
            } label: {
                Text("Minimizar Ajustes")
                    .bold()
            }
        }
        .padding()
    }

    // MARK: - Verifica e solicita permissão
    func verificarPermissao() -> Bool {
        let options: NSDictionary = [
            kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true
        ]
        let trusted = AXIsProcessTrustedWithOptions(options)
        if !trusted {
            print("⚠️ Permissão de Acessibilidade não concedida.")
            print("➡️ Vá em: System Settings → Privacidade e Segurança → Acessibilidade")
        }
        return trusted
    }

    // MARK: - Minimiza qualquer app pelo Bundle ID
    func minimizeApp(bundleID: String) {
        guard verificarPermissao() else { return }

        guard let app = NSRunningApplication
            .runningApplications(withBundleIdentifier: bundleID)
            .first else {
            print("❌ App com bundleID '\(bundleID)' não está rodando.")
            return
        }

        print("✅ App encontrado — PID: \(app.processIdentifier)")

        let axApp = AXUIElementCreateApplication(app.processIdentifier)

        var windowsRef: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(
            axApp,
            kAXWindowsAttribute as CFString,
            &windowsRef
        )

        guard result == AXError.success,
              let windows = windowsRef as? [AXUIElement],
              !windows.isEmpty else {
            print("❌ Sem janelas acessíveis. Código de erro: \(result.rawValue)")
            return
        }

        print("✅ \(windows.count) janela(s) encontrada(s). Minimizando...")

        for (index, window) in windows.enumerated() {
            let actionResult = AXUIElementPerformAction(window, "AXMinimize" as CFString)

            if actionResult == AXError.success {
                print("✅ Janela \(index + 1) minimizada com sucesso.")
            } else {
                // Fallback: força o atributo diretamente
                let setResult = AXUIElementSetAttributeValue(
                    window,
                    kAXMinimizedAttribute as CFString,
                    kCFBooleanTrue
                )
                if setResult == AXError.success {
                    print("✅ Janela \(index + 1) minimizada via atributo.")
                } else {
                    print("❌ Falha na janela \(index + 1). Action: \(actionResult.rawValue), Attr: \(setResult.rawValue)")
                }
            }
        }
    }
}

#Preview {
    Caso2()
}
