//
//  LoadingIndicator.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//
import SwiftUI

struct LoadingIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        // No update needed for this simple loading view
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            LoadingIndicator()
                .frame(width: 50, height: 50)
        }
    }
}
