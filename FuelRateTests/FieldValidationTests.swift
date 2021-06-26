
//Ian Cooper

import XCTest
@testable import FuelRate

class FieldValidationTests: XCTestCase {
    var validation:Validation!
    
    
    override func setUpWithError() throws {
      try super.setUpWithError()
        validation = Validation()
    }

    override func tearDownWithError() throws {
        validation = nil
      try super.tearDownWithError()
    }
    
    func testClient() {
 
        var client = Client()
        client.fullname = "Jack"
        client.password = "Abscss44$"
        client.username = "a@gmail.com"
        
        XCTAssertEqual(validation.validateformtextFields(fields: .fullname, client: client, address: nil),true, "Full name validation")
        
        XCTAssertEqual(validation.validateformtextFields(fields: .password, client: client, address: nil),true, "Password validation")
        
        XCTAssertEqual(validation.validateformtextFields(fields: .username, client: client, address: nil),true, "Username validation")
        
        XCTAssertNoThrow(validation.checkvalidation(client: client, address: nil, parent: UIViewController(), completed: {_ in
        }))
    }
    
    
    func testAddress() {
 
        var address = Address()
        address.addressLineOne = "25000 JK"
        address.addressLineTwo = "apt. 1066"
        address.city = "Houston"
        address.state = "TX"
        address.zipcode = "77000"
        
        XCTAssertEqual(validation.validateformtextFields(fields: .addressLineOne, client: nil, address: address),true, "Address line One validation")
        
        XCTAssertEqual(validation.validateformtextFields(fields: .addressLineTwo, client: nil, address: address),true, "Address line Two validation")
        
        XCTAssertEqual(validation.validateformtextFields(fields: .city, client: nil, address: address),true, "City One validation")
        
        XCTAssertEqual(validation.validateformtextFields(fields: .state, client: nil, address: address),true, "State One validation")
        
        XCTAssertEqual(validation.validateformtextFields(fields: .zipcode, client: nil, address: address),true, "Zipcode validation")
        
        XCTAssertNoThrow(validation.checkvalidation(client: nil, address: address, parent: UIViewController(), completed: {_ in
        }))
    }
    
    
    
}
