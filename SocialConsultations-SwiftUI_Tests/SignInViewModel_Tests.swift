//
//  SignInViewModel_Tests.swift
//  SocialConsultations-SwiftUI_Tests
//
//  Created by Paweł Rudnik on 12/12/2024.
//

import XCTest
@testable import SocialConsultations_SwiftUI

@MainActor
final class SignInViewModel_Tests: XCTestCase {
    
    var viewModel: SignInViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel = SignInViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testValidateInputs_AllValidInputs_ShouldReturnTrue() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.password = "password123"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.errorMessage?.message, nil)
    }
    
    func testValidateInputs_InvalidEmail_ShouldReturnFalse() {
        // Given
        viewModel.email = "j@nkow@lski@qwwerttyyr.com"
        viewModel.password = "password123"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter a valid email address.")
    }
    
    func testValidateInputs_EmptyPassword_ShouldReturnFalse() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.password = ""
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter your password.")
    }
    
    func testValidateInputs_AllInputsEmpty_ShouldReturnFalse() {
        // Given
        viewModel.email = ""
        viewModel.password = ""
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter your email address.")
    }
}
