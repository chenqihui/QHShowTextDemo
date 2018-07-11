//
//  QHTextViewAnimate.swift
//  QHShowTextDemo
//
//  Created by Anakin chen on 2018/7/11.
//  Copyright © 2018年 Chen Network Technology. All rights reserved.
//

import Foundation
import UIKit

extension QHTextView {
    func none(textConfig text: QHTextConfig) {
        self.text = text.text
        self.setNeedsDisplay()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + text.animate.interval, execute: {
            self.delegate?.complete(view: self)
        })
    }
    
    func typewriter(textConfig text: QHTextConfig) {
        for i in 0..<text.text.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + text.animate.interval * Double(i)) {
                self.text = text.text.subString(to: i + 1)
                self.setNeedsDisplay()
                
                if (i + 1) == text.text.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + text.animate.interval, execute: {
                        self.delegate?.complete(view: self)
                    })
                }
            }
        }
    }
    
    func scale(textConfig text: QHTextConfig) {
        self.text = text.text
        self.setNeedsDisplay()
        
        self.transform = CGAffineTransform(scaleX: text.animate.scale, y: text.animate.scale)
        UIView.animate(withDuration: text.animate.interval, animations: {
            self.transform = CGAffineTransform.identity
        }) { (bFinish) in
            DispatchQueue.main.asyncAfter(deadline: .now() + text.animate.interval, execute: {
                self.delegate?.complete(view: self)
            })
        }
    }
    
    // TODO：无效，待查 - [Swift - 动画效果的实现方法总结（附样例）](http://www.hangge.com/blog/cache/detail_664.html)
    func animationTransition(textConfig text: QHTextConfig) {
        self.text = text.text
        self.setNeedsDisplay()
        
        UIView.beginAnimations("animation", context: nil)
        //设置动画的持续时间，类型和渐变类型
        UIView.setAnimationDuration(text.animate.interval)
        UIView.setAnimationCurve(.linear)
        UIView.setAnimationTransition(text.animate.value, for: self, cache: false)
        //开始动画
        UIView.commitAnimations()
        
        //                let transition = CATransition()
        //                transition.duration = 2.0
        //                transition.type = kCATransitionFade
        //                transition.subtype = kCATransitionFromLeft
        //                // 执行刚才添加好的动画
        //                self.layer.add(transition, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + text.animate.interval, execute: {
            self.delegate?.complete(view: self)
        })
    }
}
