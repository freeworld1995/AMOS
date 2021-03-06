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
        return [
            self.createViewController(name: "controlCenterVC"),
            self.createViewController(name: "optionVC")
        ]
    }()
    
    func createViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    // Input properties
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        dataSource = self
        delegate = self
        
        if let controlCenterVC = VCArr.first {
            (controlCenterVC as! ControlCenterViewController).id = id
            setViewControllers([controlCenterVC], direction: .forward, animated: true, completion: nil)
        }
        
        if let optionVC = VCArr.last {
            (optionVC as! OptionViewController).id = id
        }
    }
    
}

// MARK: Datasource, delegate
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard VCArr.count != nextIndex else {
            return nil
        }
        
        guard VCArr.count > nextIndex else {
            return nil
        }
        
        return VCArr[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard VCArr.count > previousIndex else {
            return nil
        }
        
        return VCArr[previousIndex]
    }
}
