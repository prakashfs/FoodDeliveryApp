//
//  CommonConstant.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 9/8/21.
//

import Foundation

struct Constant {
    static let collectionViewCellIdentifier = "FoodCollectionViewCell"
    static let collectionViewHeaderIdentifier = "foodHeaderCell"
    
}

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

