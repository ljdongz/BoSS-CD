//
//  Category.swift
//  iOS
//
//  Created by JunHee on 2023/02/23.
//

import Foundation

struct CategoryData: Codable {
    var categories: [Category]
}

struct Category: Codable {
    var phid : Int?
    var category_name : String?
}

struct Category_Edit: Codable {
    var phid : Int?
    var category_name : String?
    var category_name_edit : String?
}

struct CategoryTypeData: Codable {
    var categoryTypes: [CategoryType]
}

struct CategoryType: Codable {
    var category_name : String?
}
