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
            HStack(alignment: .bottom) {
                ForEach(indices, id: \.self) { index in
                    ExampleTextColorView(item: items[index%items.count])
                }
            }
            .padding(2)
            .border(.foreground)
            .background(.gray.opacity(0.5))
            .transition(.opacity)
            .animation(.default, value: viewCount)
        }
        .padding()
//        .onReceive(timer) { input in
//             viewCount += 1
//        }
    }

}

struct HStackExample_Previews: PreviewProvider {
    static var previews: some View {
        HStackExample()
    }
}
