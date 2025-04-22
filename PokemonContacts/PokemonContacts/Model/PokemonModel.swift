//
//  PokemonModel.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/22/25.
//

import Foundation

struct Pokemon: Decodable {

    let sprites: Sprites
}

struct Sprites: Decodable {

    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
