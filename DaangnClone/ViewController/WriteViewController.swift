//
//  WriteViewController.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit

class WriteViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    }
}

// MARK: - Private
extension WriteViewController {
    private func configureNavigation() {
        self.title = "중고거래 글쓰기"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
    }

    @objc private func cancleButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
