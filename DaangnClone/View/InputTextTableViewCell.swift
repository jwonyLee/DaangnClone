//
//  InputTextTableViewCell.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit
import SnapKit
import Then

class InputTextTableViewCell: UITableViewCell {
    // MARK: - Properties
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }

    // MARK: - View Properties
    private let textField: UITextField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        configureTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }

    func configurePlaceholder(with placeholder: String) {
        textField.placeholder = placeholder
    }
}

// MARK: - Private
extension InputTextTableViewCell {
    private func configureTextField() {
        self.addSubview(textField)

        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Styles.grid(8))
            $0.top.equalToSuperview().offset(Styles.grid(4))
            $0.trailing.equalToSuperview().offset(Styles.grid(-8))
            $0.bottom.equalToSuperview().offset(Styles.grid(-4))
        }
    }
}
