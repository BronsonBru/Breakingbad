//
//  Favourits.swift
//  BreakingBadApi
//
//  Created by IACD -016 on 2022/06/29.
//

import Foundation


class Favourites: ObservableObject{
    private var characters: Set<String>
    private let saveKey = "Favourites"
    
    
    
    init(){
        characters = []
    }
    
    func contains(_ character: Character) -> Bool{
        characters.contains(character.name)
    }
    
    func add(_ character: Character){
        objectWillChange.send()
        characters.insert(character.name)
        save()
    }
    
    func remove(_ character: Character){
        objectWillChange.send()
        characters.remove(character.name)
        save()
    }
    
    func save(){

    }
    
    
}
