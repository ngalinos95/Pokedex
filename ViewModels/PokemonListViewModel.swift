//
//  PokemonListViewModel.swift
//  PokedexMVVM
//
//  Created by Nikos Galinos on 4/6/23.
//

import Foundation


class PokemonListViewModel : ObservableObject{
    
    
    //we have to call the Service
    var service = PokemonService()
    
    //The Published variable is a list of Pokemon but going through the PokemonViewModel
    @Published var pokemonList : [PokemonViewModel] = []
    
    //we fetch the data of all the pokemon to the published variable with the following fetch function
    func fetchdata() {
        self.service.getPokemon { pokemons in
            if let pokemons = pokemons {
                DispatchQueue.main.async {
                    // Map the Pokemon objects to PokemonViewModel and set the imageURL property
                    self.pokemonList = pokemons.map { pokemon in
                        let pokemonVM = PokemonViewModel(pokemon: pokemon)
                        
                        // Create a local instance of the ImagesViewModel
                        let imageVM = ImagesViewModel()
                        
                        imageVM.fetchImages(name: pokemon.name.lowercased()) { image in
                            pokemonVM.imageURL = image?.front_default
                        }
                        
                        return pokemonVM
                    }
                }
            }
        }
    }
}
    
    
    
    
    //we create a pokemon View Model to interfere with the PokemonListViewModel
    //because on MVVM design structure all the variables must be passed through the ViewModel
    
    class PokemonViewModel : Identifiable {
        
        var pokemon : Pokemon
        var imageURL: String? // Add this property
        
        init(pokemon : Pokemon){
            self.pokemon = pokemon
        }
        
        let id = UUID()
        
        var name : String{
            return self.pokemon.name
        }
        
        var url : String {
            return self.pokemon.url
        }
        
        
    }

