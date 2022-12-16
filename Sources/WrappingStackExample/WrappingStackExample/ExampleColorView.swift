//
//  ExampleColorView.swift
//  WrappingStackExample
//
//  Created by Tim Green on 16/12/2022.
//

import SwiftUI

struct ExampleColorView: View {

    let color: Color

    var body: some View {
        Text("Color: \(color.description) ")
            .font(.caption)
            .foregroundStyle(color)
            .colorInvert()
            .background(
                Rectangle()
                    .fill(color.opacity(0.8))
                    .cornerRadius(4)
            )
    }


}

struct ExampleColorView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleColorView(color: generateColor())
    }
}

func generateColor() -> Color {
    return Color(red: Double.random(in: 0...1),
                 green: Double.random(in: 0...1),
                 blue: Double.random(in: 0...1))
}
