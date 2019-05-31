//
//  SetCard.swift
//  Set
//
//  Created by Admin on 26/04/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
struct SetCard{
    private(set) var color: Int = Int()
    private(set) var count: Int = Int()
    private(set) var symbol: String = String()
    private(set) var texture: Float = Float()
    var isSelect: Bool = false
    var isMatched: Bool = false
    
    init(num: Int){
        var n: Int = num
        if (num >= 0 && num <= 80){
            for i in (0...3){
                if (i == 0) {
                    self.texture = 0.5 * Float(n % 3)
                }
                else if (i == 1){
                    if (n % 3 == 0){
                        self.symbol = "▲"
                    }
                    else if (n % 3 == 1){
                        self.symbol = "●"
                    }
                    else if (n % 3 == 2){
                        self.symbol = "■"
                    }
                }
                else if (i == 2){
                    self.count = n % 3
                }
                else if (i == 3){
                    self.color = n % 3
                }
                n = n / 3
            }
        }
    }
    
}
