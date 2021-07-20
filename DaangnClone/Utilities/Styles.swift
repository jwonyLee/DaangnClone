//
//  Styles.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//  Reference: https://github.com/kickstarter/ios-oss/blob/main/Library/Styles/BaseStyles.swift
import UIKit

public enum Styles {
    public static let cornerRadius: CGFloat = 15.0

    public static func grid(_ count: Int) -> CGFloat {
        4.0 * CGFloat(count)
    }
}
