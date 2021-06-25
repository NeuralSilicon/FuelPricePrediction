
//Ian Cooper

import UIKit

extension NSNotification.Name{
    static let SignOut = NSNotification.Name("SignOut")
}

extension Double{
    var toString:String{
        return String(describing: self)
    }
}

extension String {
    func toDouble() -> Double{
        return NumberFormatter().number(from: self)?.doubleValue ?? 0
    }
}

extension UILabel{
    func Label(textColor:UIColor, textAlignment: NSTextAlignment, fontSize:CGFloat, font:UIFont.Custom){
        self.text = ""
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont.custom(type: font,
                                  size: UIDevice.current.userInterfaceIdiom == .pad ?
                                  fontSize + 2:
                                  fontSize
                                  )
    }
    
}


extension UIButton{
    
    func Button(text:String){
        self.setAttributedTitle(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.custom(type: .AppleSDGothicNeo_Regular, size: 18), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        self.backgroundColor = .Indicator
        self.layer.cornerRadius = .cornerRadius
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}



extension UIImageView{
    func GasImage(){
        self.image = UIImage(named: "gas-pump")
        self.contentMode = .scaleAspectFill
        self.tintColor = .clear
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


func attribute(for text:String, size:Int, font:UIFont.Custom, color:UIColor) -> NSAttributedString{
    return NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.custom(type: font, size: CGFloat(size)), NSAttributedString.Key.foregroundColor: color])
}


