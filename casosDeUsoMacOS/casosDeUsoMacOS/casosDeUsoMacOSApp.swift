//
//  casosDeUsoMacOSApp.swift
//  casosDeUsoMacOS
//
//  Created by Micael Martins de Moura on 10/06/26.
//

import SwiftUI

@main
struct casosDeUsoMacOSApp: App {
    
    let dataDeAbertura = Date()

    var body: some Scene {
        WindowGroup {
            RegistrarTempoAberto(dataQueAbriu: dataDeAbertura)
        }
    }
}
