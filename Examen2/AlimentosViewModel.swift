//
//  AlimentosViewModel.swift
//  Examen2
//
//  Created by epismac on 21/11/24.
//

import Foundation
import Combine

class AlimentosViewModel: ObservableObject {
    @Published var alimentos: [Alimento] = []
    @Published var isLoading = false
    private var currentPage = 0
    private let pageSize = 20
    
    private let apiUrl = "http://10.7.46.45:3000/api/alimentos" // URL de la API

    init() {
        loadMoreData()
    }

    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        currentPage += 1
        
        // Cargar los datos desde la API
        DispatchQueue.global(qos: .background).async {
            self.fetchData()
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: apiUrl) else {
            print("URL inválida")
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return
        }

        // Realizamos la solicitud GET a la API
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al hacer la solicitud: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            // Decodificar los datos JSON recibidos
            let decoder = JSONDecoder()
            do {
                let alimentosDecoded = try decoder.decode([Alimento].self, from: data)
                
                // Paginar los resultados
                let startIndex = self.pageSize * (self.currentPage - 1)
                let endIndex = min(startIndex + self.pageSize, alimentosDecoded.count)
                
                DispatchQueue.main.async {
                    self.alimentos.append(contentsOf: alimentosDecoded[startIndex..<endIndex])
                    self.isLoading = false
                }
            } catch {
                print("Error al decodificar el JSON: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
