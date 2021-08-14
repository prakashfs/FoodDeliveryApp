//
//  FoodInfoCell.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 9/8/21.
//

import UIKit

struct FoodCellModel {
    var image: UIImage?
    var imageName: String?
    var name: String?
    var details: String?
    var sizeInGrams: Int?
    var sizeInCm: Int?
    var price: Double?
}

class FoodInfoCell: UICollectionViewCell {
    
    var foodImage: UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    var itemName: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    var itemDescription: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    var itemSizeLabel : UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    var itemPriceButton: UIButton {
        let priceButton = UIButton()
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        return priceButton
    }
    
    var model: FoodCellModel? {
        didSet {
            foodImage.image = UIImage(named: model?.imageName ?? "default")
            itemName.text = model?.name
            itemDescription.text = model?.details
            if let inGram = model?.sizeInGrams, let inCM = model?.sizeInCm {
                itemSizeLabel.text = "\(inGram) grams, \(inCM) cm"
            }
            itemPriceButton.setTitle("$ \(model?.price ?? 0 )", for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateCell()
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layer.zPosition = CGFloat(1000) // or any zIndex you want to set
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.updateCell()
    }
    
    fileprivate func createPriceButton(_ uiButton: UIButton) {
        uiButton.frame = CGRect(x: (self.contentView.frame.width/2) - 5,
                                    y: self.itemSizeLabel.frame.minY,
                                    width: self.contentView.frame.width/3,
                                    height: 50)
        uiButton.backgroundColor = .black
        uiButton.layer.cornerRadius = 25
        uiButton.setTitle("$ 13.50", for: .normal)
        uiButton.addTarget(self, action: #selector(addMe(_:)), for: .touchUpInside)
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
    
    func updateCell(){
        debugPrint("\(#function) called")
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        self.contentView.backgroundColor = .purple
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        addShaddowEffect()
        
        
        
//        foodImage = UIImageView(frame: CGRect(x: self.contentView.bounds.origin.x,
//                                                  y: self.contentView.bounds.origin.y,
//                                                  width: self.contentView.frame.width,
//                                                  height: self.contentView.frame.height/3 * 2))
        foodImage.contentMode = .scaleAspectFill
        
       // itemName = UILabel(frame: CGRect(x: self.contentView.bounds.origin.x, y: foodImage.frame.height + 5, width: self.contentView.frame.width, height: 20))
        itemName.font = UIFont.boldSystemFont(ofSize: 20)
        itemName.textColor = .black
        
        //itemDescription = UILabel(frame: CGRect(x: self.contentView.bounds.origin.x, y: itemName.frame.maxY + 5, width: self.contentView.frame.width, height: 80))
        itemDescription.font = UIFont.systemFont(ofSize: 18)
        itemDescription.textColor = .black
        itemDescription.numberOfLines = 2
        itemDescription.textAlignment = .left
        
        //itemSizeLabel = UILabel(frame: CGRect(x: self.contentView.bounds.origin.x, y: itemDescription.frame.maxY + 5, width: self.contentView.frame.width, height: 20))
        itemSizeLabel.font = UIFont.systemFont(ofSize: 18)
        itemSizeLabel.textColor = .black
        
        
        //itemPriceButton = UIButton()
        createPriceButton(itemPriceButton)
        
        self.contentView.addSubview(foodImage)
        self.contentView.addSubview(itemName)
        self.contentView.addSubview(itemDescription)
        self.contentView.addSubview(itemSizeLabel)
        self.contentView.addSubview(itemPriceButton)
        
//        foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12).isActive = true
//        foodImage.widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
//        foodImage.heightAnchor.constraint(equalToConstant: self.contentView.frame.height/3 * 2).isActive = true
//        foodImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
//        foodImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 12).isActive = true
    }
    
    @objc func addMe(_ sender: UIButton?) {
        debugPrint("\(#function) tapped")
    }
    
}
