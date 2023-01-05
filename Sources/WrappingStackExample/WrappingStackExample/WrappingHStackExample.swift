//
//  WrappingStackExample.swift
//  WrappingStackExample
//
//  Created by Tim Green on 16/12/2022.
//

import SwiftUI
import WrappingStack

struct WrappingHStackExample: View {

    @State var viewCount: Double = 3

    @State var lineSpacing: CGFloat = 6

    @State var itemSpacing: CGFloat = 12

    @State var arrangement: Arrangement = .bestFit

    @State var edgeAlignment: EdgeAlignment = .leading

    @State var axis: Axis = .horizontal

    //    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Spacer()

            ScrollView(axis == .horizontal ? .vertical : .horizontal) {
                view(for: axis)
                    .padding(2)
                    .border(.foreground)
                    .background(.gray.opacity(0.5))
                    .transition(.opacity.combined(with: .slide))
                    .animation(.default, value: viewCount)
                    .animation(.default, value: itemSpacing)
                    .animation(.default, value: arrangement)
                    .animation(.default, value: edgeAlignment)
            }

            Spacer()

            Picker("Stack Type", selection: $axis) {
                ForEach(Axis.allCases, id: \.self) { value in
                    Text(value.description)
                }
            }
            .pickerStyle(.segmented)

            Picker("Edge Alignment:", selection: $edgeAlignment) {
                ForEach(EdgeAlignment.allCases, id: \.self) { value in
                    Text(value.rawValue)
                }
            }
            .pickerStyle(.segmented)

            Picker("Arrangment:", selection: $arrangement) {
                ForEach(Arrangement.allCases, id: \.self) { value in
                    Text(value.rawValue)
                }
            }
            .pickerStyle(.segmented)

            VStack {
                Slider(value: $viewCount, in: 0...100, label: {
                    Text("View count: \(Int(viewCount))")
                })
                Stepper("Line spacing: \(Int(lineSpacing))", value: $lineSpacing, in: 0...40)
                Stepper("Item spacing: \(Int(itemSpacing))", value: $itemSpacing, in: 0...40)
            }
            .padding(.vertical, 8)
        }
        .padding()
        //        .onReceive(timer) { input in
        //             viewCount += 1
        //        }
    }

    @ViewBuilder
    func view(for axis: Axis) -> some View {
        let indices = Array<Int>(repeating: 0, count: Int(viewCount)).indices

        switch axis {
        case .horizontal:
            WrappingHStack(itemSpacing: itemSpacing,
                           lineSpacing: lineSpacing,
                           arrangement: arrangement,
                           edgeAlignment: edgeAlignment) {
                ForEach(indices, id: \.self) { index in
                    ExampleTextColorView(item: items[index%items.count])
                }
            }
        case .vertical:
            WrappingVStack(itemSpacing: itemSpacing,
                           lineSpacing: lineSpacing,
                           arrangement: arrangement,
                           edgeAlignment: edgeAlignment) {
                ForEach(indices, id: \.self) { index in
                    ExampleTextColorView(item: items[index%items.count])
                }
            }
        }
    }
}

struct WrappingStackExample_Previews: PreviewProvider {
    static var previews: some View {
        WrappingHStackExample()
    }
}
