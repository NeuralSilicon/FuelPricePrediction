
//Zhiyuan Sun

import UIKit
import MessageUI
import os

extension Setting{
    
    func addsubviews(){
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant + .topConstant),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
        tableView.delegate = self; tableView.dataSource = self
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellid)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topConstant),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant*2),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant*2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .bottomConstant)
        ])
    }
    
}

extension Setting:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? SettingCell{
            cell.label.text = ["Account","Privacy","Feedback"][indexPath.section]
            cell.image.image = UIImage(systemName:
                                        ["person.fill","hand.raised.fill","message.fill"][indexPath.section])?.applyingSymbolConfiguration(.init(pointSize: 12, weight: .light))
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4) {
            tableView.deselectRow(at: indexPath, animated: true)
        } completion: { _ in
            switch indexPath.section{
            case 0:
                let vc = AccountManagment()
                self.parent?.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = PrivacyVC()
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                self.sendEmail()
            default:
                break
            }
        }

    }
}

extension Setting: MFMailComposeViewControllerDelegate{
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["cooper@gmail.com"])
            mail.setMessageBody("<p>Give us suggestions or tells us where you are having problem with the app to be addressed by our team.</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            os_log("Could not compose email")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

class SettingCell: UITableViewCell {
    
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .left, fontSize: 20, font: .AppleSDGothicNeo_Medium)
        return label
    }()
    
    var image:UIImageView={
       let img = UIImageView()
        img.backgroundColor = .clear
        img.tintColor = .Dark
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addsubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addsubviews(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 25),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layoutIfNeeded()
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topConstant),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: .leftConstant),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .bottomConstant),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        
    }
}
