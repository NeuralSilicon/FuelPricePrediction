
//Ian Cooper
import UIKit

class PrivacyVC: UIViewController {
    var TextView: UITextView={
        let TextView = UITextView()
        TextView.translatesAutoresizingMaskIntoConstraints = false
        TextView.isUserInteractionEnabled = true
        TextView.isEditable = false
        TextView.backgroundColor = .clear
        TextView.layoutIfNeeded()
        TextView.textColor = .Dark
        TextView.setContentOffset(CGPoint.zero, animated: false)
        return TextView
    }()
    
    var titleLabel:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .center, fontSize: 30, font: .AppleSDGothicNeo_Light)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        addsubview()
    }

    
    private func addsubview(){
        
        titleLabel.text = "Privacy"
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .topStandAloneConstant),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .leftConstant),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .rightConstant),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
        self.view.addSubview(TextView)
        NSLayoutConstraint.activate([
            TextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .topConstant),
            TextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            TextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            TextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .bottomConstant)
        ])

        let str = "\n ⚠️ We may collect anonymous statistical information such as locations that are being used to help us improve the app. However, your inputs are stored securely inside the phone, and Google Database and are not accessible to anyone.\n\n ⚠️ This is a free app that is provided by Google services which collects anonymous statistical information and by using this application made by Ian Cooper and Team, you are agreeing to this information. To find out more about Google Privacy, "

        let attributedString = self.ReturnBoldNormalText(BoldText: "Privacy Policy and Terms of Use", NormalText: str)
        
        self.TextView.attributedText = attributedString
    }
    

    func ReturnBoldNormalText(BoldText:String,NormalText:String)->NSMutableAttributedString{
        let url = URL(string: "https://firebase.google.com/support/privacy")!
        
        let boldText  = BoldText + "\n"
        let attrs = [NSAttributedString.Key.font : UIFont.custom(type: .AppleSDGothicNeo_Medium, size: 20),NSAttributedString.Key.foregroundColor:UIColor.Dark]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = NormalText
        let attr = [NSAttributedString.Key.font : UIFont.custom(type: .AppleSDGothicNeo_Regular, size: 20),NSAttributedString.Key.foregroundColor:UIColor.Dark]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attr)

        attributedString.append(normalString)
        
        let linkText = NSMutableAttributedString(string: "Privacy Policy and Terms of Use.", attributes: [NSAttributedString.Key.link: url,NSAttributedString.Key.font : UIFont.custom(type: .AppleSDGothicNeo_Medium, size: 20),NSAttributedString.Key.foregroundColor:UIColor.Dark])
        
        attributedString.append(linkText)
        
        return attributedString
    }
}
