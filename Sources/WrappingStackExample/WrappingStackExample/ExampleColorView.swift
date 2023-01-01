//
//  ExampleColorView.swift
//  WrappingStackExample
//
//  Created by Tim Green on 16/12/2022.
//

import SwiftUI

struct ExampleColorView: View {

    let item: ExampleItem

    var body: some View {
        Text("\(item.text)")
            .font(.caption)
            .padding(3)
            .lightShadow(color: item.color)
            .colorInvert()
            .background(
                Rectangle()
                    .fill(item.color)
                    .cornerRadius(4)
            )

    }


}

struct ExampleColorView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleColorView(item: generateItems(count: 1).first!)
    }
}

struct ExampleItem {
    let text: String
    let color: Color
}

func generateColor() -> Color {
    return Color(red: Double.random(in: 0...1),
                 green: Double.random(in: 0...1),
                 blue: Double.random(in: 0...1))
}

func generateText() -> String {
    randomWords.randomElement()!
}

func generateItems(count: Int) -> [ExampleItem] {
    Array(repeating: 0, count: count).map { _ in
        ExampleItem(text: generateText(),
                    color: generateColor())

    }
}

let items = generateItems(count: 80)

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





struct LightShadow: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        content
            .foregroundStyle(.shadow(
                .drop(color: color, radius: 0.33, x: -0.30, y: 0.30)
                )
            )
    }
}

extension View {
    func lightShadow(color: Color = .secondary) -> some View {
        modifier(LightShadow(color: color))
    }
}
