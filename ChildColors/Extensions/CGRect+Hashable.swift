//
//  CGRect+Hashable.swift
//  ChildColors
//
//  Created by Vladyslav Sosiuk on 02.03.2021.
//

import UIKit

extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(origin.x)
        hasher.combine(origin.y)
        hasher.combine(size.width)
        hasher.combine(size.height)
    }
}
