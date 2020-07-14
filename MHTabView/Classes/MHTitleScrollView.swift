//
//  MHTitleScrollView.swift
//  MHTabView
//
//  Created by ios_1 on 2020/4/24.
//

import UIKit
import SnapKit

@objc protocol MHTitleScrollViewDelegate {
    func titleClick(_ sender: UIButton)
}

class MHTitleScrollView: UIScrollView {
    
    var titleStyle: titleScrollViewStyle!
    
    weak var titleScrollViewDelegate: MHTitleScrollViewDelegate?
    
    var titles: [String]!
    
    var buttons: [UIButton]!
    var buttonWidth: CGFloat = 100
    var defaultSelectedIndex: Int = 0
    var animateDuration: TimeInterval = 0.2
    
    var indicatorView: UIView!
    var indicatorInsideView: UIView!
    
    var btnColorSelected: UIColor = .red
    var btnColorDefault: UIColor = .gray
    
    var unselectedFont = UIFont.systemFont(ofSize: 14)
    var selectedFont = UIFont.systemFont(ofSize: 16)
    
    var indicatorHeight: CGFloat = 3
    var indicatorWidth: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isScrollEnabled = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = false
        self.backgroundColor = .white
        
        //初始化滑动条
        indicatorView = UIView.init()
        indicatorView.backgroundColor = self.backgroundColor
        
        self.addSubview(indicatorView)
        
