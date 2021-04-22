//
//  DocumentSerializable.swift
//  FitStart
//
//  Created by Memphis Meng on 4/19/21.
//

import Foundation

protocol DocumentSerializable {
    init?(documentData: [String: Any])
}

