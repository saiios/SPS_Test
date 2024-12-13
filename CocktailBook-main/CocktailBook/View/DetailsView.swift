//
//  DetailsView.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//
import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: DetailsViewModel
    var onFavoriteToggle: (Bool) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Section
                HStack {
                    backButton
                    Spacer()
                    favoriteIcon
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // Cocktail Name & Time
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.cocktail.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .accessibility(identifier: "CocktailName")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)

                        Text("\(viewModel.cocktail.preparationMinutes) minutes")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .accessibility(identifier: "PreparationTime")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)

                // Image Placeholder
                Image(viewModel.cocktail.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Description Section
                Text(viewModel.cocktail.shortDescription)
                    .font(.body)
                    .padding(.horizontal)
                    .accessibility(identifier: "CocktailDescription")
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Ingredients Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.headline)
                        .fontWeight(.bold)
                        .accessibility(identifier: "IngredientsHeader")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(viewModel.cocktail.ingredients, id: \.self) { ingredient in
                        HStack(alignment: .center, spacing: 8) {
                            Circle()
                                .fill(Color.primary)
                                .frame(width: 8, height: 8)

                            Text(ingredient)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("All Cocktails")
            }
            .foregroundColor(.purple)
        }
        .accessibility(identifier: "BackButton")
    }

    private var favoriteIcon: some View {
        Button(action: {
            viewModel.isFavorite.toggle()
            onFavoriteToggle(viewModel.isFavorite)
        }) {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(viewModel.isFavorite ? .purple : .gray)
        }
        .accessibility(identifier: "NavigationFavoriteIcon")
    }
}
