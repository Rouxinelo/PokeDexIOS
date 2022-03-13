//
//  StringExtensions.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 13/03/2022.
//

import Foundation

// MARK: - Uppercase first letter of a String

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
