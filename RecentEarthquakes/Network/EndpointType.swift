//
//  EndpointType.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 25.02.2023.
//

import Foundation

enum EndpointType {
    
    case live
    
    var endpoint: String {
        
        switch self {
        case .live:
            return "Live"
        }
    }
    
    var method: HttpMethod {
        
        switch self {
        case .live:
            return .GET
        }
    }
}
