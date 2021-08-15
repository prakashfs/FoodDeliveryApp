//
//  PizzaAPI.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 14/8/21.
//

import Foundation

class PizzaAPI {
    static let shared = PizzaAPI()
    
    func loadPizzas(completion: @escaping () -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            completion()
        }
    }
}
