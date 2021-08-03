//
//  MealsTableViewCell.swift
//  TheMealDB
//
//  Created by mac on 02/08/21.
//

import UIKit

class MealsTableViewCell: UITableViewCell {

    @IBOutlet weak var mealView: UIView!
    @IBOutlet weak var IM_Meal: UIImageView!
    @IBOutlet weak var labelMeal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
