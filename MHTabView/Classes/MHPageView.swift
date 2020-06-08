//
//  MHPageView.swift
//  MHTabView
//
//  Created by ios_1 on 2020/4/24.
//

import UIKit
import SnapKit

@objc protocol MHPageViewDelegate {
    func pageViewDidScroll(_ scrollView: UIScrollView)
    func pageViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    func pageViewDidEndDecelerating(_ scrollView: UIScrollView)
}

class MHPageView: UIScrollView, UIScrollViewDelegate {
    
    weak var pageViewDelegate: MHPageViewDelegate?
    
    var pageViews: [UIView] = []
    
    var pageViewStyle: pageScrollViewStyle = .normal
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(withStyle style:pageScrollViewStyle, pageViews: [UIView]){
        self.init()
        self.pageViews = pageViews
        self.pageViewStyle = style
        setUp()
    }
    
    override func draw(_ rect: CGRect) {
        layOut()
    }
    
    func setUp() {
        
        self.delegate = self
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled = true
        self.bounces = false
        
        for page in pageViews {
            self.addSubview(page)
        }
    }
    
    func layOut() {
        self.contentSize = CGSize(width: self.frame.width * CGFloat(pageViews.count), height: self.frame.height)
               
        for i in Range(0..<pageViews.count) {
            let page = pageViews[i]
            page.frame = CGRect(x: CGFloat(i) * self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
        }
        
        //test
        self.backgroundColor = .lightGray
    }
    
    /**滚动到指定页面*/
    func scrollTo(to position: Int) {
        UIView.animate(withDuration: 0.2) {
            self.contentOffset = CGPoint(x: CGFloat(position) * self.frame.width, y: 0)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageViewDelegate?.pageViewDidScroll(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageViewDelegate?.pageViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageViewDelegate?.pageViewDidEndDecelerating(scrollView)
    }
    
}
