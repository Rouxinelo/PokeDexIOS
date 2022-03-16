//
//  ResultResponse.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 16/03/2022.
//

import Foundation

public enum ResultResponse<T> {
    case success(T)
    case error(ErrorModel)
}

public enum ErrorModel: String {
    case notFound = "not found"
}
