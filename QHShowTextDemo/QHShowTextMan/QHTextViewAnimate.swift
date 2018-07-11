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
    
    func animationTransition(textConfig text: QHTextConfig) {
        self.text = text.text
        self.setNeedsDisplay()
        
        self.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(text.animate.interval)
            UIView.setAnimationTransition(.flipFromLeft, for: self, cache: true)
            UIView.setAnimationCurve(.linear)
            self.alpha = 1
            UIView.commitAnimations()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + text.animate.interval, execute: {
                self.delegate?.complete(view: self)
            })
        })
    }
}
