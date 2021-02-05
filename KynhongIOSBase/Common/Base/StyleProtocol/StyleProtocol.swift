//
//  StyleProtocol.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 2/4/21.
//

import Foundation

protocol StyleProtocol {
    var style: Style {get}
    func setupStyle(_ style: Style)
    func styleChanged(_ style: Style)
}

