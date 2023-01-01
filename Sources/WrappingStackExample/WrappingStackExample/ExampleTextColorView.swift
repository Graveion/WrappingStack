//
//  ExampleColorView.swift
//  WrappingStackExample
//
//  Created by Tim Green on 16/12/2022.
//

import SwiftUI

struct ExampleTextColorView: View {

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
        ExampleTextColorView(item: generateItems(count: 1).first!)
    }
}

struct ExampleItem {
    let text: String
    let color: Color
}








