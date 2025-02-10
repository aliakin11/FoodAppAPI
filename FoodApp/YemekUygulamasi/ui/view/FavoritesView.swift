//
//  FavoritesView.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 20.01.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        VStack {
            Text("Favori Yemekler")
                .font(.largeTitle)
                .padding()
            
            List(viewModel.favoriteFoods) { food in
                Text(food.yemek_adi ?? "Bilinmeyen Yemek")
            }
        }
    }
} 