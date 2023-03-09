//
//  MixedViewsExample.swift
//  WrappingStackExample
//
//  Created by Tim Green on 09/03/2023.
//

import SwiftUI
import WrappingStack

struct MixedViewsExample: View {

    @State var lineSpacing: CGFloat = 12

    @State var itemSpacing: CGFloat = 8

    @State var arrangement: Arrangement = .bestFit

    @State var edgeAlignment: EdgeAlignment = .centre

    @State var axis: Axis = .horizontal

    var body: some View {
        WrappingHStack(itemSpacing: itemSpacing,
                       lineSpacing: lineSpacing,
                       arrangement: arrangement,
                       edgeAlignment: edgeAlignment) {

            Image("gptimage")
                .resizable()
                .frame(width: 45, height: 45)

            Text("Medium length text")

            Image("gptimage")
                .resizable()
                .frame(width: 100, height: 100)

            Button {
                print("")
            } label: {
                VStack {
                    Text("AAA")
                    Text("BBB")
                    Text("CCC")
                    Text("DDD")
                }
                .padding(5)
                .border(.black)
            }

            Image("gptimage")
                .resizable()
                .frame(width: 45, height: 45)

            Text("Small")

            Text("Some fairly lengthy text to force wrapping")

            Image("gptimage")
                .resizable()
                .frame(width: 45, height: 45)

            Button {
                print("")
            } label: {
                HStack {
                    Text("AAA")
                    Text("BBB")
                    Text("CCC")
                    Text("DDD")
                }
                .padding(5)
                .border(.black)
            }
        }
    }
}

struct MixedViewsExample_Previews: PreviewProvider {
    static var previews: some View {
        MixedViewsExample()
    }
}
