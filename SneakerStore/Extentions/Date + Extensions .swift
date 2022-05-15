//
//  Date + Extentions .swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 08.05.2022.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d"
        
        return dateFormatter.string(from: self)
    }
}
