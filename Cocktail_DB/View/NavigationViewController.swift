//
//  NavigationViewController.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 15.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavBarShadow()
	}
	
	private func configureNavBarShadow() {
		navigationBar.shadowImage = UIImage()
		navigationBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
		navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
		navigationBar.layer.shadowRadius = 4.0
		navigationBar.layer.shadowOpacity = 1
		navigationBar.layer.masksToBounds = false
	}
}
