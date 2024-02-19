//
//  AllPathsEnum.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 18.02.24.
//

import Foundation

enum AllPathsEnum {
    case simplePath, littleCross, greatPath, loveOracle
    
    var name: String {
        switch self {
        case .simplePath: return "The Simple Path"
        case .littleCross: return "The Little Cross"
        case .greatPath: return "The Great Path"
        case .loveOracle: return "The Love Oracle"
        }
    }
    
}
