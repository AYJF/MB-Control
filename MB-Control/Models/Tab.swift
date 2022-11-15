//
//  Tab.swift
//  DesignCodeiOS15
//
//  Created by Meng To on 2021-11-05.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: AppRoute
    var color: Color
}

var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .Home, color: .teal),
    TabItem(text: "Explore", icon: "magnifyingglass", tab: .Explore, color: .blue),
    TabItem(text: "Notifications", icon: "bell", tab: .Notifications, color: .red),
    TabItem(text: "Profile", icon: "gear", tab: .Profile, color: .pink)
]

//enum Tab: String {
//    case home
//    case explore
//    case notifications
//    case profile
//}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
