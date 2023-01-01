//
//  HStackExample.swift
//  WrappingStackExample
//
//  Created by Tim Green on 31/12/2022.
//

import SwiftUI

struct HStackExample: View {

    @State var viewCount: Double = 3

    @State var rowSpacing: CGFloat = 6

    @State var itemSpacing: CGFloat = 12

//    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()

    var body: some View {
        let indices = Array<Int>(repeating: 0, count: Int(viewCount)).indices

        VStack {
            Spacer()


            HStack() {
                ForEach(indices, id: \.self) { index in
                    ExampleTextColorView(item: items[index%items.count])
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
//        .onReceive(timer) { input in
//             viewCount += 1
//        }
    }

}

struct HStackExample_Previews: PreviewProvider {
    static var previews: some View {
        WrappingStackExample()
    }
}
