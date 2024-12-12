//
//  Extensions_Tests.swift
//  SocialConsultations-SwiftUI_Tests
//
//  Created by Paweł Rudnik on 12/12/2024.
//

import XCTest
@testable import SocialConsultations_SwiftUI

final class Extensions_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - String.fromISO8601toDate Tests
    
    func testFromISO8601toDate_ValidISO8601String_ShouldReturnCorrectDate() {
        // Given
        let iso8601String = "2024-12-12T16:00:00"
        
        // When
        let date = iso8601String.fromISO8601toDate()
        
        // Then
        XCTAssertNotNil(date)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date!)
        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.day, 12)
    }
    
    func testFromISO8601toDate_InvalidString_ShouldReturnNil() {
        // Given
        let invalidISO8601String = "Invalid date format"
        
        // When
        let date = invalidISO8601String.fromISO8601toDate()
        
        // Then
        XCTAssertNil(date)
    }
    
    //MARK: - String.toPrettyDateString() Tests
    
    func testToPrettyDateString_ValidISO8601StringWithoutAge_ShouldReturnFormattedDate() {
        // Given
        let iso8601String = "1998-01-15T00:00:00"
        
        // When
        let prettyDate = iso8601String.toPrettyDateString(showAge: false)
        
        // Then
        XCTAssertEqual(prettyDate, "15 January 1998")
    }
    
    func testToPrettyDateString_ValidISO8601StringWithAge_ShouldFail() {
        // Given
        let iso8601String = "1998-01-15T00:00:00"
        
        // When
        let prettyDate = iso8601String.toPrettyDateString(showAge: true)
        
        // Then
        XCTAssertNotEqual(prettyDate, "15 January 1998")
    }
    
    func testToPrettyDateString_ValidISO8601StringWithAge_ShouldReturnFormattedDateWithAge() {
        // Given
        let iso8601String = "2002-05-14T16:28:00"
        
        // When
        let prettyDate = iso8601String.toPrettyDateString(showAge: true)
        
        // Then
        XCTAssertEqual(prettyDate, "14 May 2002 (22)")
    }
    
    func testToPrettyDateString_ValidISO8601StringWithoutAge_ShouldFail() {
        // Given
        let iso8601String = "2002-05-14T16:28:00"
        
        // When
        let prettyDate = iso8601String.toPrettyDateString(showAge: false)
        
        // Then
        XCTAssertNotEqual(prettyDate, "14 May 2002 (22)")
    }
    
    func testToPrettyDateString_InvalidISO8601StringWithWrongAge_ShouldFail() {
        // Given
        let iso8601String = "2002-05-14T16:28:00"
        
        // When
        let prettyDate = iso8601String.toPrettyDateString(showAge: true)
        
        // Then
        XCTAssertNotEqual(prettyDate, "14 May 2002 (2)")
    }
    
    func testToPrettyDateString_InvalidISO8601StringWithAge_ShouldFail() {
        // Given
        let iso8601String = "18 maja dwa tysiace dwa"
        
        // When
        let prettyDate = iso8601String.toPrettyDateString(showAge: true)
        
        // Then
        XCTAssertEqual(prettyDate, "18 maja dwa tysiace dwa")
    }
    
    
    //MARK: - Date.toISO8601String() Tests
    
    func testToISO8601String_ValidDate_ShouldReturnISO8601String() {
        // Given
        var components = DateComponents()
        components.year = 2024
        components.month = 12
        components.day = 12
        components.hour = 15
        components.minute = 30
        components.second = 0
        let calendar = Calendar.current
        let date = calendar.date(from: components)!
        
        // When
        let iso8601String = date.toISO8601String()
        
        // Then
        XCTAssertEqual(iso8601String.count, 24)
        XCTAssertEqual(iso8601String, "2024-12-12T14:30:00.000Z")
    }
    
    func testToISO8601String_ValidDate_ShouldFail() {
        // Given
        var components = DateComponents()
        components.year = 2024
        components.month = 12
        components.day = 12
        components.hour = 15
        components.minute = 30
        components.second = 0
        let calendar = Calendar.current
        let date = calendar.date(from: components)!
        
        // When
        let iso8601String = date.toISO8601String()
        
        // Then
        XCTAssertNotEqual(iso8601String.count, 23)
        XCTAssertNotEqual(iso8601String, "2024-12-12")
    }
}
