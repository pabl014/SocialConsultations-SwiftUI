//
//  SignUpViewModel_Tests.swift
//  SocialConsultations-SwiftUI_Tests
//
//  Created by Paweł Rudnik on 12/12/2024.
//

import XCTest
@testable import SocialConsultations_SwiftUI

final class SignUpViewModel_Tests: XCTestCase {
    
    var viewModel: SignUpViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel = SignUpViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testValidateInputs_AllValidInputs_ShouldReturnTrue() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.name = "Jan"
        viewModel.surname = "Kowalski"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testValidateInputs_EdgeCaseMinimum_ShouldReturnTrue() {
        // Given
        viewModel.email = "j@q.com"
        viewModel.name = "J"
        viewModel.surname = "K"
        viewModel.password = "passwor"
        viewModel.confirmPassword = "passwor"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testValidateInputs_EdgeCaseMaximum_ShouldReturnTrue() {
        // Given
        viewModel.email = "jankowalskijankowalskijankowalskijankowalski@qwwerttyyrqwwerttyyrqwwerttyyr.com"
        viewModel.name = String(repeating: "J", count: 20)
        viewModel.surname = String(repeating: "K", count: 30)
        viewModel.password = String(repeating: "p", count: 20)
        viewModel.confirmPassword = String(repeating: "p", count: 20)
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testValidateInputs_EmptyEmail_ShouldReturnFalse() {
        // Given
        viewModel.email = ""
        viewModel.name = "Jan"
        viewModel.surname = "Kowalski"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter your email address.")
    }
    
    func testValidateInputs_NameTooLong_ShouldReturnFalse() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.name = String(repeating: "a", count: 21)
        viewModel.surname = "Kowalski"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Name must be between 1 and 20 characters.")
    }
    
    func testValidateInputs_SurnameTooLong_ShouldReturnFalse() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.name = "Jan"
        viewModel.surname = String(repeating: "a", count: 31)
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Surname must be between 1 and 30 characters.")
    }
    
    func testValidateInputs_PleaseEnterPassword_ShouldReturnFalse() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.name = "Jan"
        viewModel.surname = "Kowalski"
        viewModel.password = ""
        viewModel.confirmPassword = "password123"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter your password.")
    }
    
    func testValidateInputs_PleaseConfirmPassword_ShouldReturnFalse() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.name = "Jan"
        viewModel.surname = "Kowalski"
        viewModel.password = "password123"
        viewModel.confirmPassword = ""
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Please confirm your password.")
    }
    
    func testValidateInputs_PasswordsDoNotMatch_ShouldReturnFalse() {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.name = "Jan"
        viewModel.surname = "Kowalski"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password1234"
        
        // When
        let result = viewModel.testValidateInputs()
        
        // Then
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage?.message, "Passwords do not match.")
    }
    
    
    func testCreateUser_EmptyEmail_ShouldSetErrorMessage() async {
        // Given
        viewModel.email = ""
        viewModel.name = "Jan"
        viewModel.surname = "Kowalski"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // When
        await viewModel.createUser()
        
        // Then
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter your email address.")
        XCTAssertFalse(viewModel.isSignUpSuccessful)
    }
    
    func testCreateUser_InvalidEmailFormat_ShouldSetErrorMessage() async {
        // Given
        viewModel.email = "j@nk@w@lski@j@g@.com"
        viewModel.name = "Jan"
        viewModel.surname = "Kowalski"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // When
        await viewModel.createUser()
        
        // Then
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter a valid email address.")
        XCTAssertFalse(viewModel.isSignUpSuccessful)
    }
    
    func testCreateUSer_EmptyName_ShouldSetErrorMessage() async {
        // Given
        viewModel.email = "jankowalski@qwwerttyyr.com"
        viewModel.name = ""
        viewModel.surname = "Doe"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // When
        await viewModel.createUser()
        
        XCTAssertEqual(viewModel.errorMessage?.message, "Please enter your name.")
    }
}
