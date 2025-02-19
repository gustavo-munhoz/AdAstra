//
//  String+isEqualIgnoringCaseAndWhitespace.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 19/02/25.
//

import Foundation

extension String {
    func isEqualIgnoringCaseAndWhitespace(_ string: String) -> Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
            .caseInsensitiveCompare(string.trimmingCharacters(in: .whitespacesAndNewlines)) == .orderedSame
    }
}
