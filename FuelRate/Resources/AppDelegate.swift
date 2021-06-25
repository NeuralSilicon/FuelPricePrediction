
import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        
        guard let uuid = UserDefaults.standard.value(forKey: "uuid") as? String else {
            let vc = LoginVC()
            let navig = UINavigationController(rootViewController: vc)
            navig.navigationBar.isHidden = true
            window?.rootViewController = navig
            window?.makeKeyAndVisible()
            return true
        }
        
        if uuid == ""{
            let vc = LoginVC()
            let navig = UINavigationController(rootViewController: vc)
            navig.navigationBar.isHidden = true
            window?.rootViewController = navig
            window?.makeKeyAndVisible()
        }else{
            let vc = Tabbar()
            let navig = UINavigationController(rootViewController: vc)
            navig.navigationBar.isHidden = true
            window?.rootViewController = navig
            window?.makeKeyAndVisible()
        }


        return true
    }
}
