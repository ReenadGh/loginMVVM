//
//  String-Extention.swift
//  UserLogin
//
//  Created by Reenad gh on 11/06/1444 AH.
//

import Foundation

extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}
