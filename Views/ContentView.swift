//
//  ContentView.swift
//  PokedexMVVM
//
//  Created by Nikos Galinos on 4/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pokemonVM=PokemonListViewModel()
    @ObservedObject var imageVM = ImagesViewModel()
    @State  var searchText = ""
    
    var body: some View {
        NavigationStack {
            
            List{
                
                ForEach(searchText == "" ? self.pokemonVM.pokemonList : pokemonVM.pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }) { pokemon in
                    HStack {
                        PokemonImageView(pokemon: pokemon).environmentObject(imageVM)
                        Spacer()
                        Text(pokemon.name.capitalized)
                        Spacer()
                    }
                }
                
            }   .searchable(text: $searchText)
                .navigationTitle("PokedexUI")
                .onAppear{
                    pokemonVM.fetchdata()
                }
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
