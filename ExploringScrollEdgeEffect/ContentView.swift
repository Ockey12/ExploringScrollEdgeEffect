import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Ideal", systemImage: "list.bullet") {
                IdealTabView()
            }

            Tab("First", systemImage: "list.bullet") {
                FirstTabView()
            }

            Tab("Second", systemImage: "list.bullet") {
                SecondTabView()
            }

            Tab("Interaction", systemImage: "list.bullet") {
                AddInteractionTabView()
            }
        }
    }
}

#Preview {
    ContentView()
}
