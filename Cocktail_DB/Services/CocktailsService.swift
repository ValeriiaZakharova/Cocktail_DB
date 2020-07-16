//
//  CocktailsService.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 15.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

protocol CocktailsService {
	
	func fetchCategoryViewModels(completion: @escaping ([CategoryViewModel], Error?) -> Void)
	func fetchFilters(completion: @escaping ([FilterCategory]) -> Void)
	func apply(filters: [FilterCategory])
}

final class CocktailServiceImpl: CocktailsService {
	
	private var filters: [FilterCategory] = []
	
	private var cocktails: [Cocktail] = []
	
	private var viewModels: [CategoryViewModel] = []
	
	private let networkProvider = NetworkProvider()
	
	func fetchCategoryViewModels(completion: @escaping ([CategoryViewModel], Error?) -> Void) {
		// CACHE
		if !viewModels.isEmpty {
			
			let selectedCategoryNames = Set(fetchSelectedCategories().map { $0.strCategory })
			
			let result = viewModels.filter { viewModel -> Bool in
				selectedCategoryNames.contains(viewModel.category.strCategory)
			}
			completion(result, nil)
			return
		}
		
		// REQUEST NEW CATEGORIES WITH COCKTAILS
		networkProvider.fetchCategories { [weak self] (categories, error) in
			guard let self = self else {
				completion([], nil)
				return
			} 
			
			if let error = error {
				completion([], error)
				return
			}
			
			self.filters = categories.map { FilterCategory(category: $0) }
//			self.filters = categories.map({ category -> FilterCategory in
//				return FilterCategory(category: category)
//			})
			
			let group = DispatchGroup()
			var finalError: Error?
			var viewModels: [CategoryViewModel] = []
			
			for category in categories {
				group.enter()
				print("SEND category name: \(category.strCategory)")
				self.networkProvider.fetchCocktails(category: category) { cocktails, error in
					print("RECEIVED category name: \(category.strCategory)")
					let model = CategoryViewModel(category: category, cocktails: cocktails)
					
					DispatchQueue.main.async {
						viewModels.append(model)
						finalError = error ?? finalError
						group.leave()
					}
				}
			}
			
			group.notify(queue: .main) {
				print("ALL CATEGORIES RECEIVED")
				if let error = finalError {
					completion([], error)
				} else {
					self.viewModels = viewModels
					completion(viewModels, nil)
				}
			}
		}
	}
	
	func fetchFilters(completion: @escaping ([FilterCategory]) -> Void) {
		if !filters.isEmpty {
			completion(filters)
			return
		}
	}
	
	func fetchSelectedCategories() -> [Category] {
		return filters
			.filter { filter -> Bool in
				return filter.isSelected
		}
		.map { filter -> Category in
			filter.category
		}
	}
	
	func apply(filters: [FilterCategory]) {
		self.filters = filters
	}
	
}
