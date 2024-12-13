//
//  ListView.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//
import SwiftUI

struct ListView: View {
    @ObservedObject private var viewModel = ListViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter Picker fixed at the top
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    ForEach(CocktailFilter.allCases, id: \.self) { filter in
                        Text(filter.rawValue.capitalized).tag(filter)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .background(Color(UIColor.systemBackground))
                .accessibility(label: Text("Filter Picker"))

                Divider()

                // Main content wrapped in a GeometryReader
                GeometryReader { geometry in
                    if viewModel.isLoading {
                        VStack {
                            Spacer()
                            LoadingView()
                                .padding()
                                .accessibility(label: Text("Loading Indicator"))
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    } else if let errorMessage = viewModel.errorMessage {
                        // Show error message with retry option
                        VStack {
                            Spacer()
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding()
                            Button("Retry") {
                                viewModel.retryFetch()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .accessibility(label: Text("Retry"))
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    } else {
                        List(viewModel.filteredCocktails) { cocktail in
                            NavigationLink(
                                destination: DetailsView(
                                    viewModel: DetailsViewModel(
                                        cocktail: cocktail,
                                        isFavorite: viewModel.favoriteCocktails.contains(cocktail.id)
                                    ),
                                    onFavoriteToggle: { isFav in
                                        viewModel.toggleFavorite(for: cocktail.id)
                                    }
                                )
                            ) {
                                CocktailRow(
                                    cocktail: cocktail,
                                    isFavorite: viewModel.favoriteCocktails.contains(cocktail.id)
                                )
                                .accessibility(label: Text("Cocktail: \(cocktail.name)"))
                            }
                            .accessibility(identifier: "CocktailRow_\(cocktail.id)")
                        }
                        .listStyle(PlainListStyle())
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
            .navigationBarTitle("Cocktail Book", displayMode: .inline)
            .accessibility(label: Text("Cocktail Book List"))
        }
    }
}
