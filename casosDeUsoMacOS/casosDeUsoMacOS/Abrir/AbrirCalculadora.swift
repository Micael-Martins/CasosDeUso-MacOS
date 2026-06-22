//
//  AbrirCalculadora.swift
//  casosDeUsoMacOS
//
//  Created by Micael Martins de Moura on 10/06/26.
//

import SwiftUI
import AppKit

struct AbrirCalculadora: View {
    var body: some View {
        
        VStack {
            Text("Aperte o botão abaixo para abrir a calculadora")
            
            Button("Abrir") {
                abrirApp()
            }
        }.padding(16)
    }
    
     private func abrirApp() {
        ///Pelo que eu entendi, nós acessamos o NSWorkspace.shared, entramos dentro do singleton onde podemos adicionar o metodo open URL. Ao colocar a url da calculadora (path dela no dispositivo), é possível abrir o app.
        ///Vale ressaltar que, ao utilizar essa abordagem, o app calculadora se torna o foco do dispositivo sobrepondo a janela atual ou direcionando a navegação para a mesa onde ela está.
        NSWorkspace.shared.open(URL(filePath: "/System/Applications/Calculator.app")
        )
        
    }
    
}

#Preview {
    AbrirCalculadora()
}
