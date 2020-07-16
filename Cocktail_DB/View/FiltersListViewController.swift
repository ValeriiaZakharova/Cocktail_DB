//
//  FiltersListViewController.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 14.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class FiltersListViewController: UIViewController {
	
	@IBOutlet private weak var tableView: UITableView!
	
	var service: CocktailsService!
	
	private var filters: [FilterCategory] = []

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.contentInset = .init(top: 0, left: 0, bottom: 160, right: 0)
		tableView.register(UINib(nibName: Constants.filterCellIndetifier, bundle: nil), forCellReuseIdentifier: Constants.filterCellIndetifier)
		
		service.fetchFilters { filters in
			self.filters = filters
			self.tableView.reloadData()
		}
	}
	
	@IBAction func didTapApply(_ sender: UIButton) {
		service.apply(filters: filters)
		navigationController?.popViewController(animated: true)
	}
}

//MARK: - UITableViewDataSource

extension FiltersListViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filters.count
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let filter = filters[indexPath.row]
		if filter.isSelected {
			tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.filterCellIndetifier) as! FilterCell
		let filter = filters[indexPath.row]
		cell.filterLabel.text = filter.category.strCategory
		return cell
	}
}

//MARK: - UITableViewDelegate

extension FiltersListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		filters[indexPath.row].isSelected = true
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		filters[indexPath.row].isSelected = false
	}
}

// MARK: - Constants

extension FiltersListViewController {
	enum Constants {
		static let filterCellIndetifier = "FilterCell"
	}
}
