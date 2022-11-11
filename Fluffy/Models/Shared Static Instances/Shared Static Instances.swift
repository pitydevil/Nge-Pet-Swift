//
//  User.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 11/11/22.
//

import Foundation
import RxSwift

public let defaults = UserDefaults.standard
public let bags = DisposeBag()
public var userID = defaults.value(forKey: "userID") as! Int
