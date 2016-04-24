//
//  TextBox.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/24.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//


import UIKit



enum UITextBoxHighlightState {
    case Default
    case Correct  (String)    // 状态提示文字
    case Wrong      (String)    // 状态提示文字
}

@IBDesignable

class UITextBox: UITextField {
    
    let wrongColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
    let highlitedColor = UIColor(red: 0, green: 0.4, blue: 1, alpha: 0.1)
    
    @IBInspectable var animateDuration:CGFloat = 0.4
    weak var placeholderLabel:UILabel?
    
    @NSCopying private var _backgroundColor: UIColor? = nil
    override var backgroundColor: UIColor? {
        set {
            _backgroundColor = newValue
            super.backgroundColor = self.getHighlightColor(self.highlightState)
        }
        get {
            return _backgroundColor
        }
    }
    override var attributedPlaceholder: NSAttributedString? {
        didSet {
            if let label = placeholderLabel {
                label.attributedText = super.attributedPlaceholder
                self.layoutSubviews()
            }
        }
    }
    override var placeholder:String? {
        didSet {
            if let label = placeholderLabel {
                label.text = super.placeholder
                self.layoutSubviews()
            }
        }
    }
    
    
    private var _highlightState:UITextBoxHighlightState {
        return text == nil || text == "" ? .Default : highlightState
    }
    var highlightState:UITextBoxHighlightState = .Default {
        didSet {
            if let label = placeholderLabel {
                setHighlightText(label, state: _highlightState)
                self.layoutSubviews()
            }
            UIView.animateWithDuration(NSTimeInterval(animateDuration)) {
                super.backgroundColor = self.getHighlightColor(self._highlightState)
                
            }
        }
    }
    
    //获得焦点时高亮动画
    override func becomeFirstResponder() -> Bool {
        return animationFirstResponder(super.becomeFirstResponder())
    }
    
    //失去焦点时取消高亮动画
    override func resignFirstResponder() -> Bool {
        return animationFirstResponder(super.resignFirstResponder())
    }
    
    //
    private func animationFirstResponder(isFirstResponder:Bool) -> Bool {
        UIView.animateWithDuration(NSTimeInterval(animateDuration)) {
            let color = self.getHighlightColor(self._highlightState)
            super.backgroundColor = color
            self.placeholderLabel?.textColor = self.getTextColorWithHighlightColor(color)
        }
        return isFirstResponder
    }
    
    
    //调整子控件布局
    override func layoutSubviews() {
        super.layoutSubviews()
        let rect = super.placeholderRectForBounds(bounds)
        if isFirstResponder() {
            layoutPlaceholderLabel(rect,false)
        } else if text == nil || text == "" {
            layoutPlaceholderLabel(rect,true)
        } else {
            layoutPlaceholderLabel(rect,false)
        }
    }
    
    override func willMoveToSuperview(newSuperview: UIView!)  {
        super.willMoveToSuperview(newSuperview)
        if placeholderLabel == nil {
            let rect = super.placeholderRectForBounds(bounds)
            let label = UILabel(frame: rect)
            label.font = self.font
            setHighlightText(label, state: self._highlightState)
            placeholderLabel = label
            self.addSubview(label);
        }
    }
    
    override func removeFromSuperview() {
        self.placeholderLabel?.removeFromSuperview()
        self.placeholderLabel = nil
        super.removeFromSuperview()
    }
    
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        let rect = super.placeholderRectForBounds(bounds)
        if placeholderLabel == nil {
            let label = UILabel(frame: rect)
            label.textColor = UIColor(white: 0.7, alpha: 1.0)
            label.font = self.font
            placeholderLabel = label
            addSubview(label)
        }
        setHighlightText(placeholderLabel!, state: self._highlightState)
        layoutPlaceholderLabel(rect,!isFirstResponder())
        return CGRect.zero
    }
    
    
    //布局提示文本
    func layoutPlaceholderLabel(rect: CGRect,_ left: Bool = false) {
        guard let label = placeholderLabel else {
            return
        }
        
        if left {
            UIView.animateWithDuration(NSTimeInterval(animateDuration), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                label.frame = rect;
                }, completion: nil)
        } else {
            let size = label.sizeThatFits(rect.size)
            var frame = rect
            frame.size.width = size.width
            frame.size.height = rect.height
            frame.origin.x = super.clearButtonRectForBounds(bounds).minX - size.width
            UIView.animateWithDuration(NSTimeInterval(animateDuration), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                label.frame = frame;
                }, completion: nil)
        }
    }
    
    private func setHighlightText(label:UILabel, state:UITextBoxHighlightState) {
        switch state {
        case .Wrong(let errorText):
            label.textColor = getTextColorWithHighlightColor(wrongColor)
            label.text = errorText
        case .Correct(let correctText):
            label.textColor = getTextColorWithHighlightColor(highlitedColor)
            label.text = correctText
        default:
            if let attributedPlaceholder = self.attributedPlaceholder {
                label.attributedText = attributedPlaceholder
            } else {
                label.text = self.placeholder
            }
            label.textColor = getTextColorWithHighlightColor(getHighlightColor(_highlightState))
        }
    }
    private func getTextColorWithHighlightColor(color:UIColor) -> UIColor {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r*r*0.7, green: g*g*0.7, blue: b*b*0.7, alpha: a)   // 同类颜色加深一些
    }
    private func getHighlightColor(state:UITextBoxHighlightState) -> UIColor {
        switch state {
        case .Wrong:        return wrongColor
        case .Correct:      return highlitedColor
        default:            return self.isFirstResponder() ? highlitedColor : self.backgroundColor ?? UIColor.whiteColor()
        }
    }
    
}


