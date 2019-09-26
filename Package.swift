// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "RCWL0516Radar",
    products: [
        .library(
            name: "RCWL0516Radar",
            targets: ["RCWL0516Radar"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "RCWL0516Radar",
            dependencies: ["SwiftyGPIO"],
            path: ".",
            sources: ["Sources"])
    ]
)