//
//  ViewController+Extension.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 9/8/21.
//

import UIKit

protocol ProductUpdateDelegate {
    func addProduct()
    func loadProduct(type: FoodType?)
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let value = foodDashboardViewModel.parsedAPIresponse.value else { return 0 }
        return value.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.collectionViewCellIdentifier, for: indexPath) as? FoodCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        collectionViewCell.model = getFoodCellModel(indexPath.row)
        collectionViewCell.delegate = self
        collectionViewCell.contentView.backgroundColor = .blue
        return collectionViewCell
        
    }
    
    func getFoodCellModel(_ row: Int) -> FoodCellModel? {
        
        guard let value = foodDashboardViewModel.parsedAPIresponse.value else { return nil }
        let itemInfo = value[row]
        return FoodCellModel(image: nil,
                             imageName: itemInfo.imageName ,
                             name: itemInfo.name,
                             details: itemInfo.details,
                             sizeInGrams: itemInfo.sizeInGrams,
                             sizeInCm: itemInfo.sizeInCm,
                             price: itemInfo.price)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.collectionViewHeaderIdentifier, for: indexPath) as? HomeImageSliderView else {
                return UICollectionReusableView()
            }
            headerView.delegate = self
            return headerView
        }
        return UICollectionReusableView()
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: (((collectionView.frame.height)/3 * 2)))
    }
}

extension ViewController : ProductUpdateDelegate {
    
    func loadProduct(type: FoodType?) {
        guard let type = type else {
            return
        }
        self.foodDashboardViewModel.loadFoodItems(forType: type)
    }
    
    func addProduct() {
        self.floatingButton.addBadgeToButon(badge: self.floatingButton.badgeCount() + 1)
    }
}
