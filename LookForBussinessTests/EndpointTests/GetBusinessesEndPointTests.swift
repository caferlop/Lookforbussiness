//
//  GetBusinessesEndPointTests.swift
//  LookForBussinessTests
//
//  Created by carlos fernandez on 23/9/21.
//

import XCTest
@testable import LookForBussiness

class GetBusinessesEndPointTests: XCTestCase {

    func testGetBusinessesEndPointByLocation() throws {
        let getBussinessRequest = GetBusinessesEndPoint.getBussinessByLocation(latitude: 0, longitude: 0)
        XCTAssertEqual(getBussinessRequest.method, .get)
        XCTAssertEqual(getBussinessRequest.url?.absoluteString, "https://api.yelp.com/v3/businesses/search?latitude=0.0&longitude=0.0")
        XCTAssertEqual(getBussinessRequest.headers["Authorization"], "Bearer I2KQ9R9SB2sCbL_bJDbIfY9kt-yZ4tb5WaY0_0qfRGm6TUcJ_KIVZb-J0D55idgomYvLe_xfYsoNkclIzWbnhLJn8oIKDI8dQ2uc1_RaVU1MjBWYvVrzRkO7QGZEYXYx")

    }
    
    func testGetBusinessesEndPointByTermAndLocation() throws {
        let getBussinessRequest = GetBusinessesEndPoint.getBusinessByTermAndLocation(term: "Food", latitude: 0, longitude: 0)
        XCTAssertEqual(getBussinessRequest.method, .get)
        XCTAssertEqual(getBussinessRequest.url?.absoluteString, "https://api.yelp.com/v3/businesses/search?term=Food&latitude=0.0&longitude=0.0")
        XCTAssertEqual(getBussinessRequest.headers["Authorization"], "Bearer I2KQ9R9SB2sCbL_bJDbIfY9kt-yZ4tb5WaY0_0qfRGm6TUcJ_KIVZb-J0D55idgomYvLe_xfYsoNkclIzWbnhLJn8oIKDI8dQ2uc1_RaVU1MjBWYvVrzRkO7QGZEYXYx")

    }
    
    func testGetBusinessesEndPointByTermAndLocationAndRadius() throws {
        let getBussinessRequest = GetBusinessesEndPoint.getBusinessByTermLocationAndRadius(term: "Food", latitude: 0, longitude: 0, radius: 100)
        XCTAssertEqual(getBussinessRequest.method, .get)
        XCTAssertEqual(getBussinessRequest.url?.absoluteString, "https://api.yelp.com/v3/businesses/search?term=Food&latitude=0.0&longitude=0.0&radius=100")
        XCTAssertEqual(getBussinessRequest.headers["Authorization"], "Bearer I2KQ9R9SB2sCbL_bJDbIfY9kt-yZ4tb5WaY0_0qfRGm6TUcJ_KIVZb-J0D55idgomYvLe_xfYsoNkclIzWbnhLJn8oIKDI8dQ2uc1_RaVU1MjBWYvVrzRkO7QGZEYXYx")

    }

}
