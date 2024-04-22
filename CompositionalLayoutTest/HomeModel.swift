//
//  HomeModel.swift
//  CompositionalLayoutTest
//
//  Created by Zerom on 4/22/24.
//

import Foundation

struct HomeModel: Hashable {
    let title: String
    let desc: String?
    let imageUrl: String
    
    init(title: String, desc: String? = "", imageUrl: String) {
        self.title = title
        self.desc = desc
        self.imageUrl = imageUrl
    }
}
