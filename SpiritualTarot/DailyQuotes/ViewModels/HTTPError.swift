//
//  HTTPError.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation

// Creating some own throwable Error Types:
enum HTTPError: Error {
    case invalidURL
    case missingData
}
