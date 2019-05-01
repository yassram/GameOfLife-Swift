//
//  GOLCell.swift
//  testt
//
//  Created by Yassir RAMDANI on 5/1/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit
import SpriteKit

class GOLCell: SKSpriteNode {
    var living = false {
        didSet {
            if living { color = .black }
            else { color = .white }
        }
    }
    func livingVal() -> Int {
        return living ? 1 : 0
    }
    init(position: CGPoint, living: Bool = false) {
        super.init(texture: nil, color: .white, size: CGSize(width: CellSize, height: CellSize))
        self.living = living
        if living { color = .black }
        else { color = .white }
        self.position = position
        self.anchorPoint = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
