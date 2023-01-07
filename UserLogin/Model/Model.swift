//
//  Model.swift
//  UserLogin
//
//  Created by Reenad gh on 27/05/1444 AH.
//

import Foundation


struct User  : Codable {
    
    var id   :    String
    var name :    String
    var mail :    String
    var phone :   String
    
    
    init () {
        
        id = ""
        name = ""
        mail = ""
        phone = ""
        
    }

}



