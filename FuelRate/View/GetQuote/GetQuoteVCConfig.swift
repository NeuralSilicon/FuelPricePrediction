
//Zhiyuan Sun

import UIKit

extension GetQuoteVC{
    
    func addsubviews(){
        
        
        view.addSubview(close)
        NSLayoutConstraint.activate([
            close.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant + .topConstant),
            close.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant*2),
            close.heightAnchor.constraint(equalToConstant: 40),
            close.widthAnchor.constraint(equalToConstant: 40)
        ])
        close.addTarget(self, action: #selector(dimiss), for: .touchUpInside)
        
        view.addSubview(card)
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant*4),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant*4),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant*4),
            card.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(.topStandAloneConstant*4))
        ])
       
        
        card.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: card.topAnchor, constant: -.topStandAloneConstant),
            image.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: view.frame.height*0.2),
            image.widthAnchor.constraint(equalToConstant: view.frame.width*0.2)
        ])
        
        card.addSubview(gallonLabel)
        NSLayoutConstraint.activate([
            gallonLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: .topStandAloneConstant),
            gallonLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            gallonLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            gallonLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        card.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: gallonLabel.bottomAnchor),
            textField.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 120),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        textField.setNeedsDisplay()
 
        card.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: .topConstant),
            label.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        card.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topConstant),
            datePicker.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            datePicker.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            datePicker.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        card.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: .topStandAloneConstant),
            button.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        button.addTarget(self, action: #selector(getQuote), for: .touchUpInside)
        
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.widthAnchor.constraint(equalToConstant: 40)
        ])
        
    }

    // Ian Cooper
    @objc private func dimiss(){
        self.dismiss(animated: true, completion: nil)
    }
    // Ian Cooper
    @objc private func getQuote(){
        guard let amount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
              , let uuid = UserDefaults.standard.value(forKey: "uuid") as? String
         else {
            return
        }
        
        if amount == "" || amount == "0"{return}
        
        let toDate = datePicker.date
        let month =
            ["January","February","March","April","May","June","July","August","September","October","November","December"][Calendar.current.component(.month, from: toDate) - 1]
        let day = Calendar.current.component(.day, from: toDate)
        let year = Calendar.current.component(.year, from: toDate)
        
        fuelQuote = FuelQuote()
        fuelQuote.useruuid = uuid
        fuelQuote.gallonsRequested = Double(amount) ?? 0
        fuelQuote.delivaryDate = String(describing: "\(month) \(day), \(year)")
        fuelQuote.requestedDate = String(describing: "\(Date())")
        let fuelPrice = FuelPrice(fuelQuote: fuelQuote)
        fuelPrice.delegate = self
        fuelPrice.calculate()
    }
}

// Ian Cooper
extension GetQuoteVC:FuelPriceDelegate{
    func calculated(value: FuelQuote, address:Address) {
      
        let vc = FuelPriceVC()
        vc.fuelQuote = value ; vc.address = address
        vc.button.isHidden = false
        
        var transform = CGAffineTransform(rotationAngle: -.pi/2)
        transform = transform.translatedBy(x: 0, y: -view.frame.height*0.7)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: .beginFromCurrentState) {
            self.close.alpha = 0.0
            self.card.transform = transform
        } completion: { _ in
            self.loading.startAnimating()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

                self.present(vc, animated: true, completion: {
                    self.card.transform = .identity
                    self.close.alpha = 1.0
                    self.loading.stopAnimating()
                })
            }
        }
    }
    
}
