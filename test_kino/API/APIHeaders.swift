//
//  APIHeaders.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Alamofire

enum APIHeaders {
    static let base: HTTPHeaders = [
        "x-rapidapi-key": "a8386cc56amsh478a280d4e92cebp107863jsn07d43f128108",
        "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com"
    ]
    
    static func with(type: String) -> HTTPHeaders {
        var headers = base
        headers.add(name: "Type", value: type)
        return headers
    }
}
