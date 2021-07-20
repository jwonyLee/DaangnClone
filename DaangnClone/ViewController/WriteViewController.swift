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
        configureToolbar()
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

    @objc
    private func cancleButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    private func configureToolbar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: Styles.grid(11))))
        toolbar.sizeToFit()
        toolbar.tintColor = .label
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }

        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let neighborhoodRangeBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "당근동과 근처 동네 3개", style: .plain, target: self, action: nil)
        let frequentlyUsedPhrasesBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: nil)
        let hideKeyboardBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: nil)
        toolbar.setItems([neighborhoodRangeBarButtonItem, flexibleSpace, frequentlyUsedPhrasesBarButtonItem, hideKeyboardBarButtonItem], animated: true)
    }
}
