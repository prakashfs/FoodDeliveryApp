//
//  FoodCollectionViewCell.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 14/8/21.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodItemName: UILabel!
    @IBOutlet weak var foodItemDescription: UILabel!
    @IBOutlet weak var foodItemSize: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    var delegate: ProductUpdateDelegate?
    
    
    var model: FoodCellModel? {
        didSet {
            foodImageView.image = UIImage(named: model?.imageName ?? "default")
            foodItemName.text = model?.name
            foodItemDescription.text = model?.details
            if let inGram = model?.sizeInGrams, let inCM = model?.sizeInCm {
                foodItemSize.text = "\(inGram) grams, \(inCM) cm"
            }
            addToCartButton.setTitle("$ \(model?.price?.stringWithoutZeroFraction ?? "0")", for: .normal)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        addShaddowEffect()
        addRoundedRadius()
        self.addToCartButton.addTarget(self, action: #selector(addProductToCart), for: .touchUpInside)
    }
    
    @objc func addProductToCart() {
        if delegate != nil {
            delegate?.addProduct()
        }
    }
    
    fileprivate func addShaddowEffect() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 20
        self.layer.shouldRasterize = true
        self.layer.masksToBounds = false
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    
    
    fileprivate func addRoundedRadius() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    

}
