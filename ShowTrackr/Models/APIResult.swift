//
//  Movie.swift
//  ShowTrackr
//
//  Created by abatjarg on 12/11/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import Foundation

struct APIResult: Decodable {
    let page: Int
    let total_results: Int?
    let total_pages: Int?
    let results: [ShowItem]
}
