//
//  NetworkService.swift
//  Toko Marketer
//
//  Created by Mikhael Adiputra on 15/10/22.
//

import Foundation

class NetworkService: NetworkServicing {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) async -> Result<T, NetworkError> {
        guard let urlRequest = endpoint.urlRequest else {
            return .failure(.invalidURLRequest)
        }
        
        #if DEBUG
        NetworkLogger.log(request: urlRequest)
        #endif

        do {
         
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let response = response as? HTTPURLResponse else {
                return .failure(.emptyResponse)
            }
        
            #if DEBUG
            NetworkLogger.log(data: data, response: response)
            #endif
            
            do {
                let decodedData = try JSONDecoder().decode(model, from: data)
                return .success(decodedData)
            }catch {
                print(error)
                return .failure(.decoding)
            }

        } catch {
            return .failure(.underlying(error))
        }
    }
}
