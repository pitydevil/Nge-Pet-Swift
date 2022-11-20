//
//  Extension.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 29/09/22.
//

import UIKit

//MARK: - Hide Keyboard Function When UI is Tapped
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Adding Line Spacing for UILabel
extension UILabel {
    var spacing:CGFloat {
        get {return 0}
        set {
            let textAlignment = self.textAlignment
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            let attributedString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            self.attributedText = attributedString
            self.textAlignment = textAlignment
        }
    }
}

//MARK: add left image
extension UITextField {
    func setLeftView(image: UIImage, color:UIColor) {
        let iconView = UIImageView(frame: CGRect(x: 21, y: 10, width: 16, height: 16)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 32))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = color
    }
}

//MARK: - UIBUTTON
extension UIButton {
    func setAttributeTitleText(_ text : String,_ size : Int) {
        self.setAttributedTitle(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: CGFloat(size))!]), for: .normal)
    }
}

//MARK: UIAPPLICATION
extension UIApplication {
    var statusView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

//MARK: - STRING EXTENSION
extension String {
    func currencyInputFormatting() -> String {

        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "Rp"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        return formatter.string(from: number)!
    }
}

//MARK: - NOTIFICATION EXTENSION
extension Notification.Name {
     static let orderName = Notification.Name("orderName")
}
