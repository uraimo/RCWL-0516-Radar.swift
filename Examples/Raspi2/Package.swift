import PackageDescription

let package = Package(
    name: "Test",
    dependencies: [
        .Package(url: "https://github.com/uraimo/RCWL-0516-Radar.swift.git",
                 majorVersion: 2)
    ]
)
