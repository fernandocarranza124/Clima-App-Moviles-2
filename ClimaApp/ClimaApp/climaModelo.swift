//
//  climaModelo.swift
//  ClimaApp
//
//  Created by Mac2 on 28/11/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

struct climaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let descripcionClima:String
    let temperaturaCelsius: Double
    let senReal: Double
    let tempMinima: Double
    let tempMaxima: Double
    let lat: Double
    let lon: Double
    let Clouds: Int
    let Wind: Double
    
    var condicionClima: String{
        switch condicionID {
        case 200...232:
            //tormenta electrica
            return "0"
        case 300...321:
            //llovizna
            return "1"
        case 500...531:
            //lluvia
            return "2"
        case 600...622:
            //Nieve
            return "3"
        case 700...781:
            
            return "4"
        case 800:
            //despejado
            return "5"
        case 801...804:
            //nublado
            
            return "6"
        default:
            return "0"
        }
    }
    
    var temperaturaUnDecimal: String {
        return String(format: "%.1f", temperaturaCelsius)
    }
}