        indicatorInsideView = UIView.init()
        indicatorInsideView.backgroundColor = self.btnColorSelected
        indicatorInsideView.layer.cornerRadius = 5
        indicatorView.addSubview(indicatorInsideView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(titleStyle: titleScrollViewStyle, titles: [String]) {
        self.init()
        self.titleStyle = titleStyle
        self.titles = titles
    }
    
    override func draw(_ rect: CGRect) {
        
        setUp()
        
        switch titleStyle {
        case .autoScrollable, .scrollable:
            indicatorView.frame = CGRect(x: 0, y: setting.titleHeight - indicatorHeight, width: buttons[0].titleLabel!.frame.width, height: indicatorHeight)
            break
        case .autoUnscrollable, .unscrollable:
            let w = self.frame.width / CGFloat(buttons.count)
            buttons[0].snp.updateConstraints { (maker) in
                maker.width.equalTo(w)
            }
            indicatorView.frame = CGRect(x: 0, y: setting.titleHeight - indicatorHeight, width: w, height: indicatorHeight)
            break
        default:
            break
        }
        
        //默认选中按钮
        btnClick(buttons[defaultSelectedIndex], withDuration: 0)
    }
    
    func setUp(){
        
        //初始化按钮
        buttons = []
        for i in Range(1...titles.count) {
            let btn = UIButton.init()
            btn.tag = i
            btn.setTitle(titles[i - 1], for: .normal)
            btn.setTitleColor(btnColorDefault, for: .normal)
            btn.addTarget(self, action: #selector(MHTitleScrollView.btnClick(_:)), for: .touchUpInside)
            btn.titleLabel?.font = unselectedFont
            buttons.append(btn)
            self.addSubview(btn)
        }
        
        switch self.titleStyle {
        case .autoScrollable, .scrollable:
            setUpScrollable()
            break
        case .unscrollable, .autoUnscrollable:
            self.setUpUnscrollable()
            break
        default:
            break
        }
        
    }
    
    func setUpUnscrollable(){
        for btn in buttons {
            if btn.tag == 1 {
                btn.snp.makeConstraints { (maker) in
                    maker.top.equalToSuperview()
                    maker.width.equalTo(10)
                    maker.height.equalTo(setting.titleHeight)
                    maker.left.equalToSuperview()
                }
            }else if btn.tag == buttons.count {
                btn.snp.makeConstraints { (maker) in
                    maker.width.equalTo(buttons[0].snp.width)
                    maker.top.equalToSuperview()
                    maker.height.equalTo(setting.titleHeight)
                    maker.left.equalTo(buttons[btn.tag - 2].snp.right)
                    maker.right.equalToSuperview()
                }
            }else{
                btn.snp.makeConstraints { (maker) in
                    maker.width.equalTo(buttons[0].snp.width)
                    maker.top.equalToSuperview()
                    maker.height.equalTo(setting.titleHeight)
                    maker.left.equalTo(buttons[btn.tag - 2].snp.right)
                }
            }
        }
        contentSize = CGSize(width: self.frame.width, height: setting.titleHeight)
    }
    
    func setUpScrollable(){
        self.isScrollEnabled = true
        
        if self.titleStyle == titleScrollViewStyle.scrollable {
            contentSize = CGSize(width: self.buttonWidth * CGFloat(buttons.count), height: setting.titleHeight)
        }
        
        for btn in buttons {
            var w = buttonWidth
            if self.titleStyle == titleScrollViewStyle.autoScrollable {
                w = btn.titleLabel!.intrinsicContentSize.width + 30
                self.contentSize = CGSize(width: contentSize.width + w, height: contentSize.height)
            }
            if btn.tag == 1 {
                btn.snp.makeConstraints { (maker) in
                    maker.top.equalToSuperview()
                    maker.width.equalTo(w)
                    maker.height.equalTo(setting.titleHeight)
                    maker.left.equalToSuperview()
                }
            }else if btn.tag == buttons.count {
                btn.snp.makeConstraints { (maker) in
                    maker.width.equalTo(w)
                    maker.top.equalToSuperview()
                    maker.height.equalTo(setting.titleHeight)
                    maker.left.equalTo(buttons[btn.tag - 2].snp.right)
                }
            }else{
                btn.snp.makeConstraints { (maker) in
                    maker.width.equalTo(w)
                    maker.top.equalToSuperview()
                    maker.height.equalTo(setting.titleHeight)
                    maker.left.equalTo(buttons[btn.tag - 2].snp.right)
                }
            }
        }
    }
    
    @objc func btnClick(_ sender: UIButton) {
        self.btnClick(sender, withDuration: animateDuration)
    }
    
    /**按钮点击*/
    @objc func btnClick(_ sender: UIButton, withDuration duration: TimeInterval){
        
        UIView.animate(withDuration: duration, animations: {
            self.titleScrollViewDelegate?.titleClick(sender)
        }) { (Bool) in
            UIView.animate(withDuration: duration) {
                for btn in self.buttons{
                    if btn.tag == sender.tag {
                        btn.setTitleColor(self.btnColorSelected, for: .normal)
                        btn.titleLabel?.font = self.selectedFont
                    }else{
                        btn.setTitleColor(self.btnColorDefault, for: .normal)
                        btn.titleLabel?.font = self.unselectedFont
                    }
                }
                
                switch self.titleStyle {
                    case .autoScrollable:
                        var finalX: CGFloat = 0
                        for i in 0..<sender.tag - 1 {
                            finalX += self.buttons[i].frame.width
                        }
                        self.indicatorView.frame = CGRect(x: finalX, y: setting.titleHeight - self.indicatorHeight, width: sender.frame.width, height: self.indicatorHeight)
                        finalX += (self.buttons[sender.tag - 1].frame.width) / 2
                        
                        finalX -= self.frame.width / 2
                        
                        if finalX > self.contentSize.width - self.frame.width {
                            finalX = self.contentSize.width - self.frame.width
                        }
                        if finalX < 0 {
                            finalX = 0
                        }
                        self.contentOffset = CGPoint(x: finalX, y: 0)
                        self.indicatorInsideView.frame = CGRect(x: (sender.frame.width - sender.titleLabel!.frame.width - 5) / 2, y: 0, width: sender.titleLabel!.frame.width + 5, height: self.indicatorView.frame.height)
                        break
                    case .autoUnscrollable:
                        self.indicatorInsideView.frame = CGRect(x: (sender.frame.width - sender.titleLabel!.frame.width - 5) / 2, y: 0, width: sender.titleLabel!.frame.width + 5, height: self.indicatorView.frame.height)
                        break
                    case .unscrollable:
                        self.indicatorInsideView.frame = CGRect(x: (sender.frame.width - (self.indicatorWidth ?? sender.frame.width)) / 2, y: 0, width: self.indicatorWidth ?? sender.frame.width, height: self.indicatorView.frame.height)
                        break
                    case .scrollable:
                        self.indicatorInsideView.frame = CGRect(x: (sender.frame.width - (self.indicatorWidth ?? sender.frame.width)) / 2, y: 0, width: self.indicatorWidth ?? sender.frame.width, height: self.indicatorView.frame.height)
                        var x = CGFloat(sender.tag - 1) * self.buttonWidth + self.buttonWidth / 2 - (self.frame.width / 2)
                        if x < 0 {
                            x = 0
                        }
                        if x > self.contentSize.width - self.frame.width {
                            x = self.contentSize.width - self.frame.width
                        }
                        self.contentOffset = CGPoint(x: x, y: 0)
                        break
                    default:
                        break
                }
            }
        }
        
    }
    
    /**指示器移动*/
    func indicatorMove(to x: CGFloat) {
        switch titleStyle {
        case .unscrollable, .autoUnscrollable:
            self.indicatorView.frame = CGRect(x: x * self.contentSize.width, y: setting.titleHeight - indicatorHeight, width: indicatorView.frame.width, height: indicatorHeight)
            break
        case .scrollable:
            self.indicatorView.frame = CGRect(x: x * self.contentSize.width, y: setting.titleHeight - indicatorHeight, width: indicatorView.frame.width, height: indicatorHeight)
            break
        case .autoScrollable:
            var finalX: CGFloat = 0
            for i in 0..<Int(x * CGFloat(buttons.count)){
                finalX += buttons[i].frame.width
            }
            finalX += ((x * CGFloat(buttons.count)) - CGFloat(Int(x * CGFloat(buttons.count)))) * buttons[Int(x * CGFloat(buttons.count))].frame.width
            self.indicatorView.frame = CGRect(x: finalX, y: setting.titleHeight - indicatorHeight, width: indicatorView.frame.width, height: indicatorHeight)
            break
        default:
            break
        }
    }
    
    /**按钮变色*/
    func buttonsColorChange(_ sender: UIButton) {
        for btn in self.buttons{
            if btn.tag == sender.tag {
                btn.setTitleColor(self.btnColorSelected, for: .normal)
                btn.titleLabel?.font = self.selectedFont
            }else{
                btn.setTitleColor(self.btnColorDefault, for: .normal)
                btn.titleLabel?.font = self.unselectedFont
            }
        }
    }

}
