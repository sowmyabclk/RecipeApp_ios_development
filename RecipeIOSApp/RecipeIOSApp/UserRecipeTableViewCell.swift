//
//  UserRecipeTableViewCell.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/23/21.
//

import UIKit

class UserRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var userRecipeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
