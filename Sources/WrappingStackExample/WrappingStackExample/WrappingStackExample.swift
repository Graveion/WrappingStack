//
//  WrappingStackExample.swift
//  WrappingStackExample
//
//  Created by Tim Green on 16/12/2022.
//

import SwiftUI
import WrappingStack

struct WrappingStackExample: View {

    @State var viewCount: Double = 3

    @State var rowSpacing: CGFloat = 6

    @State var itemSpacing: CGFloat = 12

    @State var arrangement: Arrangement = .bestFit

//    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()

    var body: some View {
        let indices = Array<Int>(repeating: 0, count: Int(viewCount)).indices

        VStack {
            Spacer()
            
            WrappingHStack(itemSpacing: itemSpacing,
                           rowSpacing: rowSpacing,
                           arrangement: arrangement) {
                ForEach(indices, id: \.self) { index in
                    ExampleTextColorView(item: items[index%items.count])
                }
            }
            .padding(2)
            .border(.foreground)
            .background(.gray.opacity(0.5))
            .transition(.opacity.combined(with: .slide))
            .animation(.default, value: viewCount)
            .animation(.default, value: itemSpacing)

            Spacer()

            Picker("Arrangment:", selection: $arrangement) {
                ForEach(Arrangement.allCases, id: \.self) { value in
                    Text(value.rawValue)
                }
            }
            .pickerStyle(.segmented)

            VStack {
                Slider(value: $itemSpacing, in: 0...20, step: 1)
                Text("Item spacing: \(Int(itemSpacing))")
            }
            .padding(.vertical, 8)

            VStack {
                Slider(value: $rowSpacing, in: 0...20, step: 1)
                Text("Row spacing: \(Int(rowSpacing))")
            }
            .padding(.vertical, 8)

            VStack {
                Slider(value: $viewCount, in: 0...90, step: 1)
                Text("View count: \(Int(viewCount))")
            }
            .padding(.vertical, 8)
        }
        .padding()
//        .onReceive(timer) { input in
//             viewCount += 1
//        }
    }

}

struct WrappingStackExample_Previews: PreviewProvider {
    static var previews: some View {
        WrappingStackExample()
    }
}
