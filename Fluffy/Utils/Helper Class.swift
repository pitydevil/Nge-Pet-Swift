//
//  Helper Class.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 29/09/22.
//

import UIKit

//MARK: -GENERIC FUNCTION CLASS
/// Returns UIAlertController
/// from reactive library errorr
public func errorAlert() -> UIAlertController {
    let alert = UIAlertController(title: "Reactive Unexpected Error", message: "Please try again later", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Ok", style: .cancel)
    alert.addAction(cancel)
    return alert
}
/// Returns boolean true or false
/// from the given components.
/// - Parameters:
///     - titleAlert:: String for the title alert
///     - messageAlert: String for the message alert
///     - buttonText: String that's used on the button text
public func genericAlert(titleAlert : String, messageAlert : String, buttonText : String) -> UIAlertController {
    let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
    let cancel = UIAlertAction(title: buttonText, style: .cancel)
    alert.addAction(cancel)
    return alert
}

/// Returns date in string
/// from the given components.
/// - Parameters:
///     - dateString:: string date object that will be converted to dd / mm format
public func changeDateIntoMMDD(dateString : String) -> String {
    let dateFormatter = DateFormatter()
   // "2022-11-03T04:49:19.000000Z",
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let pastDateInvoice: Date? = dateFormatter.date(from: dateString)
    let dateF = DateFormatter()
    dateF.dateFormat = "MMM DD"
    return dateF.string(from: pastDateInvoice!)
}

/// Returns date in string
/// from the given components.
/// - Parameters:
///     - dateObject:: date object that will be converted to yyyy-mm-dd
public func changeDateIntoYYYYMMDD(_ dateObject : Date) -> String {
    let dateF = DateFormatter()
    dateF.dateFormat = "yyyy-MM-dd"
    return dateF.string(from: dateObject)
}

//MARK: -TEXTFIELD FUNCTION CLASS
/// Returns boolean true or false
/// from the given components.
/// - Parameters:
///     - allowedCharacter: character subset that's allowed to use on the textfield
///     - text: set of character/string that would like  to be checked.
public func checkAllowedText(_ allowedCharacter : String, _ text : String) -> Bool{
    let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacter)
    let typedCharacterSetIn = CharacterSet(charactersIn: text)
    return allowedCharacterSet.isSuperset(of: typedCharacterSetIn)
}

/// Returns attributed text for search textfield
/// from the given components.
/// - Parameters:
///     - allowedCharacter: character subset that's allowed to use on the textfield
///     - text: set of character/string that would like  to be checked.
public func attributedTextForSearchTextfield(_ text : String) -> NSAttributedString{
    return NSAttributedString(string: text, attributes: [
        .foregroundColor: UIColor(named: "white") as Any,
        .font: UIFont(name: "Inter-Medium", size: 12)!
    ])
}

//MARK: -PET SWITCH FUNCTION ->
