//
//  QHTextView.swift
//  QHShowTextDemo
//
//  Created by Anakin chen on 2018/7/9.
//  Copyright © 2018年 Chen Network Technology. All rights reserved.
//

import UIKit

protocol QHTextViewDelegate: NSObjectProtocol {
    func complete(view: QHTextView)
}

class QHTextView: UIView {
    
    var text = ""
    var textId: Int = 0
    var textConfig: QHTextConfig?
    
    weak var delegate : QHTextViewDelegate?

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
        }
        // 绘制文本属性
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        var textAttributes = [NSAttributedStringKey : Any]()
        var fontSize: CGFloat = 10
        if let textC = textConfig {
            fontSize = textC.font.size
        }
        textAttributes[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: fontSize)
        textAttributes[NSAttributedStringKey.foregroundColor] = UIColor.white
        textAttributes[NSAttributedStringKey.paragraphStyle] = textStyle
        
        let text = self.text
        
        let strSize = text.size(withAttributes: textAttributes)
        // 文本绘制
        let centerP = CGPoint(x: (rect.size.width - strSize.width)/2, y: (rect.size.height - strSize.height)/2)
        text.draw(at: centerP, withAttributes: textAttributes)
    }
    
    class func create(text: QHTextConfig, superView: UIView) -> QHTextView {
        let size = text.text.sizeFor(fontSize: text.font.size)
        let textView = QHTextView(frame: CGRect(origin: .zero, size: size))
        textView.center = superView.center
        textView.backgroundColor = UIColor.clear
        textView.textConfig = text
        textView.textId = text.id
        
        return textView
    }
    
    func show() {
        if let textConfig = self.textConfig {
            switch textConfig.animate.type {
            case .none:
                none(textConfig: textConfig)
            case .typewriter:
                typewriter(textConfig: textConfig)
            case .scale:
                scale(textConfig: textConfig)
            case .animationTransition:
                animationTransition(textConfig: textConfig)
            }
        }
    }
}

extension String {
    func subString(to: Int) -> String {
        let endIndex = String.Index.init(encodedOffset: to)
        let subStr = self[self.startIndex..<endIndex]
        return String(subStr)
    }
    
    func sizeFor(fontSize: CGFloat) -> CGSize {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = NSString(string: self).size(withAttributes: [NSAttributedStringKey.font: font])
        return size
    }
}
