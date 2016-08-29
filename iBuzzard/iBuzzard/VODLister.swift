//
//  VODLister.swift
//  iBuzzard
//
//  Created by Krzysztof Profic on 26.08.2016.
//  Copyright © 2016 Trifork GmbH. All rights reserved.
//

import Foundation

class VODLister : NSObject {
    private let baseURL = NSURL(string: "https://10.152.1.17:9000/")!
    
    private var con: NSURLConnection!
    
    func list() {
        let req = requestWithBaseURL(baseURL)
        
        con = NSURLConnection(request: req, delegate: self)
        con?.start()
    }
}

extension VODLister : NSURLConnectionDataDelegate {
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
extension VODLister : URLRequestComponents {
    var path: String {
        return "/motion_vod"
    }
    
    var method: RequestMethod {
        return .GET
    }
    
    var queryItems: [String: String]? {
        return nil
    }
    
    var body: NSData? {
        return nil
    }
    
    var headers: [String: String] {
        return [:]
    }
}