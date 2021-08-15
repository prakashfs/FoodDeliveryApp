//
//  FoodsAPI.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 14/8/21.
//

import Foundation

enum APIResponse {
    case success(FoodsAPIResponse)
    case failure(String)
}

class FoodsAPI {
    static let shared = FoodsAPI()
    
    func loadFoods(completion: @escaping (APIResponse) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            
            if let responseData = self.readMockResponse() {
                do {
                    if let foodsAPIResponse = try? JSONDecoder().decode(FoodsAPIResponse.self, from: responseData) {
                        completion(.success(foodsAPIResponse))
                    } else {
                        completion(.failure("No Response API"))
                    }
                }
            }
            
        }
    }
    
    func readMockResponse() -> Data? {
        
        guard let filePath = Bundle.main.url(forResource: "MockAPIResponse", withExtension: "json") else {
            return nil
        }
        
        do {
            let responseData = try? Data(contentsOf: filePath)
            return responseData
        }
        
    }
}
