//
//  ViewController.swift
//  ClimaApp
//
//  Created by Mac2 on 27/11/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, UITextFieldDelegate, climaManagerDelegate {
    func actualizarClima(clima: climaModelo) {
        DispatchQueue.main.async {
            
        
            self.descripcion.text = clima.descripcionClima
        self.temperatura.text = String( "\(clima.temperaturaUnDecimal) °C")
        self.sensacionReal.text = String(  "\(clima.senReal) °C")
            self.coordenadas.text = String("lat:  \(clima.lat) lon: \(clima.lon)")
        self.velocidad.text = String(clima.Wind)
        self.humedad.text = String(clima.Clouds)
        self.tempMax.text = String("\(clima.tempMaxima) °C")
        self.tempMin.text = String("\(clima.tempMinima) °C")
        self.ciudad.text = clima.nombreCiudad
        self.entradaCiudad.text = clima.nombreCiudad
        
        self.fondoImagen.image = self.fondo[Int(clima.condicionClima) ?? 0]
        }
    }
    var locationManager = CLLocationManager()
    var fondo = [#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "7"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "5"),#imageLiteral(resourceName: "3")]
    

    var Manager = climaManager()
   
    @IBOutlet weak var velocidad: UILabel!
    @IBOutlet weak var humedad: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var fondoImagen: UIImageView!
    @IBOutlet weak var sensacionReal: UILabel!
    @IBOutlet weak var temperatura: UILabel!
    @IBOutlet weak var ciudad: UILabel!
    @IBOutlet weak var coordenadas: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var entradaCiudad: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        entradaCiudad.delegate=self
        Manager.delegado = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        Manager.fetchClima(nombreCiudad: "Londres")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       ciudad.text = entradaCiudad.text
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if entradaCiudad.text != "" {
            return true}
        else{
            entradaCiudad.placeholder = "Escribe una ciudad"
            return false
        }
    }
    @IBAction func Localizacion(_ sender: UIButton) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    @IBAction func Buscar(_ sender: UIButton) {
        
        Manager.fetchClima(nombreCiudad: entradaCiudad.text!)
        
    }
    //MARK:- Protocolo
    
    
}//MARK:- Protocolo
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("localizacion")
        if let ubicacion = locations.last{
            let latitud = ubicacion.coordinate.latitude
            let longitud = ubicacion.coordinate.longitude
        
        Manager.fetchClima(latitud: latitud, longitud: longitud)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

