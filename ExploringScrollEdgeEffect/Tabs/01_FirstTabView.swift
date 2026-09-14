//
//  01_FirstTabView.swift
//  ExploringScrollEdgeEffect
//
//  Created by Ockey on 2026/09/14.
//

import SwiftUI
import UIKit

struct FirstTabView: View {
    var body: some View {
        FirstTabRepresentable()
    }
}

struct FirstTabRepresentable: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = context.coordinator
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {}

    class Coordinator: NSObject, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            30
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            var content = UIListContentConfiguration.cell()
            content.text = String(indexPath.item)
            cell.contentConfiguration = content
            var background = UIBackgroundConfiguration.listCell()
            background.backgroundColor = UIColor.systemPink.withAlphaComponent(0.15)
            cell.backgroundConfiguration = background
            return cell
        }
    }
}

#Preview {
    TabView {
        Tab("Tab", systemImage: "list.bullet") {
            FirstTabView()
        }
    }
}
