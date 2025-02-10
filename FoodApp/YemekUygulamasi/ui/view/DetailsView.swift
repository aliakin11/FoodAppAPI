import SwiftUI

struct DetailsView: View {
    var food: Food
    @ObservedObject var cartViewModel: CartViewModel
    @State private var quantity: Int = 1
    @State private var isFavorite: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // Görsel Alanı
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi ?? "")")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .cornerRadius(20)
                                .background(Color.gray.opacity(0.1))
                        }

                        // Favori Kalp İkonu
                        Button(action: {
                            isFavorite.toggle()
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(isFavorite ? .red : .gray)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        }
                        .padding()
                    }

                    // Ürün Adı
                    Text(food.yemek_adi ?? "Bilinmeyen Yemek")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Fiyat
                    Text("₺\((Int(food.yemek_fiyat ?? "0") ?? 0) * quantity)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    // Ekle/Çıkar Butonları
                    HStack(spacing: 30) {
                        Button(action: {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        }) {
                            Image(systemName: "minus")
                                .frame(width: 50, height: 50)
                                .background(Color.red.opacity(0.2))
                                .foregroundColor(.red)
                                .clipShape(Circle())
                        }

                        Text(String(quantity))
                            .font(.title2)
                            .fontWeight(.bold)

                        Button(action: {
                            quantity += 1
                        }) {
                            Image(systemName: "plus")
                                .frame(width: 50, height: 50)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .clipShape(Circle())
                        }
                    }

                    // Sepete Ekle Butonu
                    Button(action: {
                        // Sepete ekleme işlemi
                        cartViewModel.addToCart(yemek: food, yemek_siparis_adet: quantity, kullanici_adi: "Ali")
                    }) {
                        Text("Sepete Ekle")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(color: Color.accentColor.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
                .navigationTitle(food.yemek_adi ?? "Ürün Detayı")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
