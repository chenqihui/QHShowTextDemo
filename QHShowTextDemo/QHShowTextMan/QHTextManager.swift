//
//  QHTextManager.swift
//  QHShowTextDemo
//
//  Created by Anakin chen on 2018/7/9.
//  Copyright © 2018年 Chen Network Technology. All rights reserved.
//

import UIKit

class QHTextManager: NSObject, QHTextViewDelegate {
    
    var view = UIView(frame: CGRect.zero)
    var data: [QHTextConfig]?
    
    var rotationSuperViewArray = [UIView]()
    var currentSuperViewIndex: Int = -1
    
    private func remove() {
        let frame = view.frame
        view.removeFromSuperview()
        view = UIView(frame: frame)
    }
    
    private func addRotationSuperView(data: [QHTextConfig]) {
        var superView = view
        for _ in 0..<data.count {
            let rotationSuperView = UIView(frame: superView.bounds)
            rotationSuperView.backgroundColor = UIColor.clear
            superView.addSubview(rotationSuperView)
            superView = rotationSuperView
            rotationSuperViewArray.append(superView)
        }
    }
    
    private func showText(currentTextView: QHTextView, nextText: QHTextConfig) {
        if let superView = currentTextView.superview {
            // TODO: 修改以 id 做索引，或者排序后再这样执行
            self.currentSuperViewIndex -= 1
            let nextSuperView = self.rotationSuperViewArray[self.currentSuperViewIndex]
            let nextTextView = QHTextView.create(text: nextText, superView: nextSuperView)
            nextTextView.delegate = self
            
            let currentSize = currentTextView.frame.size
            let nextSize = nextTextView.frame.size
            var frame = superView.frame
            var affineTransfrom: CGAffineTransform?
            
            switch nextText.transition.type {
            case .up:
                let upHeight = currentSize.height + nextSize.height
                frame.origin.y -= upHeight/2
                frame.size.height += upHeight
            case .upScale:
                let scale = nextText.transition.scale
                let upHeight = currentSize.height * scale + nextSize.height
                frame.origin.y -= upHeight/2
                affineTransfrom = CGAffineTransform(scaleX: scale, y: scale)
            case .clockwise:
                frame.origin.y -= (currentSize.width - nextSize.height)/2
                frame.origin.x += (currentSize.height + nextSize.width)/2
                affineTransfrom = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            case .anticlockwise:
                frame.origin.y -= (currentSize.width - nextSize.height)/2
                frame.origin.x -= (currentSize.height + nextSize.width)/2
                affineTransfrom = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
            }
            
            UIView.animate(withDuration: nextText.transition.interval, animations: {
                superView.frame = frame
                if let affineT = affineTransfrom {
                    superView.transform = affineT
                }
            }) { (bFinish) in
                nextSuperView.addSubview(nextTextView)
                nextTextView.show()
            }
        }
    }
    
    // MARK: Public
    
    class func create(superView: UIView) -> QHTextManager {
        let manager = QHTextManager()
        manager.view.frame = superView.bounds
        superView.addSubview(manager.view)
        
        return manager
    }
    
    func showIn(superView: UIView) {
        view.backgroundColor = UIColor.black
        view.frame = superView.bounds
        superView.addSubview(view)
    }
    
    func play(data: [QHTextConfig]) {
        self.data = data
        addRotationSuperView(data: data)
        
        if data.count > 0, let nextText = data.first {
            currentSuperViewIndex = rotationSuperViewArray.count - 1
            let nextSuperView = rotationSuperViewArray[currentSuperViewIndex]
            let nextTextView = QHTextView.create(text: nextText, superView: nextSuperView)
            nextTextView.delegate = self
            nextSuperView.addSubview(nextTextView)
            nextTextView.show()
        }
    }
    
    // MARK: QHTextViewDelegate
    
    func complete(view: QHTextView) {
        let id = view.textId + 1
        if let data = self.data, id <= data.count {
            let nextText = data[id - 1]
            showText(currentTextView: view, nextText: nextText)
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.remove()
            })
        }
        
    }

}
