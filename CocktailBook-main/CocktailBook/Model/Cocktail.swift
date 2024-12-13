//
//  Cocktail.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//

import SwiftUI

struct Cocktail: Identifiable, Codable {
    let id: String
    let name: String
    let type: String
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
}
