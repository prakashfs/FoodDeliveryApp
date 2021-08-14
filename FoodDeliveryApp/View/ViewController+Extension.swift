//
//  ViewController+Extension.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 9/8/21.
//

import UIKit

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.collectionViewCellIdentifier, for: indexPath) as? FoodCollectionViewCell else {
            return UICollectionViewCell()
        }
        collectionViewCell.model = getFoodCellModel(indexPath.row)
        collectionViewCell.contentView.backgroundColor = .blue
        return collectionViewCell
        
    }
    
    func getFoodCellModel(_ row: Int) -> FoodCellModel {
        return FoodCellModel(image: nil,
                      imageName: "pizza_2",
                      name: "Deluxe",
                      details: "Chicken, ham, pepoperoni, tomato sauce, spicy charozo and mozzarella",
                      sizeInGrams: 150,
                      sizeInCm: 35,
                      price: 46)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.collectionViewHeaderIdentifier, for: indexPath) as? HomeImageSliderView else {
                return UICollectionReusableView()
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: (((collectionView.superview?.frame.height)!/3 * 2) + 50))
    }
}
