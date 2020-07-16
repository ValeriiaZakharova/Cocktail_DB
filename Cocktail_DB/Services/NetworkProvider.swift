//
//  NetworkProvider.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 16.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

final class NetworkProvider {
	
	func fetchCategories(completion: @escaping ([Category], Error?) -> Void) {
		guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list") else { return }
		let session = URLSession.shared
		
		session.dataTask(with: url) { data, response, error in
			if let response = response {
				print(response)
			}
			
			guard let data = data else {
				DispatchQueue.main.async {
					completion([], error)
				}
				return
			}
			
			do {
				let result = try JSONDecoder().decode(CategoryResult.self, from: data)
				DispatchQueue.main.async {
					completion(result.drinks, nil)
				}
			} catch {
				DispatchQueue.main.async {
					completion([], error)
				}
			}
		}.resume()
	}
	
	func fetchCocktails(category: Category, completion: @escaping ([Cocktail], Error?) -> Void) {
		let session = URLSession.shared
		guard let param = category.strCategory.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
			// error if something went erong
			let error = NSError(domain: "com.test.network",
													code: -1001,
													userInfo: [NSLocalizedDescriptionKey: "incorrect parameter: \(category.strCategory)"])
			completion([], error)
			return
		}
		
		guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(param)") else { return }
		
		session.dataTask(with: url) { data, response, error in
			
			if let response = response {
				print(response)
			}
			
			guard let data = data else {
				DispatchQueue.main.async {
					completion([], error)
				}
				return
			}
			
			do {
				let result = try JSONDecoder().decode(CocktailsResult.self, from: data)
				DispatchQueue.main.async {
					completion(result.drinks, nil)
				}
			} catch {
				DispatchQueue.main.async {
					completion([], error)
				}
			}
		}.resume()
	}
	
}
