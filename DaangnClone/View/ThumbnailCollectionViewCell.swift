//
//  ThumbnailCollectionViewCell.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/22.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }

    // MARK: - View Properties
    private let thumbnailImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        configureThumbnailImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not beem implemented")
    }
}

// MARK: - Private
extension ThumbnailCollectionViewCell {
    private func configureView() {
        self.layer.cornerRadius = Styles.grid(1)
        self.layer.masksToBounds = true
    }
    private func configureThumbnailImageView() {
        self.addSubview(thumbnailImageView)

        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
