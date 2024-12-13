//
//  NavigationBarModifier.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//
import SwiftUI

/// Custom Modifier for iOS 13 Navigation Title Compatibility
struct NavigationBarModifier: ViewModifier {
    let title: String

    func body(content: Content) -> some View {
        content
            .navigationBarTitle(Text(title), displayMode: .inline)
    }
}
