//
//  Caso1.swift
//  desenvolvendoMacOS
//
//  Created by Micael Martins de Moura on 29/05/26.
//

//MARK: Essa view cria um app que se fecha ao apertar o botão "Fechar Janela"

import SwiftUI
import AppKit

struct Caso1: View {
    var body: some View {
        VStack {
            
            Button {
                fecharJanela()
            } label: {
                Text("Fechar janela")
                    .bold()
            }
        }
        .padding()
    }
    
    func fecharJanela() {
        NSApplication.shared.terminate(nil)
    }
}

#Preview {
    Caso1()
}
