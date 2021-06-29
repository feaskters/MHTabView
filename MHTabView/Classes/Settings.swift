//
//  Settings.swift
//  MHTabView
//
//  Created by ios_1 on 2020/4/24.
//

import Foundation

/**标签滚动样式*/
public enum titleScrollViewStyle {
    /**不可滚动，平均长度*/
    case unscrollable
    /**不可滚动，长度根据字数自适应*/
    case autoUnscrollable
    /**可以滚动，固定长度(使用tabwidth属性可以修改长度)*/
    case scrollable
    /**可以滚动，长度根据字数自适应*/
    case autoScrollable
    /**可以滚动，菜单项居左对其，根据字数自适应宽度，指示器宽度固定可修改*/
    case leftScrollable
}

/**页面滚动样式*/
public enum pageScrollViewStyle {
    /**普通样式*/
    case normal
    /**占位其他样式*/
    case other
}

struct setting {
    /**标题高度，默认40*/
    static var titleHeight: CGFloat = 40
}
