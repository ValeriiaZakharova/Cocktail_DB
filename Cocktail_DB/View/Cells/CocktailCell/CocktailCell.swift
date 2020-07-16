//
//  CocktailCell.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 14.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class CocktailCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      setupStyle()
    }
    
  func setupStyle() {
    nameLabel.font = UIFont.Regular(size: 16)
    nameLabel.textColor = .gray
  }
    
  override func prepareForReuse() {
		super.prepareForReuse()
    nameLabel.text = nil
    pictureImageView.image = nil
  }
}
