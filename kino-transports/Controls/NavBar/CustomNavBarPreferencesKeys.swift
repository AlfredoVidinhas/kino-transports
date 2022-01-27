//
//  CustomNavBarPreferencesKeys.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 27/01/22.
//

import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavigationBackButton(_ hidden: Bool) -> some View {
        preference(key: CustomNavBarBackButtonPreferenceKey.self, value: hidden)
    }
    
    func customNavBarItems(title: String, hidden: Bool = false) -> some View {
        self.customNavigationTitle(title)
            .customNavigationBackButton(hidden)
    }
}
