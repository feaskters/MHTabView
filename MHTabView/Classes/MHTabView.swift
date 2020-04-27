//
//  MHTabView.swift
//  Pods-MHTabView_Example
//
//  Created by ios_1 on 2020/4/24.
//

import UIKit
import SnapKit

public protocol MHTabViewDelegate {
    /**停止滚动后的回调函数(index, scrollview) -> (当前滚动到的位置, scrollView属性 )*/
    func MHTabViewDidEndDecelerating(_ index: Int, _ scrollview: UIScrollView)
}

public class MHTabView: UIView, MHPageViewDelegate, MHTitleScrollViewDelegate {

    /**标题列表*/
    private var titles: [String]!
    
    /**标签页列表*/
    private var pageViews: [UIView]!
    
    /**标题样式*/
    public var titleStyle: titleScrollViewStyle! {
        didSet{
            if let titlescrollview = titleScrollView {
                titlescrollview.titleStyle = titleStyle
            }
        }
    }
    
    /**MHTabView代理*/
    public var MHTabViewDelegate: MHTabViewDelegate?
    
    /**未选中tab的颜色*/
    public var defaultColor: UIColor? {
        didSet{
            titleScrollView.btnColorDefault = defaultColor ?? .gray
        }
    }
    
    /**被选中tab的颜色*/
    public var selectedColor: UIColor? {
        didSet{
            titleScrollView.btnColorSelected = selectedColor ?? .red
        }
    }
    
    /**标签长度，仅限.scrollable样式使用*/
    public var tabWidth: CGFloat! {
        didSet{
            titleScrollView.buttonWidth = tabWidth
        }
    }
    
    var titleScrollView: MHTitleScrollView!
    
    var pageView: MHPageView!
    
    public override init(frame: CGRect) {
        super.init(frame:frame)
        
        //test
        self.backgroundColor = .lightGray
        self.titleStyle = .unscrollable
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public convenience init(withTitles titles: [String], pageViews: [UIView]){
        self.init()
        setTitlesAndPageViews(titles: titles, pageViews: pageViews)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /**设置标题和标签页*/
    public func setTitlesAndPageViews(titles: [String], pageViews: [UIView]){
        guard titles.count == pageViews.count else {
            fatalError("标题数量与标签页数量不同")
        }
        
        self.titles = titles
        self.pageViews = pageViews
        setUp()
        layout()
    }
    
    func layout(){
        titleScrollView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalTo(setting.titleHeight)
        }
        
        pageView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(titleScrollView.snp.bottom)
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    func setUp() {
        titleScrollView = MHTitleScrollView(titleStyle: self.titleStyle, titles: self.titles)
        titleScrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: setting.titleHeight)
        titleScrollView.titleScrollViewDelegate = self
        self.addSubview(titleScrollView)
        
        pageView = MHPageView(withStyle: .normal, pageViews: self.pageViews)
        pageView.frame = CGRect(x: 0, y: setting.titleHeight, width: self.frame.width, height: self.frame.height - setting.titleHeight)
        pageView.pageViewDelegate = self
        self.addSubview(pageView)
    }
    
    // MARK: - MHPageViewDelegate
    func pageViewDidScroll(_ scrollView: UIScrollView) {
        let x = CGFloat(scrollView.contentOffset.x / scrollView.contentSize.width)
        self.titleScrollView.indicatorMove(to: x)
        
    }
    
    func pageViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        titleScrollView.btnClick(titleScrollView.buttons[index])
    }
    
    // MARK: - MHTitleScrollViewDelegate
    func titleClick(_ sender: UIButton) {
        pageView.scrollTo(to: sender.tag - 1)
        MHTabViewDelegate?.MHTabViewDidEndDecelerating(sender.tag - 1, self.pageView)
    }

}

