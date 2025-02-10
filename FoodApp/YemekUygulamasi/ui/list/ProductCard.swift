import SwiftUI

struct ProductCard: View {
    var food: Food
    var genislik: CGFloat // Genişlik parametresi
    @ObservedObject var cartViewModel: CartViewModel // CartViewModel'i burada kullanıyoruz

    var body: some View {
        VStack(spacing: 10) {
            if let imageName = food.yemek_resim_adi {
                AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageName)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                } placeholder: {
                    ProgressView()
                        .frame(height: 150)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(food.yemek_adi ?? "Bilinmeyen Yemek")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text("₺\(food.yemek_fiyat ?? "0")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: {
                cartViewModel.addToCart(yemek: food, yemek_siparis_adet: 1, kullanici_adi: "Ali") // Kullanıcı adını dinamik hale getirin
            }) {
                Text("Sepete Ekle")
                    .font(.subheadline)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}
