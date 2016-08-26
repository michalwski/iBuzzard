//
//  URLRequestComponents.swift
//  BI-Reporting
//
//  Created by Daniel Garbień on 15/06/16.
//  Copyright © 2016 Trifork GmbH. All rights reserved.
//

import Foundation

let JSONContentTypeHeader = ["Content-Type": "application/json"]

enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

protocol URLRequestComponents {
    
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [String: String]? { get }
    var body: NSData? { get }
    var headers: [String: String] { get }
}

extension URLRequestComponents {
    
    var method: RequestMethod { return .GET }
    var queryItems: [String: String]? { return nil }
    var body: NSData? { return nil }
    var headers: [String: String] { return JSONContentTypeHeader }
}

extension URLRequestComponents {
    
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest {
        let request = NSMutableURLRequest(URL: URLWithBaseURL(baseURL))
        request.HTTPMethod = method.rawValue
        request.HTTPBody = body
        headers.forEach { (header: (key: String, val: String)) in
            request.addValue(header.val, forHTTPHeaderField: header.key)
        }
        return request
    }
    
    private func URLWithBaseURL(baseURL: NSURL) -> NSURL {
        let URL = NSURL(string: path, relativeToURL: baseURL)!
        let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems?.map { NSURLQueryItem(name: $0.0, value: $0.1) } ?? nil
        return components.URL!
    }
}
