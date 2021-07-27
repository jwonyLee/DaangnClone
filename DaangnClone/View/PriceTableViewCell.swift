//
//  PriceTableViewCell.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class PriceTableViewCell: UITableViewCell {
    // MARK: - Properties
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    private let disposeBag: DisposeBag = DisposeBag()

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
        $0.isSelected = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = false

        configureViews()
        configurePriceTextField()
        configureSuggestionButton()
        bindPriceInput()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            priceTextField.becomeFirstResponder()
        } else {
            priceTextField.resignFirstResponder()
        }
    }
}

// MARK: - Private
extension PriceTableViewCell {
    private func configureViews() {
        self.addSubview(priceTextField)
        self.addSubview(suggestionButton)
    }

    private func configurePriceTextField() {
        priceTextField.delegate = self
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

    private func bindPriceInput() {
        priceTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: { [weak self] isEmpty in
                let krw: UILabel = self?.priceTextField.leftView as? UILabel ?? UILabel()
                krw.textColor = isEmpty ? .label : .tertiaryLabel
            })
            .disposed(by: disposeBag)

        priceTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: { [weak self] isEmpty in
                self?.suggestionButton.isEnabled = isEmpty
                self?.suggestionButton.tintColor = isEmpty ? .label : .tertiaryLabel
                self?.suggestionButton.setTitleColor(isEmpty ? .label : .tertiaryLabel, for: .normal)
            })
            .disposed(by: disposeBag)

        suggestionButton.rx.tap
            .bind(with: self) { strongSelf, _ in
                strongSelf.suggestionButton.isSelected.toggle()
                print("tapped")
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - TextField Delegate
extension PriceTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0

        let text: String = textField.text ?? ""
        let newString: String = (text as NSString).replacingCharacters(in: range, with: string)
        let numberWithoutCommas: String = newString.replacingOccurrences(of: ",", with: "")

        guard var number = formatter.number(from: numberWithoutCommas) else {
            textField.text = nil
            textField.sendActions(for: .valueChanged)
            return false
        }

        if Int(truncating: number) > 99_999_999 {
            number = NSNumber(value: 99_999_999)
        }

        var formattedString: String? = formatter.string(from: number)
        if string == "." && range.location == textField.text?.count {
            formattedString = formattedString?.appending(".")
        }
        textField.text = formattedString

        textField.sendActions(for: .valueChanged)
        return false
    }
} // source: https://stackoverflow.com/questions/27308595/how-do-you-dynamically-format-a-number-to-have-commas-in-a-uitextfield-entry/50798618
