//
//  CartViewModel.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 20.01.2025.
//

import Foundation
import Alamofire

class CartViewModel: ObservableObject {
    
    @Published var cartItemsList = [CartItem]()
    
    
    // Sepete ekleme ve çıkarma işlemleri burada yapılabilir
    func addToCart(yemek: Food, yemek_siparis_adet: Int, kullanici_adi: String) {
        
        let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        let params: Parameters = [
            "yemek_adi": yemek.yemek_adi ?? "",
            "yemek_resim_adi": yemek.yemek_resim_adi ?? "",
            "yemek_fiyat": yemek.yemek_fiyat ?? "",
            "yemek_siparis_adet": String(yemek_siparis_adet),
            "kullanici_adi": kullanici_adi
        ]
        
        AF.request(url, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CartItemResponse.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getFoodsFromCart(kullanici_adi: String) {
        let url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request(url, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    
                    let cevap = try JSONDecoder().decode(CartItemResponse.self, from: data)
                    
                    
                    if let success = cevap.success, success == 1 {
                        
                        if let list = cevap.sepet_yemekler {
                            DispatchQueue.main.async {
                                self.cartItemsList = list
                            }
                        }
                    } else {
                        print("No items found in cart or success is not 1.")
                    }
                    
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Response error: \(response.error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    func removeFromCart(food: CartItem, kullanici_adi: String) {
        let url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        let params: Parameters = ["sepet_yemek_id": food.sepet_yemek_id ?? "", "kullanici_adi": kullanici_adi]

        AF.request(url, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CartItemResponse.self, from: data)
                    if let success = cevap.success, success == 1 {
                        DispatchQueue.main.async {
                            
                            self.cartItemsList.removeAll { $0.sepet_yemek_id == food.sepet_yemek_id }
                
                        }
                    } else {
                        print("Silme işlemi başarısız: \(cevap.message ?? "Bilinmeyen hata")")
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
