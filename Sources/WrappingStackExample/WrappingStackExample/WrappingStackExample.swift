//
//  WrappingStackExample.swift
//  WrappingStackExample
//
//  Created by Tim Green on 16/12/2022.
//

import SwiftUI
import WrappingStack

struct WrappingStackExample: View {

    @State var viewCount: Double = 9

    @State var rowSpacing: CGFloat = 5

    @State var itemSpacing: CGFloat = 1

    let timer = Timer.publish(every: 0.026, on: .main, in: .common).autoconnect()

    var body: some View {
        let indices = Array<Int>(repeating: 0, count: Int(viewCount)).indices

        VStack {
            Spacer()
            
            WrappingHStack(itemSpacing: itemSpacing, rowSpacing: rowSpacing) {
                ForEach(indices, id: \.self) { index in
                    ExampleColorView(item: items[index%items.count])
                }
            }
            .padding(2)
            .border(.foreground)
            .background(.gray.opacity(0.5))
            .transition(.opacity)
            .animation(.default, value: viewCount)

            Spacer()

            VStack {
                Slider(value: $itemSpacing, in: 0...20, step: 1)
                Text("Item spacing: \(Int(itemSpacing))")
            }
            .padding(.vertical, 15)

            VStack {
                Slider(value: $rowSpacing, in: 0...20, step: 1)
                Text("Row spacing: \(Int(rowSpacing))")
            }
            .padding(.vertical, 15)

            VStack {
                Slider(value: $viewCount, in: 0...30, step: 1)
                Text("View count: \(Int(viewCount))")
            }
            .padding(.vertical, 15)
        }
        .padding()
        .onReceive(timer) { input in
            itemSpacing += 0.1
        }
    }

}

struct WrappingStackExample_Previews: PreviewProvider {
    static var previews: some View {
        WrappingStackExample()
    }
}
