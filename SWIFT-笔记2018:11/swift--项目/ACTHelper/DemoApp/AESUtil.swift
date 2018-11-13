//
//  AESUtil.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/5.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import Foundation

class AESUtil
{
    class func encrypt(encryptData:String) -> String
    {
        let originKey = "cakjpVPy6KlvmHiLO49dICXo7WMnsNJw"
        
        let date = Date()
        let year : Int = date.Year()
        let month : Int = date.Month()
        let result = year + month - 1
        let fullKey = "\(result)\(originKey)"
        let index = fullKey.index(fullKey.startIndex, offsetBy: 16)
        let key = fullKey.substring(to: index)
        
        let inputData : Data = encryptData.data(using: String.Encoding.utf8)!
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySizeAES128)
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeRawPointer((inputData as NSData).bytes)
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSizeAES128)!
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength = size_t(bufferData.length)
        var bytesDecrypted = Int(0)
        
        let cryptStatus = CCCrypt(UInt32(kCCEncrypt), UInt32(kCCAlgorithmAES128),
                                  UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding),
                                  keyBytes, keyLength, nil, dataBytes, dataLength,
                                  bufferPointer, bufferLength, &bytesDecrypted)
        
        if Int32(cryptStatus) == Int32(kCCSuccess)
        {
            bufferData.length = bytesDecrypted
            
            return bufferData.base64EncodedString(options: .init(rawValue: 0))
        }
        else
        {
            print("Error:\(cryptStatus)")
            return ""
        }
    }
}

extension NSData{
    func AES128Crypt(operation:CCOperation,keyData:NSData)->NSData?{
        
        let keyBytes        = keyData.bytes
        let keyLength       = Int(kCCKeySizeAES128)
        
        let dataLength      = self.length
        let dataBytes       = self.bytes
        
        let cryptLength     = Int(dataLength+kCCBlockSizeAES128)
        let cryptPointer    = UnsafeMutablePointer<UInt8>.allocate(capacity: cryptLength)
        
        let algoritm:  CCAlgorithm = CCAlgorithm(kCCAlgorithmAES128)
        let option:   CCOptions    = CCOptions(kCCOptionECBMode + kCCOptionPKCS7Padding)
        
        let numBytesEncrypted = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        numBytesEncrypted.initialize(to: 0)
        
        let cryptStatus = CCCrypt(operation, algoritm, option, keyBytes, keyLength, nil, dataBytes, dataLength, cryptPointer, cryptLength, numBytesEncrypted)
        
        if CCStatus(cryptStatus) == CCStatus(kCCSuccess) {
            let len = Int(numBytesEncrypted.pointee)
            let data:NSData = NSData(bytesNoCopy: cryptPointer, length: len)
            
            numBytesEncrypted.deallocate(capacity: 1)
            return data
            
        } else {
            numBytesEncrypted.deallocate(capacity: 1)
            cryptPointer.deallocate(capacity: cryptLength)
            
            return nil
        }
    }
}
