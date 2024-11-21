//
//  APIClient.swift
//  Examen2
//
//  Created by epismac on 21/11/24.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func fetchAlimentos(completion: @escaping ([Alimento]?, Error?) -> Void) {
        guard let url = URL(string: "http://10.7.46.45:3000/api/alimentos") else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"]))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let alimentos = try decoder.decode([Alimento].self, from: data)
                completion(alimentos, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

