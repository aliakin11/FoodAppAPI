//
//  ProfileView.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 20.01.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            Text("Profilim")
                .font(.largeTitle)
                .padding()
            
            Text("Ad: \(viewModel.userName)")
            Text("Email: \(viewModel.userEmail)")
        }
    }
} 