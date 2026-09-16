//
//  00_IdealTabView.swift
//  ExploringScrollEdgeEffect
//
//  Created by Ockey on 2026/09/14.
//

import SwiftUI

struct IdealTabView: View {
    var body: some View {
        List(0..<30, id: \.self) { index in
            Text("\(index)")
                .listRowBackground(Color.pink.opacity(0.15))
        }
        .listStyle(.plain)
        .safeAreaBar(edge: .top, spacing: 0) {
            Color.white
                .frame(width: 1, height: 1)
        }
        .scrollEdgeEffectStyle(.automatic, for: .top)
    }
}

#Preview {
    TabView {
        Tab("Tab", systemImage: "list.bullet") {
            IdealTabView()
        }
    }
}
