//
//  PokemonService.swift
//  PokedexMVVM
//
//  Created by Nikos Galinos on 4/6/23.
//

import Foundation

//The service return a list of Pokemon objects [Pokemon]

class PokemonService {
    
    func getPokemon (completion: @escaping ([Pokemon]?) -> () ) {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151") else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        URLSession.shared.dataTask(with: url) {data ,response ,error in
            guard let data = data , error == nil else{
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            let pokemonList = try?JSONDecoder().decode(PokemonList.self, from: data)
            if let pokemonList = pokemonList{
                let pokemons = pokemonList.results
                DispatchQueue.main.async {
                    completion(pokemons)
                }
            }else{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            
        }.resume()
        
    }
}
