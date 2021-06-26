// Ian Cooper

import UIKit

extension Tabbar:UIPageViewControllerDataSource, TabbarPortocol{
    
    //MARK: - Handle button selections or cell selections
    func tabbarHandler(index: Int) {
    }

    
    //MARK: -Model Handler
    func pageControllerIndex(for index:Int){
        let startingViewController: UIViewController = viewControllerAtIndex(index)!
        let viewControllers = [startingViewController]
            viewControllers.first?.view.frame = self.containerView.bounds
        self.pageViewController.setViewControllers(viewControllers,
                                                   direction: .forward
                                                       , animated: false, completion: {done in })
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.index(for: viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index)
     }
     
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.index(for: viewController)
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == 3 {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func index(for viewController:UIViewController) -> Int{
        return viewController.view.tag
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {

        if (index == -1) || (index >= 3){
            return nil
        }
        
        self.view.bringSubviewToFront(containerView)
        switch index {
        case 0: // Home
            let vc = Home()
            vc.parentVC = self
            return vc
        case 1: // PreviousQuotes
            let vc = FuelQuoteVC()
            return vc
        case 2: // setting
            let vc = Setting()
            let navig = UINavigationController(rootViewController: vc)
            navig.navigationBar.isHidden = true
            return navig
        default:
            break
        }
    
        return nil
    }

    
}
