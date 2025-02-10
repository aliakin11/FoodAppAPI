//
//  FavoritesViewModel.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 20.01.2025.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteFoods: [Food] = []
    
    // Favori yemekleri ekleme ve çıkarma işlemleri burada yapılabilir
    func addFavorite(food: Food) {
        favoriteFoods.append(food)
    }
    
    func removeFavorite(food: Food) {
        favoriteFoods.removeAll { $0.yemek_id == food.yemek_id }
    }
} 