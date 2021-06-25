
import UIKit

//Constants
extension CGFloat{
    
    //cornerRadius
    static let cornerRadius:CGFloat = 15
    
    //MARK: Constraints
    //standalone top
    static let topStandAloneConstant:CGFloat = 50
    
    static let topConstant:CGFloat = 8
    static let leftConstant:CGFloat = 8
    static let rightConstant:CGFloat = -8
    static let bottomConstant:CGFloat = -8

}

// MARK: - Color
extension UIColor{
    static let Dark:UIColor = UIColor.label
    static let Light:UIColor = UIColor.label.withAlphaComponent(0.5)
    static let Indicator:UIColor = UIColor.systemIndigo
    static let Cell: UIColor = UIColor.systemGray6
}


// MARK: - Font
extension UIFont {

    public enum Custom: String {
        case AppleSDGothicNeo_Bold = "AppleSDGothicNeo-Bold"
        case AppleSDGothicNeo_Light = "AppleSDGothicNeo-Light"
        case AppleSDGothicNeo_Medium = "AppleSDGothicNeo-Medium"
        case AppleSDGothicNeo_Regular = "AppleSDGothicNeo-Regular"
        case AppleSDGothicNeo_SemiBold = "AppleSDGothicNeo_SemiBold"
        case AppleSDGothicNeo_Thin = "AppleSDGothicNeo-Thin"
        case AppleSDGothicNeo_UltraLight = "AppleSDGothicNeo-UltraLight"
    }

    static func custom(type: Custom = .AppleSDGothicNeo_Regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "\(type.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
