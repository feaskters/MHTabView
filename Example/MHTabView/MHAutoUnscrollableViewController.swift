//
//  MHAutoUnscrollableViewController.swift
//  MHTabView_Example
//
//  Created by ios_1 on 2020/4/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import MHTabView

class MHAutoUnscrollableViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let titles = ["标题1", "标题2标题", "3", "标题4"]

               let view1 = UIView.init()
               view1.backgroundColor = UIColor(hexCode: "#d20962")

               let view2 = UIView.init()
               view2.backgroundColor = UIColor(hexCode: "#f47721")

               let view3 = UIView.init()
               view3.backgroundColor = UIColor(hexCode: "#7ac143")

               let view4 = UIView.init()
               view4.backgroundColor = UIColor(hexCode: "#00a78e")

               let tabview = MHTabView.init(withTitles: titles, pageViews: [view1, view2, view3, view4])
               tabview.titleStyle = .autoUnscrollable

               tabview.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
               self.containerView.addSubview(tabview)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
