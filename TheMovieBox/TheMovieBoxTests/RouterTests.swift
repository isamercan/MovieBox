//
//  RouterTests.swift
//  TheMovieBoxTests
//
//  Created by isa Mercan on 22.12.2022.
//

import XCTest
@testable import TheMovieBox

class RouterTests: XCTestCase {
    var popularMovies: Router!
    
    override func setUp() {
        super.setUp()
        popularMovies = Router.popularMovies
    }
    
    override func tearDown() {
        popularMovies = nil
        super.tearDown()
    }
    
    func test_init_setBaseURL() {
        XCTAssertEqual(Router.baseUrl, NetworkConstants.baseUrl)
    }
    
    func test_initPopularMovies_setHttpMethod() {
            XCTAssertEqual(popularMovies.method, .get)
    }
    
    func test_initPopularMovies_setParameters() {
        XCTAssertEqual(popularMovies.parameters[NetworkParameterKeys.language.rawValue], NetworkConstants.language)
        XCTAssertEqual(popularMovies.parameters[NetworkParameterKeys.apiKey.rawValue], NetworkConstants.apiKey)
    }
}
