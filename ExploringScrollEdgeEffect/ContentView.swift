import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("First", systemImage: "list.bullet") {
                FirstTabView()
            }

            Tab("Second", systemImage: "list.bullet") {
                SecondTabView()
            }
        }
    }
}

#Preview {
    ContentView()
}
