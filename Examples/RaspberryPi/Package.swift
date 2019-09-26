// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TestRadar",
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
        .package(url: "https://github.com/uraimo/RCWL-0516-Radar.swift.git",from: "2.0.0")
    ],
    targets: [
        .target(name: "TestRadar", 
                dependencies: ["SwiftyGPIO","RCWL0516Radar"],
                path: "Sources")
    ]
) 