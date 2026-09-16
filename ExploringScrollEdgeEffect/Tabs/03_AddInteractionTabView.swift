//
//  03_AddInteractionTabView.swift
//  ExploringScrollEdgeEffect
//
//  Created by Ockey on 2026/09/14.
//

import SwiftUI
import UIKit

struct AddInteractionTabView: View {
    var body: some View {
        AddInteractionTabRepresentable()
            .ignoresSafeArea(.container, edges: .vertical)
    }
}

struct AddInteractionTabRepresentable: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = context.coordinator

        // iOS 27以降は標準のステータスバー用Edge Effectを使う。
        if #available(iOS 27.0, *) {
            return collectionView
        }

        let container = UIView()
        let topSafeArea = UILayoutGuide()
        container.addLayoutGuide(topSafeArea)
        let topContainer = UIView()
        topContainer.isUserInteractionEnabled = false

        // 透明な画像で、見た目を変えずにEdge Effectの対象領域を作る。
        let image = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in }
        let topEdge = UIImageView(image: image)

        container.addSubview(collectionView)
        container.addSubview(topContainer)
        topContainer.addSubview(topEdge)

        for view in [collectionView, topContainer, topEdge] {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: container.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topSafeArea.topAnchor.constraint(equalTo: container.topAnchor),
            topSafeArea.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            topSafeArea.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            topSafeArea.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            // ぼかしが基準領域の下まで広がるため、上半分を画面外へずらす。
            topContainer.centerYAnchor.constraint(equalTo: container.topAnchor),
            topContainer.heightAnchor.constraint(equalTo: topSafeArea.heightAnchor),
            topContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topEdge.topAnchor.constraint(equalTo: topContainer.topAnchor),
            topEdge.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor),
            topEdge.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor),
            topEdge.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor),
        ])

        let interaction = UIScrollEdgeElementContainerInteraction()
        interaction.scrollView = collectionView
        interaction.edge = .top
        topContainer.addInteraction(interaction)
        collectionView.topEdgeEffect.style = .automatic

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    final class Coordinator: NSObject, UICollectionViewDataSource {
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
            AddInteractionTabView()
        }
    }
}
