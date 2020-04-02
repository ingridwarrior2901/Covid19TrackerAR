//
//  IntExtensions.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

extension CGFloat {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
