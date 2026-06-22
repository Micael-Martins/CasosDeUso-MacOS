//
//  CalculandoTempoModos.swift
//  casosDeUsoMacOS
//
//  Created by Micael Martins de Moura on 19/06/26.
//

import SwiftUI
import Combine

struct CalculandoTempoModos: View {
    @State var isActive1: Bool
    @State var isActive2: Bool
    
    @State private var inicio1: Date?
    @State private var segundosAtivos1 = 0
    @State private var segundosAcumulados1 = 0
    
    @State private var inicio2: Date?
    @State private var segundosAtivos2 = 0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        //Quadrados
        HStack {
            
            VStack {
                //Retângulo Vermelho
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        
                        if !isActive1 {
                            inicio1 = Date()
                        }
                        
                        if isActive1, let inicio = inicio1 {
                            segundosAcumulados1 += Int(Date().timeIntervalSince(inicio))
                            inicio1 = nil
                        }
                        
                        isActive1.toggle()
                    }
                    
                } label: {
                    Rectangle()
                        .foregroundStyle(isActive1 ? Color.red : Color.gray)
                        .frame(width: 100, height: 100)
                }.buttonStyle(.borderless)
                
                Text("\(segundosAtivos1)")
                    .onReceive(timer) { _ in
                        if isActive1, let inicio = inicio1 {
                            segundosAtivos1 = segundosAcumulados1 +  Int(Date().timeIntervalSince(inicio))
                        }
                        
                        else {
                            segundosAtivos1 = segundosAcumulados1
                        }
                    }
                
            }
            //Retângulo Azul
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isActive2.toggle()
                }
                
            } label: {
                Rectangle()
                    .foregroundStyle(isActive2 ? Color.blue : Color.gray)
                    .frame(width: 100, height: 100)
            }
            
        }.padding(16)
    }
}

#Preview {
    CalculandoTempoModos(isActive1: false,
                         isActive2: false)
}
