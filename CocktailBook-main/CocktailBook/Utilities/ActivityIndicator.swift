//
//  ActivityIndicator.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//


import SwiftUI

// Custom UIActivityIndicatorView wrapper for iOS 13 compatibility
struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
