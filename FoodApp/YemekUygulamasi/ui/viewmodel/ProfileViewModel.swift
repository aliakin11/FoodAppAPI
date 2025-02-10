//
//  ProfileViewModel.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 20.01.2025.
//

import Foundation

class ProfileViewModel: ObservableObject {
    // Profil bilgileri burada yönetilebilir
    @Published var userName: String = "Kullanıcı Adı"
    @Published var userEmail: String = "kullanici@example.com"
    
    // Profil güncelleme işlemleri burada yapılabilir
    func updateProfile(name: String, email: String) {
        self.userName = name
        self.userEmail = email
    }
} 