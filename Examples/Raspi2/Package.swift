import PackageDescription

let package = Package(
    name: "Test",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/uraimo/RCWL-0516-Radar.swift.git",
                 majorVersion: 1)
    ]
)
