
//Zhiyuan Sun

import UIKit

extension UpdateInfoVC{
    
    func addsubviews(){
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant + .topConstant),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])

        password.delegate = self
        view.addSubview(password)
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topConstant),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            password.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(passwordRequirement)
        NSLayoutConstraint.activate([
            passwordRequirement.topAnchor.constraint(equalTo: password.bottomAnchor, constant: .topConstant),
            passwordRequirement.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            passwordRequirement.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            passwordRequirement.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            passwordRequirement.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        view.addSubview(loadmore)
        NSLayoutConstraint.activate([
            loadmore.topAnchor.constraint(equalTo: passwordRequirement.bottomAnchor, constant: .topConstant),
            loadmore.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadmore.widthAnchor.constraint(greaterThanOrEqualToConstant: 140),
            loadmore.heightAnchor.constraint(equalToConstant: 40),
        ])
        loadmore.addTarget(self, action: #selector(LoadMore), for: .touchUpInside)
    
    }
    
    @objc private func LoadMore(){

        if !checkUserPass(){
            let activity = UIAlertController(title: nil, message: "Password is either empty or is not correct", preferredStyle: .alert)
            activity.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            self.present(activity, animated: true, completion: nil)
            return
        }
        
        guard registerationForm == nil && address == nil else {
            return
        }
        
                
        registerationForm = RegisterationForm(frame: self.view.bounds)
        registerationForm.parentPage = self
        registerationForm.clipsToBounds = true
        view.addSubview(registerationForm)
        NSLayoutConstraint.activate([
            registerationForm.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topConstant),
            registerationForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerationForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerationForm.heightAnchor.constraint(equalToConstant: view.frame.height*0.35),
            registerationForm.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        self.registerationForm.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
        DatabaseStack.shared.RetrieveAddress()
        DatabaseStack.shared.group.notify(queue: .main) {
            self.address = DatabaseStack.shared.address
            self.registerationForm.fullname.text = self.client.fullname
            self.registerationForm.addresslineone.text = self.address.addressLineOne
            self.registerationForm.addresslinetwo.text = self.address.addressLineTwo
            self.registerationForm.city.text = self.address.city
            self.registerationForm.state.text = self.address.state
            self.registerationForm.zipcode.text = self.address.zipcode
        }
        
        DispatchQueue.main.async {
            self.registerationForm.contentSize.height += 400
        }
        
        view.addSubview(update)
        NSLayoutConstraint.activate([
            update.topAnchor.constraint(equalTo: registerationForm.bottomAnchor),
            update.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            update.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            update.heightAnchor.constraint(equalToConstant: 40),
        ])
        update.addTarget(self, action: #selector(updateInformation), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.5) {
            self.password.alpha = 0.0; self.loadmore.alpha = 0.0; self.passwordRequirement.alpha = 0.0
            self.registerationForm.transform = .identity
        }
        
    }
    
    private func checkUserPass()->Bool{
        guard let password = password.text, let pass = UserDefaults.standard.value(forKey: "password") as? String else {return false}
        return pass == password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @objc func updateInformation(){
        guard let fullname = registerationForm.fullname.text,
              let addressline1 = registerationForm.addresslineone.text,
              let addressline2 = registerationForm.addresslinetwo.text,
              let city = registerationForm.city.text,
              let state = registerationForm.state.text,
              let zipcode = registerationForm.zipcode.text
        else{return}
        
        client.fullname = fullname.trimmingCharacters(in: .whitespacesAndNewlines)
        
        address.addressLineOne = addressline1.trimmingCharacters(in: .whitespacesAndNewlines)
        address.addressLineTwo = addressline2.trimmingCharacters(in: .whitespacesAndNewlines)
        address.city = city.trimmingCharacters(in: .whitespacesAndNewlines)
        address.state = state.trimmingCharacters(in: .whitespacesAndNewlines)
        address.zipcode = zipcode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Validation().checkvalidation(client: client, address: address, parent: self) { valid in
            if valid{
                let modify = Modification(client: self.client, address: self.address)
                modify.delegate = self
                modify.update()
            }
        }
    }
}
