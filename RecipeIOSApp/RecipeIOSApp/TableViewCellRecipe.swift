//
//  TableViewCellRecipe.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/21/21.
//

import UIKit

protocol TableViewNew {
    func onClickView(index: Int)
}

class TableViewCellRecipe: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
