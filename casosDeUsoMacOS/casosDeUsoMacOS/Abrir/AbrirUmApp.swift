//
//  AbrirUmApp.swift
//  casosDeUsoMacOS
//
//  Created by Micael Martins de Moura on 10/06/26.
//

import SwiftUI
import AppKit
import UniformTypeIdentifiers

//MARK: - Lógica
@MainActor
class AppSelectorManager {
    private(set) var UrlSelecionada: URL?
    
    func abrirSeletor() {
        let painel = NSOpenPanel()
        painel.allowedContentTypes = [UTType.applicationBundle]
        painel.directoryURL = URL(fileURLWithPath: "/Applications")
        painel.allowsMultipleSelection = false
        painel.canChooseDirectories = false
        
        
        guard painel.runModal() == .OK else { return }
               UrlSelecionada = painel.urls.first
    }
    
    func abrirApp() {
        guard let url = UrlSelecionada else { return }
        NSWorkspace.shared.openApplication(
            at: url,
            configuration: NSWorkspace.OpenConfiguration()
        )
    }
}

//MARK: - UI
struct AbrirUmApp: View {
    var body: some View {
        let logica = AppSelectorManager()
        
        VStack {
            
            Text("Selecione um app do seu dispositivo para abrir.")
            
            Button("Selecionar Apps") {
                logica.abrirSeletor()
            }
            
            Button("Abrir o App selecionado") {
                logica.abrirApp()
            }
            
        }.padding(16)
    }
}

#Preview {
    AbrirUmApp()
}
