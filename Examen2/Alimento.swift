//
//  Alimento.swift
//  Examen2
//
//  Created by epismac on 21/11/24.
//

import Foundation

// Define el modelo Alimento
struct Alimento: Identifiable, Decodable {
    var id: String {
        return codigo // Usamos el código como identificador único
    }
    let codigo: String
    let nombre: String
    let categoria: String
    let proteina: Double
    let grasa: Double
    let carbohidrato: Double
    let energia: Double
}
