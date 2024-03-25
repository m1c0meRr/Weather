//
//  String + Extension.swift
//  Weather
//
//  Created by Sergey Savinkov on 24.03.2024.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
