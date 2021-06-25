
//Khalid Moutaouakil

import UIKit

class Home: UIViewController {
    
    var image:UIImageView={
        let img = UIImageView()
        img.GasImage()
        return img
    }()
        
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .center, fontSize: 30, font: .AppleSDGothicNeo_Regular)
        return label
    }()
    
    var button:UIButton={
        let button = UIButton()
        button.Button(text: "Care for a Quote")
        return button
    }()
    
    weak var parentVC:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        addsubviews()
    }
    
}


