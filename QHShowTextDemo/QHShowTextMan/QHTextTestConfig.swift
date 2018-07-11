//
//  QHTextTestConfig.swift
//  QHShowTextDemo
//
//  Created by Anakin chen on 2018/7/11.
//  Copyright © 2018年 Chen Network Technology. All rights reserved.
//

import UIKit

class QHTextTestConfig: NSObject {
    
    private class func testTextStringArray() -> [String] {
        let textString = "你碰上一个女孩。你不好意思。跟她表白。你怎么办。你问她。你说。你信不信。我能瞬间。环绕世界一周。她说不信。你围着她。你就绕一周。你就回来了。你说。你已经环绕了。世界一周。因为。你就是我的。全世界。"
        let textStringArray = textString.components(separatedBy: "。")
        
        return textStringArray
    }
    
    private class func textFontConfig() -> QHTextFontConfig {
        var font = QHTextFontConfig()
        font.size = (CGFloat(arc4random() % 32) + 18)
        font.color = UIColor.white
        return font
    }
    
    private class func textTransitionConfig() -> QHTextTransitionConfig {
        var transition = QHTextTransitionConfig()
        transition.type = QHTransitionType(rawValue: (Int(arc4random() % 4) + 1))!
        transition.interval = 0.4
        if transition.type == .upScale {
            transition.scale = 1.0 + (CGFloat(arc4random() % 6) + 1) * 0.1 * ((Int(arc4random() % 2) + 1) == 2 ? 1 : -1)
        }
        return transition
    }
    
    private class func textAnimateConfig() -> QHTextAnimateConfig {
        var animate = QHTextAnimateConfig()
        animate.type = QHTextAnimateType(rawValue: (Int(arc4random() % 4) + 1))!
        animate.interval = 1
        if animate.type == .typewriter {
            animate.interval = 0.2
        }
        else if animate.type == .scale {
            animate.scale = 1.0 + (CGFloat(arc4random() % 9) + 1) * 0.1 * ((Int(arc4random() % 2) + 1) == 2 ? 1 : -1)
        }
        else if animate.type == .animationTransition {
            animate.animationTransition = UIViewAnimationTransition(rawValue: (Int(arc4random() % 4) + 1))!
        }
        return animate
    }
    
    class func testTextConfig() -> [QHTextConfig] {
        
        let textStringArray = testTextStringArray()
        var textConfigData = [QHTextConfig]()
        
        var lastTransition: QHTransitionType = .up
        
        for textString in textStringArray {
            let id = textConfigData.count + 1
            var textConfig = QHTextConfig(id: id, text: textString)
            
            textConfig.font = textFontConfig()
            textConfig.transition = textTransitionConfig()
            textConfig.animate = textAnimateConfig()
            
            if lastTransition == .clockwise || lastTransition == .anticlockwise {
                if lastTransition == textConfig.transition.type {
                    textConfig.transition.type = .up
                }
            }
            
            if id == textStringArray.count {
                textConfig.transition.type = .up
            }
            
            lastTransition = textConfig.transition.type
            
            textConfigData.append(textConfig)
        }
        
        return textConfigData
    }

}
