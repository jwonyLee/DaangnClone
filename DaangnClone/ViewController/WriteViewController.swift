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
    private let tableCellType: Observable<[MultipleCellType]> = Observable.just([.thumbnailVerticalScroll, .inputText, .category, .price])

    // MARK: - View Properties
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(ThumbnailVerticalScrollTableViewCell.self, forCellReuseIdentifier: ThumbnailVerticalScrollTableViewCell.reuseIdentifier)
        $0.register(InputTextTableViewCell.self, forCellReuseIdentifier: InputTextTableViewCell.reuseIdentifier)
        $0.register(PriceTableViewCell.self, forCellReuseIdentifier: PriceTableViewCell.reuseIdentifier)
        $0.backgroundColor = .systemBackground
        $0.sectionHeaderHeight = 0
        $0.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))

    }

    private let contentsTextView: UITextView = UITextView().then {
        $0.isEditable = true
        $0.text = """
            당근동에 올릴 게시글 내용을 작성해주세요.(가품 및 판매 금지품목은 게시가 제한될 수 있어요.)
            """
        $0.textColor = .tertiaryLabel
        $0.font = UIFont.preferredFont(forTextStyle: .body)
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
        tableView.delegate = self
        contentsTextView.delegate = self

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func bindTableView() {
        tableCellType
            .bind(to: tableView.rx.items) { tableView, _, cellType in
                switch cellType {
                case .thumbnailVerticalScroll:
                    let cell: ThumbnailVerticalScrollTableViewCell = tableView.dequeueReusableCell(withIdentifier: ThumbnailVerticalScrollTableViewCell.reuseIdentifier) as? ThumbnailVerticalScrollTableViewCell ?? ThumbnailVerticalScrollTableViewCell()
                    return cell
                case .inputText:
                    let cell: InputTextTableViewCell = tableView.dequeueReusableCell(withIdentifier: InputTextTableViewCell.reuseIdentifier) as? InputTextTableViewCell ?? InputTextTableViewCell()
                    cell.configurePlaceholder(with: "글 제목")
                    return cell
                case .category:
                    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryReuseIdentifier") ?? UITableViewCell()
                    cell.textLabel?.text = "카테고리 선택"
                    cell.accessoryType = .disclosureIndicator
                    return cell
                case .price:
                    let cell: PriceTableViewCell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.reuseIdentifier) as? PriceTableViewCell ?? PriceTableViewCell()
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Multiple Cell Type
enum MultipleCellType {
    case thumbnailVerticalScroll
    case inputText
    case category
    case price
}

// MARK: - TableView Delegate
extension WriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        tableView.frame.height - tableView.contentSize.height
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        contentsTextView
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .tertiaryLabel {
            textView.text = nil
            textView.textColor = .label
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "당근동에 올릴 게시글 내용을 작성해주세요.(가품 및 판매 금지품목은 게시가 제한될 수 있어요.)"
            textView.textColor = .tertiaryLabel
        }
    }
}
