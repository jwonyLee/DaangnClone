//
//  VerticalScrollTableViewCell.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit
import SnapKit
import Then

class ThumbnailVerticalScrollTableViewCell: UITableViewCell {
    // MARK: - Properties
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    private var selectImages: [UIImage] = []

    // MARK: - View Properties
    let cameraButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
        $0.tintColor = .secondaryLabel
        $0.backgroundColor = .systemBackground
    }

    private lazy var thumbnailCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .systemBackground
        $0.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: ThumbnailCollectionViewCell.reuseIdentifier)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        configueViews()
        configureCameraButton()
        configureThumbnailCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func appendImage(with image: UIImage) {
        selectImages.append(image)
        thumbnailCollectionView.reloadData()
    }
}

// MARK: - Private
extension ThumbnailVerticalScrollTableViewCell {
    private func configueViews() {
        self.addSubview(cameraButton)
        self.addSubview(thumbnailCollectionView)
    }
    private func configureCameraButton() {
        cameraButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Styles.grid(8))
            $0.top.equalToSuperview().offset(Styles.grid(4))
            $0.trailing.equalTo(thumbnailCollectionView.snp.leading).offset(Styles.grid(-2))
            $0.bottom.equalToSuperview().offset(Styles.grid(-4))
            $0.width.equalTo(self.frame.height - Styles.grid(2))
            $0.height.equalTo(cameraButton.snp.width)
        }
    }

    private func configureThumbnailCollectionView() {
        thumbnailCollectionView.dataSource = self
        let itemSize: CGFloat = self.frame.height - Styles.grid(2)
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = Styles.grid(2)
            $0.minimumLineSpacing = Styles.grid(2)
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.itemSize = CGSize(width: itemSize, height: itemSize)
        }
        thumbnailCollectionView.collectionViewLayout = flowLayout

        thumbnailCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - CollectionView DataSource
extension ThumbnailVerticalScrollTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ThumbnailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionViewCell.reuseIdentifier, for: indexPath) as? ThumbnailCollectionViewCell else {
            return ThumbnailCollectionViewCell()
        }

        cell.thumbnailImageView.image = selectImages[indexPath.row]

        return cell
    }
}
