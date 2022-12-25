//
//  WrappingStackExampleApp.swift
//  WrappingStackExample
//
//  Created by Tim Green on 16/12/2022.
//

import SwiftUI

@main
struct WrappingStackExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//@main
//struct PerformanceTestApp {
//    static func main() {
//        _TestApp().runBenchmarks([Benchmark()])
//    }
//}


struct Benchmark: _Benchmark {
    func measure(host: _BenchmarkHost) -> [Swift.Double] {
        return [
            host.measureAction {
                PerformanceTest()
                    .runTest(host: host, options: [:])
            },
            host.measureAction {
                PerformanceTest2().runTest(host: host, options: [:])
            }
//            host.measureAction {
//                PerformanceTest3().runTest(host: host, options: [:])
//            },
        ]
    }
}


struct PerformanceTest: _PerformanceTest {
    var name = "Basic Performance Test"

    func runTest(host: SwiftUI._BenchmarkHost, options: [Swift.AnyHashable : Any]) {
        let test = _makeUIHostingController(AnyView(PerformanceTestView(viewCount: 1000))) as! UIHostingController<AnyView>
        test.setUpTest()
        test.render()
        test.tearDownTest()
    }
}

struct PerformanceTest2: _PerformanceTest {
    var name = "Basic Performance Test"

    func runTest(host: SwiftUI._BenchmarkHost, options: [Swift.AnyHashable : Any]) {
        let test = _makeUIHostingController(AnyView(PerformanceTestView(viewCount: 1000,
                                                                        arrangement: .bestFit)
        )) as! UIHostingController<AnyView>
        test.setUpTest()
        test.render()
        test.tearDownTest()
    }
}

extension UIHostingController: _Test where Content == AnyView {}
extension UIHostingController: _ViewTest where Content == AnyView {
    public func initRootView() -> AnyView {
        return rootView
    }
    public func initSize() -> CGSize {
        sizeThatFits(in: UIScreen.main.bounds.size)
    }
}
