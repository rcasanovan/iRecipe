//
//  NetworkTests.swift
//  iRecipeTests
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import XCTest
@testable import iRecipe

typealias recipesCompletionBlock = (Result<RecipesResponse?>) -> Void

class NetworkTests: XCTestCase {
    
    private let requestManager = RequestManager()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRecipesResultsWith(search: String? = nil, page: UInt, simulatedJSONFile: String? = nil, completion: @escaping recipesCompletionBlock) {
        var recipesRequest = RecipesRequest(search: search, page: page)
        
        recipesRequest.completion = completion
        recipesRequest.simulatedResponseJSONFile = simulatedJSONFile
        recipesRequest.verbose = true
        requestManager.send(request: recipesRequest)
    }
    
    func testRecipesResults() {
        let recipesResultsExpectation: XCTestExpectation = self.expectation(description: "recipesResultsExpectation")
        
        testRecipesResultsWith(search: "pie", page: 1){ (response) in
            switch response {
            case .success(let response):
                guard let response = response else {
                    XCTFail("Impossible to get the response")
                    return
                }
                XCTAssert(response.results.count != 0, "data array can't be empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            recipesResultsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testRecipesNoSearchResults() {
        let recipesResultsExpectation: XCTestExpectation = self.expectation(description: "recipesResultsExpectation")
        
        testRecipesResultsWith(page: 1){ (response) in
            switch response {
            case .success(let response):
                guard let response = response else {
                    XCTFail("Impossible to get the response")
                    return
                }
                XCTAssert(response.results.count != 0, "data array can't be empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            recipesResultsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testSimulatedRecipesResults() {
        let recipesResultsExpectation: XCTestExpectation = self.expectation(description: "recipesResultsExpectation")
        
        testRecipesResultsWith(page: 1, simulatedJSONFile: "Recipes"){ (response) in
            switch response {
            case .success(let response):
                guard let response = response else {
                    XCTFail("Impossible to get the response")
                    return
                }
                XCTAssert(response.results.count != 0, "data array can't be empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            recipesResultsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }

}
