//
//  RegistrarTempoAberto.swift
//  casosDeUsoMacOS
//
//  Created by Micael Martins de Moura on 19/06/26.
//

import SwiftUI

struct RegistrarTempoAberto: View {
    let dataQueAbriu: Date
    
    var body: some View {
        
 
        Button("Mostrar tempo") {
            let data = Date().timeIntervalSince(dataQueAbriu)
            let segundos = Double(data)
            
            switch segundos {
            case segundos where segundos < 60:
                print("O aplicativo está aberto tem: \(Int(segundos)) segundos")
                
            case segundos where segundos > 60 && segundos < 120:
                print("O aplicativo está aberto tem mais ou menos: \(Int(segundos/60)) minuto")
            default:
                print("O aplicativo está aberto tem mais ou menos: \(Int(segundos/60)) minutos")
            }
        }
    }
}

//#Preview {
//    RegistrarTempoAberto(dataQueAbriu: )
//}
