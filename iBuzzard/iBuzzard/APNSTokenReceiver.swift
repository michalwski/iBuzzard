//
//  APNSTokenReceiver.swift
//  iBuzzard
//
//  Created by Krzysztof Profic on 26.08.2016.
//  Copyright © 2016 Trifork GmbH. All rights reserved.
//

import Foundation

class APNSTokenReceiver : NSObject {
    private let baseURL = NSURL(string: "https://10.152.1.17:9000/")!
    private var token: String!
    private let deviceID = "2af328b8d5e70039e858a99a2495210d98fb48563211d8b14a576cda6af9cd19"   // TODO this should be generated and saved in keychain to ensure its unique across app instalations
    
    private var con: NSURLConnection!
    
    func sendToken(token: String) {
        self.token = token
        let req = requestWithBaseURL(baseURL)
        
        con = NSURLConnection(request: req, delegate: self)
        con?.start()
    }
}

extension APNSTokenReceiver : NSURLConnectionDataDelegate {
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print("failed \(error)")
    }
    
    func connection(connection: NSURLConnection, willSendRequest request: NSURLRequest, redirectResponse response: NSURLResponse?) -> NSURLRequest? {
        print("will sent: \(request)")
        return request
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        print("response rec")
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        print("finished")
    }
    
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool {
        return true
    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        let credential = NSURLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        challenge.sender?.useCredential(credential, forAuthenticationChallenge: challenge)
        challenge.sender?.continueWithoutCredentialForAuthenticationChallenge(challenge)
    }
}
extension APNSTokenReceiver : URLRequestComponents {
    var path: String {
        return "device_token"
    }
    
    var method: RequestMethod {
        return .POST
    }
    
    var queryItems: [String: String]? {
        return nil
    }
    
    var body: NSData? {
        let obj = [
            "device": deviceID,
            "token": token,
        ]
        let data = try! NSJSONSerialization.dataWithJSONObject(obj, options: [])
        return data
    }
    
    var headers: [String: String] {
        return [:]
    }
}