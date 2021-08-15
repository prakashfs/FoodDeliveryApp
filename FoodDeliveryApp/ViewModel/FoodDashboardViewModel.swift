//
//  FoodDashboardViewModel.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 14/8/21.
//

import Foundation
import RxSwift
import RxCocoa

enum FoodType: Int {
    case Pizza = 1
    case Sushi
    case Drinks
}

class FoodDashboardViewModel {
    
    var viewType:FoodType!
    var parsedAPIresponse = BehaviorRelay<[FoodCellModel]?>(value: nil)
    var disposeBag = CompositeDisposable()
    var apiResponseCache: FoodsAPIResponse?
    
    let foodsAPI = FoodsAPI.shared
    
    init(type: FoodType) {
        self.viewType = type
    }
    
    func loadFoodFromAPI(_ filter: FoodType) {
        foodsAPI.loadFoods { [weak self] response in
            guard let self = self else { return }
            switch response{
            case .success(let response) :
                self.apiResponseCache = response
                for food in response.foods {
                    if food.categoryCode == filter.rawValue {
                        let items = food.items
                        let pizzaItems = items.map { FoodCellModel(image: UIImage(named: $0.image),
                                                                   imageName: $0.image,
                                                                   name: $0.name,
                                                                   details: $0.itemDescription,
                                                                   sizeInGrams: $0.weight,
                                                                   sizeInCm: $0.size,
                                                                   price: Double($0.price)) }
                        self.parsedAPIresponse.accept(pizzaItems)
                    }
                }
            case .failure(let errorMessage) :
                debugPrint("API Error :: \(errorMessage)")
            }
        }
    }
    
    func loadFoodItems(forType: FoodType) {
        
        if let cachedResponse =  self.apiResponseCache {
            for food in cachedResponse.foods {
                if food.categoryCode == forType.rawValue {
                    let items = food.items
                    let pizzaItems = items.map { FoodCellModel(image: UIImage(named: $0.image),
                                                               imageName: $0.image,
                                                               name: $0.name,
                                                               details: $0.itemDescription,
                                                               sizeInGrams: $0.weight,
                                                               sizeInCm: $0.size,
                                                               price: Double($0.price)) }
                    self.parsedAPIresponse.accept(pizzaItems)
                }
            }
        } else {
            self.loadFoodFromAPI(forType)
        }
        
    }
    
}
