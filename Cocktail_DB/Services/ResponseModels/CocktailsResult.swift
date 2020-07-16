//
//  CocktailsResult.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 16.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

struct CocktailsResult: Decodable {
	var drinks: [Cocktail]
}
