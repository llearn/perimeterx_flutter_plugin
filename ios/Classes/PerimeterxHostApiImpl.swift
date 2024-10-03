//
//  PerimeterxHostApiImpl.swift
//  perimeterx_flutter_plugin
//
//  Created by Arthur Monteiro Alves Melo on 03/10/24.
//

import Foundation
import PerimeterX_SDK

class PerimeterXHostApiImpl : PerimeterXHostApi {
    func getHeaders() throws -> [String : String] {
        PerimeterX.headersForURLRequest(forAppId: nil) ?? [:]
    }
    
    func handleResponse(response: String, url: String, completion: @escaping (Result<String, any Error>) -> Void) {
        if let data = response.data(using: .utf8), let url = URL(string:url), let httpURLResponse = HTTPURLResponse(url: url, statusCode: 403, httpVersion: nil, headerFields: nil) {
            let handleResponse = PerimeterX.handleResponse(response: httpURLResponse,data: data) {
            challengeResult in
            completion(.success(challengeResult == .solved ? "solved" : "cancelled"))
            }
            
            if !handleResponse {
                completion(.success("failed"))
            }
        } else {
            completion(.success("failed"))
        }
    }
}
