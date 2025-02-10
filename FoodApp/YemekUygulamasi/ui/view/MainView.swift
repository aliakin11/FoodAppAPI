import SwiftUI

struct MainView: View {
    @State private var searchText: String = ""
    @ObservedObject private var viewModel = MainViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let ekranGenislik = geometry.size.width
            let itemGenislik = (ekranGenislik - 60) / 2
            
            TabView {
                NavigationView {
                    VStack {
                        headerView
                        searchField
                        productListView(itemGenislik: itemGenislik)
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    .navigationTitle("Ana Sayfa")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Ana Sayfa", systemImage: "house.fill")
                }
                
                FavoritesView()
                    .tabItem {
                        Label("Favorilerim", systemImage: "star.fill")
                    }
                
                CartView(viewModel: cartViewModel)
                    .tabItem {
                        Label("Sepetim", systemImage: "cart.fill")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profilim", systemImage: "person.fill")
                    }
            }
            .accentColor(.orange)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Ürünler")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                
                Spacer()

                Label("Teslimat Adresi: Evim", systemImage: "house.fill")
                    .font(.callout)
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    private var searchField: some View {
        TextField("Ara", text: $searchText)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .overlay(
                HStack {
                    Spacer()
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 10)
                    }
                }
            )
            .padding(.horizontal)
            .padding(.top, 10)
    }
    
    private func productListView(itemGenislik: CGFloat) -> some View {
        // Ürün Listesi
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 150, maximum: itemGenislik), spacing: 20),
                GridItem(.flexible(minimum: 150, maximum: itemGenislik), spacing: 20)
            ], spacing: 20) {
                ForEach(viewModel.foodList) { food in
                    NavigationLink(destination: DetailsView(food: food, cartViewModel: cartViewModel)) {
                        ProductCard(food: food, genislik: itemGenislik, cartViewModel: cartViewModel)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .onAppear {
            viewModel.fetchFoods()
        }
    }
}
