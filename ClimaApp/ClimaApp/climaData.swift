//
//  climaData.swift
//  ClimaApp
//
//  Created by Mac2 on 28/11/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

struct climaData: Codable {
    let name: String
    let cod: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
    let clouds: Clouds
    let wind: Wind
    
}
struct Main: Codable{
    let temp: Double
    let humidity: Int
    let feels_like: Double
    let temp_min:Double
    let temp_max:Double
    
}
struct Weather: Codable{
    let id: Int
    let description: String
}
struct Coord: Codable{
    let lat: Double
    let lon: Double
}
struct Wind: Codable{
    let speed:Double
}
struct Clouds: Codable {
    let all:Int
}
