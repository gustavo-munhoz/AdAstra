//
//  RawRepresentable+InitializableByString.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 18/02/25.
//

import Foundation

protocol InitializableByString: RawRepresentable, CaseIterable where RawValue == String {
    static func fromString(_ string: String) -> Self?
}

extension InitializableByString {
    static func fromString(_ string: String) -> Self? {
        Self.allCases.first {
            $0.rawValue.isEqualIgnoringCaseAndWhitespace(string)
        }
    }
}
