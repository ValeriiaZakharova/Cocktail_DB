//
//  FilterCell.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 14.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
	
	@IBOutlet weak var filterLabel: UILabel!
	
	@IBOutlet weak var checkmarkImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupStyle()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		checkmarkImageView.isHidden = !isSelected
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		return checkmarkImageView.isHidden = !selected
	}
	
	func setupStyle() {
		filterLabel.font = UIFont.Regular(size: 16)
		filterLabel.textColor = .gray
	}
}
