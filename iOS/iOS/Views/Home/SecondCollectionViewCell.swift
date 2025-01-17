//
//  SecondCollectionViewCell.swift
//  iOS
//
//  Created by 박다미 on 2023/01/21.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var tripImage: UIImageView!
    
    @IBOutlet weak var tripTitle: UILabel!
    
    @IBOutlet weak var tripDate: UILabel!
    
    @IBOutlet weak var tripCost: UILabel!
    
    @IBOutlet weak var outView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        
        
    }
    public func configure() {
        
        outView.backgroundColor = UIColor.white
        outView.layer.cornerRadius = 10
        outView.layer.borderWidth = 2
        outView.layer.borderColor = UIColor.gray.cgColor
        outView.alpha = 0.6
        tripImage.layer.cornerRadius = 5
        tripImage.layer.borderWidth = 3
        tripImage.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.8, alpha: 0.5).cgColor

    }

}
