//
//  PokemonModels.swift
//  PokedexMVVM
//
//  Created by Nikos Galinos on 4/6/23.
//

import Foundation


struct PokemonList : Codable {
    
    //it must have the name of the JSON data list that contain the Pokemon Objects -> results
    
    var results : [Pokemon]
    
}


struct Pokemon : Codable {
    var name : String
    var url : String
}

struct PokemonInfoList : Codable {
    
    //it must have the name of the JSON data list that contain the ImageObject-> sprites
    
    var sprites : PokeMonImage

}


struct PokeMonImage : Codable {
    
    var front_default : String?
}

