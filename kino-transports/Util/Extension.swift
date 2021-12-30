//
//  Extension.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 28/12/21.
//

import SwiftUI

extension UIDevice {
    var hasTopNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
