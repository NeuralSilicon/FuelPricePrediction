
//Zhiyuan Sun

import UIKit
import Firebase
import os

class ResetPassword: UIViewController {
    
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .center, fontSize: 30, font: .AppleSDGothicNeo_Medium)
        label.text = "Reset Password"
        return label
    }()
    
    var username:TextField={
        let text = TextField()
        text.placeholder = "Email Address"
        text.textAlignment = .left
        text.textColor = .Dark
        text.tag = 0
        text.returnKeyType = .next
        text.keyboardType = .emailAddress
        return text
    }()
    
    var passwordRequirement:UILabel={
        let label = UILabel()
        label.Label(textColor: .Light, textAlignment: .center, fontSize: 15, font: .AppleSDGothicNeo_Regular)
        label.text = "Link to reset your password will be send to your Email Address, and you will be signed out of the app!"
        return label
    }()
    
    var reset:UIButton={
        let button = UIButton()
        button.Button(text: "Reset")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addsubviews()
    }
    
}

extension ResetPassword:UITextFieldDelegate{
    
    func addsubviews(){
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant + .topConstant),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])

        username.delegate = self
        view.addSubview(username)
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topConstant),
            username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            username.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
     
        view.addSubview(passwordRequirement)
        NSLayoutConstraint.activate([
            passwordRequirement.topAnchor.constraint(equalTo: username.bottomAnchor, constant: .topConstant),
            passwordRequirement.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            passwordRequirement.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            passwordRequirement.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            passwordRequirement.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        view.addSubview(reset)
        NSLayoutConstraint.activate([
            reset.topAnchor.constraint(equalTo: passwordRequirement.bottomAnchor, constant: .topConstant),
            reset.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reset.widthAnchor.constraint(greaterThanOrEqualToConstant: 140),
            reset.heightAnchor.constraint(equalToConstant: 40),
        ])
        reset.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
    }
    
    @objc private func resetPassword(){
        
        guard let email = username.text, email != "" else {
            
            let activity = UIAlertController(title: nil, message: "Email Field is empty", preferredStyle: .alert)
            activity.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            self.present(activity, animated: true, completion: nil)
            
            return
        }
      
       
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil{
                os_log("\(error.debugDescription) - failed to reset password")

                let activity = UIAlertController(title: nil, message: "Email Address is not valid!", preferredStyle: .alert)
                activity.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                self.present(activity, animated: true, completion: nil)
            }else{
                self.signOut()
            }
        }
    }
    
    private func signOut(){
        do{
            try Auth.auth().signOut()

            UserDefaults.standard.setValue(nil, forKey: "uuid")
            UserDefaults.standard.setValue(nil, forKey: "password")
  
            let activity = UIAlertController(title: nil, message: "Email was sent", preferredStyle: .alert)
            self.present(activity, animated: true, completion: {
                NotificationCenter.default.post(name: .SignOut, object: nil)
            })
        }catch{
            os_log("\(error.localizedDescription)")
        }
    }
    
}
