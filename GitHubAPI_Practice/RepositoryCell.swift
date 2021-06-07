//
//  RepositoryCellTableViewCell.swift
//  GitHubAPI_Practice
//
//  Created by daiki umehara on 2021/06/07.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
}
// MARK: - setup
extension RepositoryCell {
    func setup(_ repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
    }
}
