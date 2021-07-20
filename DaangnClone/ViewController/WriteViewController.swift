//
//  WriteViewController.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class WriteViewController: BaseViewController {
    // MARK: - Properties
    private let disposeBag: DisposeBag = DisposeBag()

    // MARK: - View Properties
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        $0.backgroundColor = .systemBackground
        $0.sectionHeaderHeight = 0
        $0.sectionFooterHeight = 0
        $0.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))
        $0.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureToolbar()
        configureTableView()
        bindTableView()
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

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func bindTableView() {
        Observable.just(["scroll", "title", "category", "price", "contents"])
            .bind(to: tableView.rx.items(cellIdentifier: "test", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
    }
}
