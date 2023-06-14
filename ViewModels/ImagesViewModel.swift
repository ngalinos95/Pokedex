//
//  ImagesListViewModel.swift
//  PokedexMVVM
//
//  Created by Nikos Galinos on 4/6/23.
//

import Foundation

class ImagesViewModel : ObservableObject{
    
    //we have to call the Service
    var imageService = ImageService()
    
    //The Published variable is a an object of PokemonImage
    @Published var imageurl = PokeMonImage()
    

    
    
    
    
    func fetchImages(name: String, completion: @escaping (PokeMonImage?) -> Void) {
        self.imageService.getImage(name: name) { image in
            DispatchQueue.main.async {
                self.imageurl.front_default = image?.front_default
                completion(self.imageurl)
            }
        }
    }
    
}
