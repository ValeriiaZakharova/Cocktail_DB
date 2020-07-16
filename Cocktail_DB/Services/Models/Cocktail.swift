//
//  Cocktail.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 15.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

struct Cocktail: Decodable {
	let idDrink: String
	let strDrink: String
	let strDrinkThumb: String?
}
