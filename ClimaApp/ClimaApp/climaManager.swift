//
//  climaManager.swift
//  ClimaApp
//
//  Created by Mac2 on 27/11/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation
protocol climaManagerDelegate {
    func actualizarClima(clima: climaModelo)
}
struct climaManager {
    var delegado: climaManagerDelegate?
    
    
      var url="https://api.openweathermap.org/data/2.5/weather?appid=b72003fe98f0f81c60514dbad534a93b&lang=es&units=metric"
    func fetchClima(nombreCiudad: String){
        let urlString = "\(url)&q=\(nombreCiudad)"
        realizarPeticion(urlString: urlString)
    }
    func fetchClima(latitud: Double, longitud: Double) {
        let urlString = "\(url)&lat=\(latitud)&lon=\(longitud)"
        realizarPeticion(urlString: urlString)
    }
    func realizarPeticion(urlString: String) {
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { (data,respuesta,error) in
                if error != nil {
                    return
                }
                if let datosSeguros = data {
                    if let clima = self.parseJson(climadata: datosSeguros){
                        self.delegado?.actualizarClima(clima: clima)
                        
                    }
                }
            }
            
            
            
            tarea.resume()
        }
        
    }
    func parseJson(climadata: Data) -> climaModelo? {
        let decoder = JSONDecoder()
        
        do{
            let dataDecodificada = try decoder.decode(climaData.self, from: climadata)
            
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            
            let temperatura = dataDecodificada.main.temp
            let sensacionReal = dataDecodificada.main.feels_like
            let temperaturaMinima = dataDecodificada.main.temp_min
            let temperaturaMaxima = dataDecodificada.main.temp_max
            
            let latitud = dataDecodificada.coord.lat
            let longitud = dataDecodificada.coord.lon
            
            let clouds = dataDecodificada.clouds.all
            
            let wind = dataDecodificada.wind.speed
            
            let objClima = climaModelo(condicionID: id,
                                       nombreCiudad: nombre,
                                       descripcionClima: descripcion,
                                       temperaturaCelsius: temperatura,
                                       senReal: sensacionReal,
                                       tempMinima: temperaturaMinima,
                                       tempMaxima: temperaturaMaxima,
                                       lat: latitud,
                                       lon: longitud,
                                       Clouds: clouds,
                                       Wind: wind)
            return objClima
            
        }catch{
            print (error)
            return nil
        }
    }
    
    func handle(data: Data?, respuesta: URLResponse?, error: Error? ){
        if error != nil{
            return
        }
        if let datosSeguros = data {
            let dataString = String(data: datosSeguros, encoding: .utf8)
        }
        
    }
}
