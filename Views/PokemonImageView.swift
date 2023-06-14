//
//  PokemonImageView.swift
//  PokedexMVVM
//
//  Created by Nikos Galinos on 4/6/23.
//

import SwiftUI

struct PokemonImageView: View {
    @EnvironmentObject var imageVM: ImagesViewModel
    var pokemon: PokemonViewModel
    
    @State private var url = ""
    
    var body: some View {
        if let imageURL = pokemon.imageURL {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .foregroundColor(Color.gray.opacity(0.6))
                        .scaledToFit()
                case .failure:
                    PlaceholderImage()
                case .empty:
                    PlaceholderImage()
                @unknown default:
                    PlaceholderImage()
                }
            }
        } else {
            PlaceholderImage()
                .onAppear {
                    imageVM.fetchImages(name: pokemon.name.lowercased()) { _ in }
                }
        }
    }
    
    struct PlaceholderImage: View {
        var body: some View {
            Image("placeholder")
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .foregroundColor(Color.gray.opacity(0.6))
                .scaledToFit()
        }
    }
}

