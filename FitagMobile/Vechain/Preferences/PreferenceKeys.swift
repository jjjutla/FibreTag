import SwiftUI

struct scrollPref: PreferenceKey {
    static var defaultValue: CGFloat = 0.0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        defaultValue = nextValue()
    }
}
