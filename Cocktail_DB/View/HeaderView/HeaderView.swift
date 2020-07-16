//
//  HeaderView.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 14.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
  
  let title = UILabel()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupContent()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupContent() {
    contentView.addSubview(title)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
    
    title.font = UIFont.Regular(size: 14)
    title.textColor = .gray
    contentView.backgroundColor = .white
  }
}
