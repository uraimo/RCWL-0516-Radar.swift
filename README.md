# RCWL-0516-Radar.swift

*A Swift library for the RCWL-0516 Microwave Radar*

<p>
<img src="https://img.shields.io/badge/os-linux-green.svg?style=flat" alt="Linux-only" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat" alt="Swift 4 compatible" /></a>
<a href="https://raw.githubusercontent.com/uraimo/RCWL-0516-Radar.swift/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>
 
![RCWL-0516 animation](https://github.com/uraimo/RCWL-0516-Radar.swift/raw/master/radar.gif)

# Summary

With this simple library you'll be able to use a RCWL-0516 microwave radar to detect movements of humans(or animals) inside its detection range (4-7 meters all around and a few meters upward, depending on the module and `VIN`).

This sensor is an alternative to common PIR motion sensors that use infrared light to detect movements and that have their range limited by the reflective surfaces that surrounds them. The RCWL signal instead, can get through relatively thick surfaces made by non-metal materials (doors, windows, walls, etc...).

## Hardware Details

All the information available for this mysterious module have been discovered by Joe Desbonnet and collected [on GitHub](https://github.com/jdesbonnet/RCWL-0516). Check it out if you want to know more.

The module costs a few dollars and can work with a 5V `VIN` and has a 3.3V `OUT` output signal that allows us to connect it to a GPIO port of essentially any ARM board. 

An additional 3.3V output to power external devices and a light sensor input `CDS` are also available. Most of the times you'll just connect `VIN`, `GND` and then `OUT` to one of your GPIOs.

Each time the sensor detects movements, the `OUT` pin, that is normally at 0V when no motion is detected, is set to high (3.3V).

The radar does not give you information on the distance of the object that is moving and does not even give you an approximate location within its range, it just detect continuous motion or new objects entering its range.

Since the module uses a 3Ghz based signal, it will not cause any interference with other wireless devices.

Multiple modules can be used together in the same room.

Update 2024: If you are here because you want to know more about this sensor, check out [this link](https://news.ycombinator.com/item?id=40834349) and [this link](https://10maurycy10.github.io/projects/motion_sensor_hacking/).

## Usage
                                                                                                 
The library revolves around the `RCWL0516Radar` object. 

To create a `RCWL0516Radar` instance we just need to initialize the object with a GPIO instance obtained from [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO), that points to the board pin where `OUT` is connected (e.g. P18):

```swift
import SwiftyGPIO
import RCWL0516Radar

let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi2)
var gp = gpios[.P18]!

let r = RCWL0516Radar(gp)

// Check for motion every second
while(true){
    print(r.getStatus())
    sleep(1)
}
```

Calling `getStatus` we can know if the sensor is detecting movements or not (be aware that the sensor will need a second or so to understand that the motion has stopped).

To register handlers that will be called when some kind on motion starts or stops in the detection range, use `onMotion(closure:)` and `onMotionStop(closure:)`.

```swift
r.onMotion{
    print("Movement detected!")
}

r.onMotionStop{
    print("No more movement...")
}
```
Handlers can be unregistered calling `clearMotionHandlers()`.

## Supported Boards

Every board supported by [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO): RaspberryPis, BeagleBones, C.H.I.P., etc...

To use this library, you'll need a Linux ARM board with Swift 3.x/4.x.

The example below will use a RaspberryPi 2 board but you can easily modify the example to use one the other supported boards, a full working demo projects for the RaspberryPi2 is available in the `Examples` directory.


## Installation

Please refer to the [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO) readme for Swift installation instructions.

Once your board runs Swift, if your version support the Swift Package Manager, you can simply add this library as a dependency of your project and compile with `swift build`:

```swift
  let package = Package(
      name: "MyProject",
      dependencies: [
        .Package(url: "https://github.com/uraimo/RCWL-0516-Radar.swift.git", majorVersion: 2),
      ]
  ) 
```

The directory `Examples` contains sample projects that uses SPM, compile it and run the sample with `./.build/debug/Test`.

If SPM is not supported, you'll need to manually download the library and its dependencies: 

    wget https://raw.githubusercontent.com/uraimo/RCWL-0516-Radar.swift/master/Sources/RCWL0516Radar.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/SwiftyGPIO.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/Presets.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/SunXi.swift  

And once all the files have been downloaded, create an additional file that will contain the code of your application (e.g. main.swift). When your code is ready, compile it with:

    swiftc *.swift

The compiler will create a **main** executable.


