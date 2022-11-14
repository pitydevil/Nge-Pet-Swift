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
