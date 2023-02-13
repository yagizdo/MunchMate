//
//  SnackbarStyles.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 14.02.2023.
//

import Foundation
import SnackBar

class AuthErrorSnackbar: SnackBar {
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .systemRed
        style.textColor = .white

        return style
    }
}

class SuccessSnackBar: SnackBar {
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .systemGreen
        style.textColor = .white

        return style
    }
}
