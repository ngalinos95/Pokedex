//
//  ImageService.swift
//  PokedexMVVM
//
//  Created by Nikos Galinos on 4/6/23.
//

import Foundation

class ImageService{
    //create a function that returns a pokemon Image Object with the the front_default url
  func getImage(name:String , completion : @escaping(PokeMonImage?) -> () ){
      
      guard let url=URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") else {
          DispatchQueue.main.async {
              completion(nil)
          }
          return
      }
      
      URLSession.shared.dataTask(with: url) { data, response, error in
          guard let data = data , error == nil else {
              DispatchQueue.main.async {
                  completion(nil)
              }
              return
          }
          
          let imageurl = try? JSONDecoder().decode(PokemonInfoList.self, from: data)
          if let imageurl = imageurl {
              let image=imageurl.sprites
              DispatchQueue.main.async {
                  completion(image)
              }
          }
          
          
      }.resume()
      
      
        
        
        
        
        
        
    }
}
