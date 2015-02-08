//
//  FormValidators.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 08/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import Foundation

extension String {
    
    // Email
    func isEmailValid() -> Bool {
        let regex = NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, countElements(self))) != nil
    }
}
