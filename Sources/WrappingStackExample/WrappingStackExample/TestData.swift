//
//  TestData.swift
//  WrappingStackExample
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI


extension Color {
    static func randomColor() -> Color {
        return Color(red: Double.random(in: 0...1),
                     green: Double.random(in: 0...1),
                     blue: Double.random(in: 0...1))
    }
}

func generateItems(count: Int) -> [ExampleItem] {
    Array(repeating: 0, count: count).map { _ in
        ExampleItem(text: randomWords.randomElement()!,
                    color: Color.randomColor())

    }
}

let items = generateItems(count: 500)

let randomWords = ["boar",
                   "whiplash",
                   "colonists",
                   "spicy",
                   "provoked",
                   "irrevocably",
                   "tenancy",
                   "user",
                   "runes",
                   "shook",
                   "played",
                   "aliens",
                   "blended",
                   "booking",
                   "aides",
                   "inventions",
                   "squirrel",
                   "polyacrylamide",
                   "pinkerton",
                   "decimation",
                   "justifying",
                   "inquisition",
                   "portcullis",
                   "subcontracting",
                   "average",
                   "vandals",
                   "revisit",
                   "marinade",
                   "inroads",
                   "swine",
                   "loot",
                   "much",
                   "to",
                   "the",
                   "boo",
                   "on",
                   "and",
                   "homeland",
                   "panic",
                   "sentiment",
                   "park",
                   "use",
                   "denial",
                   "original",
                   "carriage",
                   "witness",
                   "dealer",
                   "update",
                   "responsibility",
                   "characteristic",
                   "understanding",
                   "preoccupation",
                   "investigation",
                   "revolutionary",
                   "demonstration",
                   "recommendation",
                   "infrastructure",
                   "constellation",
                   "representative",
                   "administration",
                   "characteristic",
                   "discrimination",
                   "infrastructure",
                   "extraterrestrial",
                   "disappointment",
                   "superintendent",
                   "responsibility",
                   "rehabilitation"]
