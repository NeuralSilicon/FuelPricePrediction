
// Ian Cooper

import UIKit
import StoreKit
import CoreData

class Tabbar:UIViewController, UIPageViewControllerDelegate, UIScrollViewDelegate{

    var tabbar:UIView!

    var menu:[UIButton]!
    var buttonTag:Int = 0
    
    var containerView:UIView!
    var pageViewController: UIPageViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
        NotificationCenter.default.addObserver(self, selector: #selector(Signout), name: .SignOut, object: nil)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.containerView.layoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard pageViewController == nil else {
            return
        }
        configPageController()
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        //reset pagecontroller
        menus(menu[0])
    }
    
    @objc private func Signout(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: {
                let vc = LoginVC()
                let navig = UINavigationController(rootViewController: vc)
                navig.navigationBar.isHidden = true
                appDelegate.window?.rootViewController = navig
                appDelegate.window?.makeKeyAndVisible()
            })
        }
    }
    
}
