import SwiftyGPIO

class RCWL0516Radar{
    let gpio: GPIO

    public init(_ gpio:GPIO){
        self.gpio = gpio
    }

    public func getStatus() -> RCWL0516Motion {
        return (gpio.value == 1) ? .MotionDetected : .NoMotion
    }

    public func onMotion(_ closure: @escaping ()->Void) {
        gpio.onRaising({gpio in closure()})
    }

    public func onMotionStop(_ closure: @escaping ()->Void) {
        gpio.onFalling({gpio in closure()})
    }

    public func clearMotionHandlers(){
        gpio.clearListeners()
    }
}

enum RCWL0516Motion{
    case NoMotion
    case MotionDetected
}
