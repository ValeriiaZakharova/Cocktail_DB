//
//  CocktailsListViewController.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 14.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit
import AlamofireImage

class CocktailsListViewController: UIViewController {
	
	@IBOutlet private weak var tableView: UITableView!
	
	var service: CocktailsService = CocktailServiceImpl()
	
	var viewModels: [CategoryViewModel] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(UINib(nibName: Constants.cocktailCellIndetifier, bundle: nil), forCellReuseIdentifier: Constants.cocktailCellIndetifier)
		tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.header)
		tableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
		
		reloadCoctails()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(true)
			reloadCoctails()
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let filtersVC = segue.destination as? FiltersListViewController {
			filtersVC.service = service
		}
	}
	
	//MARK: - Private
	
	private func reloadCoctails() {
		//UIApplication.shared.isNetworkActivityIndicatorVisible = true
		service.fetchCategoryViewModels { [weak self] (viewModels, error) in
			guard let self = self else { return }
			if let error = error {
				self.showError(error.localizedDescription)
				print(error)
			} else {
				self.viewModels = viewModels
				self.tableView.reloadData()
			}
			//UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
	}
	
	func showError(_ error: String) {
		let alertController = UIAlertController()
		alertController.message = error
		alertController.addAction(.init(title: "OK", style: .cancel, handler: nil))
		present(alertController, animated: true)
	}
}

//MARK: - UITableViewDataSource

extension CocktailsListViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModels.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModels[section].cocktails.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cocktailCellIndetifier) as! CocktailCell
		let cocktail = viewModels[indexPath.section].cocktails[indexPath.row]
		cell.nameLabel.text = cocktail.strDrink
		
		if let urlString = cocktail.strDrinkThumb, let url = URL(string: urlString) {
			cell.pictureImageView.af.setImage(withURL: url)
		}
		return cell
	}
}

//MARK: - UITableViewDelegate

extension CocktailsListViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.header) as! HeaderView
		headerview.title.text = viewModels[section].category.strCategory
		return headerview
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 36
	}
}

//MARK: - Constants

extension CocktailsListViewController {
	enum Constants {
		static let cocktailCellIndetifier = "CocktailCell"
		static let header = "sectionHeader"
	}
}
