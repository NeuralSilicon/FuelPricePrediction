//Ian Cooper

import XCTest
@testable import FuelRate

class PasswordTests: XCTestCase {
    var encrytion:Encryption!
    
    
    override func setUpWithError() throws {
      try super.setUpWithError()
        encrytion = Encryption()
    }

    override func tearDownWithError() throws {
        encrytion = nil
      try super.tearDownWithError()
    }
    
    func testPrice() {
        
        XCTAssertNoThrow(try encrytion.aesDecrypt(KEY: "keykeykeykeykeyk", IV: "drowssapdrowssap", password: "Hello"))
        XCTAssertNoThrow(try encrytion.aesEncrypt(KEY: "keykeykeykeykeyk", IV: "drowssapdrowssap", password: "Hello"))
    }
    
    
}
