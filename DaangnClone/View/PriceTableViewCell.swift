//
//  PriceTableViewCell.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit
import SnapKit
import Then

class PriceTableViewCell: UITableViewCell {
    // MARK: - Properties
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }

    // MARK: - View Properties
    private let krwLabel: UILabel = UILabel().then {
        $0.text = "₩ "
        $0.textColor = .tertiaryLabel
    }
    private let priceTextField: UITextField = UITextField().then {
        $0.placeholder = "가격 (선택 사항)"
        $0.keyboardType = .numberPad
        $0.leftViewMode = .always
    }

    private let suggestionButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        $0.setTitle("가격제안 받기", for: .normal)
        $0.setTitleColor(.tertiaryLabel, for: .normal)
        $0.setTitleColor(.label, for: .selected)
        $0.tintColor = .tertiaryLabel
        $0.isEnabled = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        configureViews()
        configurePriceTextField()
        configureSuggestionButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private
extension PriceTableViewCell {
    private func configureViews() {
        self.addSubview(priceTextField)
        self.addSubview(suggestionButton)
    }

    private func configurePriceTextField() {
        priceTextField.leftView = krwLabel

        priceTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Styles.grid(8))
            $0.top.equalToSuperview().offset(Styles.grid(4))
            $0.trailing.equalTo(suggestionButton.snp.leading)
            $0.bottom.equalToSuperview().offset(Styles.grid(-4))
        }
    }

    private func configureSuggestionButton() {
        suggestionButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Styles.grid(4))
            $0.trailing.equalToSuperview().offset(Styles.grid(-8))
            $0.bottom.equalToSuperview().offset(Styles.grid(-4))
        }
    }
}
