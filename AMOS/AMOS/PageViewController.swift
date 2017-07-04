//
//  PageViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    lazy var VCArr: [UIViewController] = {
        return [UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: "controlCenter")]
    }()
    
    // Input properties
    var id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
}
