//
//  StringUtils.swift
//  TouristPlaceSwiftUI
//
//  Created by Joshua on 10/10/24.
//

import Foundation

struct StringUtils {
    static func calculateTopCharacters(from listData: [String]) -> [(String, Int)] {
        let combinedString = listData.joined().lowercased()
        var charCounts: [Character: Int] = [:]

        combinedString.forEach { char in
            if char.isLetter {
                charCounts[char, default: 0] += 1
            }
        }

        let sortedCharCounts = charCounts.sorted { $0.value > $1.value }
        return sortedCharCounts.prefix(3).map { (String($0.key), $0.value) }
    }
}

