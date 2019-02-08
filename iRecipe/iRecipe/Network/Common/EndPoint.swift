//
//  EndPoint.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    var url: URL? { get }
}

/**
 * Internal struct for Url
 */
private struct Url {
    
    static let baseUrl: String = "http://www.recipepuppy.com/api/"
    
    struct Fields {
        static let page: String = "p"
        static let search: String = "q"
    }
    
}

// MARK: - Endpoints
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .getRecipesWith(let search, let page):
            var endpoint = "?\(Url.Fields.page)=\(page)"
            
            if let search = search, let searchWithUrlFormat = search.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                endpoint = "\(endpoint)&\(Url.Fields.search)=\(searchWithUrlFormat)"
            }
            
            return endpoint
        }
    }
    
    case getRecipesWith(search: String?, page: UInt)
    
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: Url.baseUrl + self.rawValue)
        return urlComponents?.url
    }
    
}
