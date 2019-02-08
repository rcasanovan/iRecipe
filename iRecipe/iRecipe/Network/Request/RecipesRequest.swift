//
//  RecipesRequest.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

struct RecipesRequest: RequestProtocol {
    
    typealias ResponseType = RecipesResponse
    var completion: ((Result<RecipesResponse?>) -> Void)?
    var method: HTTPMethod = .get
    var url: URL?
    var encodableBody: Encodable?
    var simulatedResponseJSONFile: String?
    var verbose: Bool?
    var contentType: ContentType = .json
    var processHeader: Bool?
    var shouldRetry: Bool = true
    
    init(search: String?, page: UInt) {
        url = Endpoint.getRecipesWith(search: search, page: page).url
    }
    
}
