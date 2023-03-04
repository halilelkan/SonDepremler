//
//  HomeModel.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 23.02.2023.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let status: Bool
    let result: T?
}

struct Product: Decodable {
    
    let earthquake_id: String?
    let title: String?
    let date: String?
    let lokasyon: String?
    let lat: Double?
    let lng: Double?
    let mag: Double?
    let depth: Double?
  
    
}

struct CustomError: Error {
    let message: String
}
