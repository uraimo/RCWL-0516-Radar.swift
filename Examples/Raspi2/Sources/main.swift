import SwiftyGPIO
import Foundation
import RCWL0516Radar

let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi2)
var gp = gpios[.P18]!

let r = RCWL0516Radar(gp)

// Check for motion every second
while(true){
    print(r.getStatus())
    sleep(1)
}

/*
r.onMotion{ gpio in
    print("Movement detected!")
}

r.onMotionStop{ gpio in
    print("No more movement...")
}

sleep(10)
*/
