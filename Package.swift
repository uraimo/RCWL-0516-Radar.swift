import PackageDescription

let package = Package(
    name: "RCWL0516Radar",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/uraimo/SwiftyGPIO.git",
                 majorVersion: 0)
    ]
)
