//
//  UserLogin_Tests.swift
//  UserLogin_Tests
//
//  Created by Reenad gh on 11/06/1444 AH.
import XCTest


// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure : test_[struct or class]_[varible or function]_[expected result]


@testable import UserLogin

class UserLogin_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    // Should Be Pass
    func test_FirebaseLogInManager_passwordAndMailOrPhone_shouldNotEmpty(){
        
        let password = ""
        let mail = ""
        let phone = ""

        
        let vm = FirebaseLogInManager()
        vm.password = password
        vm.mail = mail
        vm.phone = phone

        vm.logInToAccount()
        
        XCTAssertEqual(vm.loadingState, .failed(error: "please fill mail or password filed "))
        
    }
    
    
    //check if the entering value of phone textFielid is a number
    // this examble give a string value and should be give an error of not valid number
    
    func test_FirebaseLogInManager_phone_shouldBePhoneNumber(){
        
        let phone = "justAStringValue"
        let vm = FirebaseLogInManager()
        vm.phone = phone
        vm.logInToAccount()
        XCTAssertEqual(vm.loadingState, .failed(error: "invalid phone number"))
    }
    func test_FirebaseLogInManager_phone_shouldBe9DigitNumber(){
        
        let phone = "43211"
        let vm = FirebaseLogInManager()
        vm.phone = phone
        vm.logInToAccount()
        XCTAssertEqual(vm.loadingState, .failed(error: "invalid phone number"))
    }
    
    func test_FirebaseLogInManager_mail_shouldBeValied(){
        
        let phone = "43211"
        let vm = FirebaseLogInManager()
        vm.phone = phone
        vm.logInToAccount()
        XCTAssertEqual(vm.loadingState, .failed(error: "invalid phone number"))
    }

    
    // Should Be Pass
    // ??
    func test_FirebaseLogInManager_passwordAndMail_LogInToAccount(){
        
        let mail = "1@1.com"
        let password = "123123"

        
        let vm = FirebaseLogInManager()
        vm.mail = mail
        vm.password = password
        
        
        vm.logInToAccount()
        
        XCTAssertNotNil(vm.auth.currentUser?.uid)
        
    }

    // Should Be Pass
    func test_FirebaseLogInManager_phone_shouldBeNumber(){

        let phone = UUID().uuidString
        let vm = FirebaseLogInManager()
        vm.phone = phone

        vm.logInToAccount()
        
        XCTAssertNil(vm.verificationID)
    

        
    }


}
