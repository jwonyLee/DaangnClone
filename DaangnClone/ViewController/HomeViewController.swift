//
//  HomeViewController.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit
import SnapKit
import Then

class HomeViewController: BaseViewController {
    // MARK: - View Properties
    private let floatingButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .systemOrange
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 1.0
        $0.layer.shadowOpacity = 0.5
        $0.layer.masksToBounds = false
        $0.layer.shadowPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: $0.layer.cornerRadius).cgPath
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureFloatingButton()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        floatingButton.layer.cornerRadius = floatingButton.frame.size.height / 2
    }
}

// MARK: - Private
extension HomeViewController {
    private func configureFloatingButton() {
        view.addSubview(floatingButton)

        floatingButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-32)
            $0.width.equalTo(48)
            $0.height.equalTo(floatingButton.snp.width)
        }
    }
}
