
//Khalid Moutaouakil

import UIKit

extension Home{
    
    func addsubviews(){
        label.text = "Today \n\(self.todayDate())"
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant*2),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topStandAloneConstant),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: view.frame.height*0.3),
            image.widthAnchor.constraint(equalToConstant: view.frame.width*0.3)
        ])
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: image.bottomAnchor, constant: .topStandAloneConstant),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 140),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
        button.addTarget(self, action: #selector(getQuote), for: .touchUpInside)
    }
    
    func todayDate()->String{
        let dateFor = DateFormatter()
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        dateFor.locale = Locale.init(identifier: "en")
        dateFor.dateFormat = "dd,MM,yyyy"
        dateFor.calendar = calendar
        
        let month = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        let date = dateFor.string(from: Date())
        let split = date.split(separator: ",")
        
        return "\(month[(Int(split[1]) ?? 0) - 1]) \(split[0]), \(split[2])"
    }
    
    @objc private func getQuote(){
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
        if let parent = self.parentVC{
            let vc = GetQuoteVC()
            vc.modalPresentationStyle = .overFullScreen
            parent.present(vc, animated: true, completion: nil)
        }
    }
}
