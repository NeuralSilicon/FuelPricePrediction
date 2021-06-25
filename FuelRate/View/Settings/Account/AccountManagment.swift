
//Ian Cooper

import UIKit

class AccountManagment: UIViewController {
    
    let cellid = "SettingCell"
    var tableView:UITableView={
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.layer.cornerRadius = .cornerRadius
        table.layer.masksToBounds = true
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .center, fontSize: 30, font: .AppleSDGothicNeo_Medium)
        label.text = "Account Management"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addsubviews()
    }
    
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

extension AccountManagment:UITableViewDelegate, UITableViewDataSource{
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
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? SettingCell{
            cell.label.text = ["Update information","Reset password","Delete account","Sign out"][indexPath.section]
            cell.image.image = UIImage(systemName:
                                        ["person.fill","key.fill","person.fill.xmark", "xmark.circle.fill"][indexPath.section])?.applyingSymbolConfiguration(.init(pointSize: 15, weight: .regular))
            if indexPath.section == 2{
                cell.label.textColor = .systemRed
                cell.image.tintColor = .systemRed
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.deselectRow(at: indexPath, animated: true)
        } completion: { _ in
            switch indexPath.section{
            case 0:
                let vc = UpdateInfoVC()
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = ResetPassword()
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                self.deleteAccount()
            case 3:
                self.signOut()
            default:
                break
            }
        }

    }
}
