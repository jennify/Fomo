//
//  OnboardingViewController.swift
// ===============================


import UIKit

class OnboardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    let pageControl: UIPageControl = UIPageControl()
    let kPageControlHeight: CGFloat = 50

    var contents: [OnboardingContentViewController] = []

    init(contents: [OnboardingContentViewController]) {
        self.contents = contents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        
        generateView()
    }
    
    func generateView() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.frame = self.view.frame
        
        pageViewController.setViewControllers([contents[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        pageViewController.view.backgroundColor = UIColor.clearColor()
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)

        pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - kPageControlHeight, self.view.bounds.size.width, kPageControlHeight)
        pageControl.numberOfPages = contents.count
        pageControl.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        self.view.addSubview(pageControl)
    }
    
    // convenience setters for content pages
    
    func setIconSize(size: CGFloat) {
        for contentViewController in contents {
            contentViewController.iconSize = size
        }
    }
    
    func setTitleTextColor(color: UIColor) {
        for contentViewController in contents {
            contentViewController.titleTextColor = color
        }
    }
    
    func setBodyTextColor(color: UIColor) {
        for contentViewController in contents {
            contentViewController.bodyTextColor = color
        }
    }
    
    func setButtonTextColor(color: UIColor) {
        for contentViewController in contents {
            contentViewController.buttonTextColor = color
        }
    }
    
    func setFontName(fontName: String) {
        for contentViewController in contents {
            contentViewController.fontName = fontName
        }
    }
    
    func setTitleFontSize(size: CGFloat) {
        for contentViewController in contents {
            contentViewController.titleFontSize = size
        }
    }
    
    func setBodyFontSize(size: CGFloat) {
        for contentViewController in contents {
            contentViewController.bodyFontSize = size
        }
    }
    
    func setTopPadding(padding: CGFloat) {
        for contentViewController in contents {
            contentViewController.topPadding = padding
        }
    }
    
    func setUnderIconPadding(padding: CGFloat) {
        for contentViewController in contents {
            contentViewController.underIconPadding = padding
        }
    }
    
    func setUnderTitlePadding(padding: CGFloat) {
        for contentViewController in contents {
            contentViewController.underTitlePadding = padding
        }
    }
    
    func setBottomPadding(padding: CGFloat) {
        for contentViewController in contents {
            contentViewController.bottomPadding = padding
        }
    }
    
    // convenience methods
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        var indexOfVC: Int = 0
        for (index, element) in contents.enumerate() {
            if element == viewController {
                indexOfVC = index
                break
            }
        }
        return indexOfVC
    }
    
    // page view controller data source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let indexOfCurrentVC = indexOfViewController(viewController)
        return indexOfCurrentVC < contents.count - 1 ? contents[indexOfCurrentVC + 1] : nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let indexOfCurrentVC = indexOfViewController(viewController)
        return indexOfCurrentVC > 0 ? contents[indexOfCurrentVC - 1] : nil
    }
    
    
    // page view controller delegate
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        
        let newViewController = pageViewController.viewControllers![0] as UIViewController
        pageControl.currentPage = indexOfViewController(newViewController)
    }
}