//
//  CartView.swift
//  YemekUygulamasi
//
//  Created by Ali AKIN on 20.01.2025.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Sepetim")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                if viewModel.cartItemsList.isEmpty {
                    Spacer()
                    Text("Sepetinizde hiç yemek yok.")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.cartItemsList) { item in
                                cartItemView(item: item)
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                viewModel.getFoodsFromCart(kullanici_adi: "Ali")
            }
        }
    }
    
    private func cartItemView(item: CartItem) -> some View {
        HStack {
            AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.yemek_resim_adi ?? "")")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.yemek_adi ?? "Bilinmeyen Yemek")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Adet: \(item.yemek_siparis_adet ?? "0")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                let fiyat = (Int(item.yemek_fiyat ?? "0") ?? 0)
                let adet = (Int(item.yemek_siparis_adet ?? "1") ?? 1)
                let toplamFiyat = fiyat * adet
                
                Text("₺\(toplamFiyat)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            Spacer()
            
            Button(action: {
                viewModel.removeFromCart(food: item, kullanici_adi: "Ali")
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
