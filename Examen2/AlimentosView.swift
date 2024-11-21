//
//  AlimentosView.swift
//  Examen2
//
//  Created by epismac on 21/11/24.
//

import SwiftUI

struct AlimentosView: View {
    @StateObject private var viewModel = AlimentosViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.alimentos) { alimento in
                        VStack(alignment: .leading) {
                            Text(alimento.nombre)
                                .font(.headline)
                            Text("Categoría: \(alimento.categoria)")
                                .font(.subheadline)
                            Text("Proteína: \(alimento.proteina) g")
                            Text("Grasa: \(alimento.grasa) g")
                            Text("Carbohidrato: \(alimento.carbohidrato) g")
                            Text("Energía: \(alimento.energia) kcal")
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                        .shadow(radius: 5)
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .padding(.top)
                .onAppear {
                    if viewModel.alimentos.isEmpty {
                        viewModel.loadMoreData()
                    }
                }
                .onChange(of: viewModel.alimentos.count) { _ in
                    if !viewModel.isLoading {
                        viewModel.loadMoreData()
                    }
                }
            }
            .navigationTitle("Alimentos")
        }
    }
}

struct AlimentosView_Previews: PreviewProvider {
    static var previews: some View {
        AlimentosView()
    }
}

