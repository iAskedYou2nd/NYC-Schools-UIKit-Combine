//
//  Environment.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation

enum Environment {
    
    private struct NetworkPaths {
        static let schoolsPath = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        static let schoolSATPath = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    }
    
    private enum RequestType: String {
        case get = "GET"
        case post = "POST"
    }
    
    case schools
    case schoolDetails(_ dbn: String)
    
    var request: URLRequest? {
        switch self {
        case .schools:
            guard let url = URL(string: NetworkPaths.schoolsPath) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = RequestType.get.rawValue
            return request
        case .schoolDetails(let dbn):
            var components = URLComponents(string: NetworkPaths.schoolSATPath)
            let dbnQuery = URLQueryItem(name: "dbn", value: "\(dbn)")
            components?.queryItems = [dbnQuery]
            
            guard let url = components?.url else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = RequestType.get.rawValue
            return request
        }
    }
    
}
