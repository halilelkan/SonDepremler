//
//  Network.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 23.02.2023.
//

import Foundation

class Network  {
    
    private let baseUrlString = "https://api.orhanaydogdu.com.tr/deprem/kandilli/"
    
    func request<T: Decodable>(endpointType: EndpointType, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        let session = URLSession.shared
        
        guard let url = URL(string: baseUrlString + endpointType.endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpointType.method.rawValue
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(.failure(CustomError(message: "Gelen Response içerisinde data yok!")))
                return
            }
            
            
            let decoder = JSONDecoder()
            
            do {
                
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
                
            }
            catch let error {
                completion(.failure(CustomError(message: error.localizedDescription)))
            }
            
        }.resume()
    }
}
