//
//  MainViewModel.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 20.01.2025.
//

import Foundation
import Alamofire

class MainViewModel : ObservableObject {
    
    @Published var foodList = [Food]()
    
    func fetchFoods() {
        let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
        
        AF.request(url, method: .get).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(FoodResponse.self, from: data)
                    print("API Response: \(response)")
                    if let list = response.yemekler {
                        DispatchQueue.main.async {
                            
                            self.foodList = list
                            
                        }
                    } else {
                        print("No foods found in response.")
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Response error: \(response.error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
