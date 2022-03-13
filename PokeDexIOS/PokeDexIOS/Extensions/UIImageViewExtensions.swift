//
//  UIImageViewExtensions.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 13/03/2022.
//

import Foundation
import UIKit

// MARK: - Load Image From URL

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
