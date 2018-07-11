//
//  QHTextConfig.swift
//  QHShowTextDemo
//
//  Created by Anakin chen on 2018/7/10.
//  Copyright © 2018年 Chen Network Technology. All rights reserved.
//

import Foundation
import UIKit

struct QHTextConfig {
    var id: Int = 0
    var text: String
    
    var font: QHTextFontConfig = QHTextFontConfig()
    var transition: QHTextTransitionConfig = QHTextTransitionConfig()
    var animate: QHTextAnimateConfig = QHTextAnimateConfig()
    
    init(id: Int, text: String) {
        self.id = id
        self.text = text
    }
    
}

struct QHTextFontConfig {
    var size: CGFloat = 0.0
    var color: UIColor = UIColor.white
    var font: UIFont?
    var other: Any?
}

struct QHTextTransitionConfig {
    var type: QHTransitionType = .up
    var interval: Double = 0
    var scale: CGFloat = 1
    var other: Any?
}

struct QHTextAnimateConfig {
    var type: QHTextAnimateType = .none
    var interval: Double = 1
    var other: Any?
    var value: UIViewAnimationTransition = .none
    var scale: CGFloat = 1
}

enum QHTextAnimateType: Int {
    case none = 1
    case typewriter
    case scale
    case animationTransition
}

enum QHTransitionType: Int {
    case up = 1
    case upScale
    case clockwise // 顺时针
    case anticlockwise // 逆时针
}
