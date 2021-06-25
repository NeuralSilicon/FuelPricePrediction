
//Ian Cooper

import UIKit

class TextField: UITextField {
    
    override var placeholder: String?{
        set{
            guard let value = newValue else {return}
            self.attributedPlaceholder = attribute(for: value
                                                   , size: 18
                                                   , font: .AppleSDGothicNeo_Bold
                                                   , color: UIColor.Light.withAlphaComponent(0.7))
        }
        get{
            return self.placeholder
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        let startingPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let lineWidth: CGFloat = 3.0
        context.setLineWidth(lineWidth)
    
        context.setLineDash(phase: 0, lengths: [2, 5])
        context.setStrokeColor(UIColor.Light.cgColor)
        context.setFillColor(UIColor.Light.cgColor)
                    
        context.move(to: startingPoint )
        context.addLine(to: endingPoint )
        
        context.strokePath()
    }
    
    private func addsubviews(){
        
        let leftpad = UIView()
        leftpad.frame.size = CGSize(width: 12, height: self.frame.height)
        leftpad.backgroundColor = .clear
        self.leftView = leftpad
        self.leftViewMode = .always
        
        let rightpad = UIView()
        rightpad.frame.size = CGSize(width: 12, height: self.frame.height)
        rightpad.backgroundColor = .clear
        self.rightView = rightpad
        self.rightViewMode = .always
        
        self.minimumFontSize = 12
        self.textAlignment = .center
        self.borderStyle = .none
        self.backgroundColor = .clear
        self.textColor = .white
        self.layer.masksToBounds = false

        self.font = UIFont.custom(type: .AppleSDGothicNeo_Bold, size: 22)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addDoneButtonOnKeyboard()
    }
    
    var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = .lightGray
        
        let remove: UIBarButtonItem = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(self.clearButtonAction))
        remove.tintColor = .lightGray
        
        let items = [remove,flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    @objc func clearButtonAction(){
        self.text = ""
    }
    
}
