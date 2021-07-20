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
    private lazy var contentViewSize: CGSize = CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height)

    // MARK: - View Properties
    private lazy var scrollView: UIScrollView = UIScrollView(frame: .zero).then {
        $0.frame = self.contentView.bounds
        $0.contentSize = contentViewSize
        $0.alwaysBounceVertical = true
    }
    lazy var containerView: UIView = UIView().then {
        $0.frame.size = contentViewSize
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureScrollView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private
extension ThumbnailVerticalScrollTableViewCell {
    private func configureScrollView() {
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
}
