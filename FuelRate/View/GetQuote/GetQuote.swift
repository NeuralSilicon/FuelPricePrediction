//Zhiyuan Sun


import UIKit

class GetQuoteVC: UIViewController {
    
    var card:UIView={
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = .cornerRadius
        view.layer.shadowColor = UIColor.Dark.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var close:UIButton={
        let button = UIButton()
        button.Button(text: "")
        button.alpha = 0.0
        button.setImage(UIImage(systemName: "xmark")?.applyingSymbolConfiguration(.init(pointSize: 15, weight: .regular)), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var image:UIImageView={
        let img = UIImageView()
        img.GasImage()
        return img
    }()
    
    var button:UIButton={
        let button = UIButton()
        button.Button(text: "Get a Quote")
        return button
    }()
    
    var gallonLabel:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .center, fontSize: 20, font: .AppleSDGothicNeo_SemiBold)
        label.text = "Gallons requested"
        return label
    }()
    
    var textField:TextField={
        let text = TextField()
        text.placeholder = "00"
        text.textColor = .Indicator
        text.keyboardType = .numberPad
        return text
    }()
    
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .center, fontSize: 20, font: .AppleSDGothicNeo_SemiBold)
        label.text = "Delivary date"
        return label
    }()
    
    var datePicker:UIDatePicker={
       let datePicker = UIDatePicker()
        datePicker.calendar = .current
        datePicker.locale = .current
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .Indicator
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    var loading:UIActivityIndicatorView={
        let act = UIActivityIndicatorView(style: .large)
        act.color = .Indicator
        act.translatesAutoresizingMaskIntoConstraints = false
        return act
    }()
    
    var fuelQuote:FuelQuote!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addsubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.close.alpha = 1.0
        }
        card.layer.shadowPath = UIBezierPath(roundedRect: card.bounds, cornerRadius: .cornerRadius).cgPath
    }
    
}
