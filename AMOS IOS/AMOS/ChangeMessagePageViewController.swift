//
//  ChangeMessagePageViewController.swift
//  AMOS
//
//  Created by Jimmy Hoang on 7/15/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import SnapKit

class ChangeMessagePageViewController: UIPageViewController {

    lazy var VCArr: [UIViewController] = {
        return [
            self.createViewController(name: "changepasswordpage1"),
            self.createViewController(name: "changepasswordpage2")
        ]
    }()
    
    var pageControl = UIPageControl()
    
    // Input properties
    var id: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        dataSource = self
        delegate = self
        
        if let changeMessagePage1VC = VCArr.first {
            (changeMessagePage1VC as! ChangePasswordPage1ViewController).id = id
            setViewControllers([changeMessagePage1VC], direction: .forward, animated: true, completion: nil)
        }
        
        if let changeMessagePage2VC = VCArr.last {
            (changeMessagePage2VC as! ChangePasswordPage2ViewController).id = id
        }
        configurePageControl()
    }

}

// MARK: Methods
extension ChangeMessagePageViewController {
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect.zero)
        self.pageControl.numberOfPages = VCArr.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .green
        self.pageControl.pageIndicatorTintColor = .gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.init(red: 12/255, green: 160/255, blue: 4/255, alpha: 1)
        self.view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func createViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: name)
    }
}


// MARK: Datasource, delegate
extension ChangeMessagePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = VCArr.index(of: pageContentViewController)!
    }
}