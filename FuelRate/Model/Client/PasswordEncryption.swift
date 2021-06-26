
//Ian cooper

import UIKit
import CryptoSwift


class Encryption{
    
    func aesEncrypt(KEY:String, IV:String, password:String) throws -> String {
        let encrypted = try AES(key: KEY, iv: IV, padding: .pkcs7).encrypt([UInt8](password.data(using: .utf8)!))
        return Data(encrypted).base64EncodedString()
    }

    func aesDecrypt(KEY:String, IV:String, password:String) throws -> String {
        guard let data = Data(base64Encoded: password) else { return "" }
        let decrypted = try AES(key: KEY, iv: IV, padding: .pkcs7).decrypt([UInt8](data))
        return String(bytes: decrypted, encoding: .utf8) ?? password
    }
}


