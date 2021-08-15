//
//  FoodsAPIResponse.swift
//  FoodDeliveryApp
//
//  Created by Prakash Sengirayar on 15/8/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let foodsAPIResponse = try? newJSONDecoder().decode(FoodsAPIResponse.self, from: jsonData)

import Foundation

// MARK: - FoodsAPIResponse
struct FoodsAPIResponse: Codable {
    let foods: [Food]

    enum CodingKeys: String, CodingKey {
        case foods = "Foods"
    }
}

// MARK: - Food
struct Food: Codable {
    let categoryCode: Int
    let categoryName: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case categoryCode = "category_code"
        case categoryName = "category_name"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let type: String
    let typeCode: Int
    let name, image, itemDescription: String
    let weight: Int
    let weightUnit: WeightUnit
    let size: Int
    let sizeUnit: SizeUnit
    let price: Int

    enum CodingKeys: String, CodingKey {
        case type
        case typeCode = "type_code"
        case name, image
        case itemDescription = "description"
        case weight
        case weightUnit = "weight_unit"
        case size
        case sizeUnit = "size_unit"
        case price
    }
}

enum SizeUnit: String, Codable {
    case cm = "cm"
}

enum WeightUnit: String, Codable {
    case grams = "grams"
    case ml = "ml"
}

