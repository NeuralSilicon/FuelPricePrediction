
//Ian Cooper

import UIKit
import os

protocol StateDelegate {
    func selectedStated(with abbreviation:String)
}

class StateDropDown: UIViewController {
    
    var states:[[String : String]]=[[:]]
    
    let cellid = "StateCell"
    var tableView:UITableView={
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorColor = .Light
        table.layer.cornerRadius = .cornerRadius
        table.layer.masksToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    var container:UIView!
    var position:CGRect! // position for our tableview to be aligned with bar
    var delegate:StateDelegate?
    
    func addsubviews(){
       
        readJson()
        
        tableView.delegate = self; tableView.dataSource = self
        tableView.register(StateCell.self, forCellReuseIdentifier: cellid)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: position.origin.y + position.height),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.layoutIfNeeded()
        
        container = UIView(frame: tableView.frame)
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = .cornerRadius
        container.layer.shadowColor = UIColor.Light.cgColor
        container.layer.shadowRadius = 10
        container.layer.shadowOffset = .zero
        container.layer.shadowOpacity = 0.5
        container.layer.shadowPath = UIBezierPath(rect: container.bounds).cgPath
        view.insertSubview(container, belowSubview: tableView)
    }
    
    private func readJson(){
        /*
         file was copied from
         https://gist.github.com/mshafrir/2646763#file-states_titlecase-json
         */
        do {
            if let file = Bundle.main.url(forResource: "states", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                self.states = json as? [[String : String]] ?? [[:]]
            }
        } catch {
             print("Error info: \(error)")
        }
    }
    
}

extension StateDropDown:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? StateCell{
            
            cell.name.text = states[indexPath.row]["name"]! + " " + states[indexPath.row]["abbreviation"]!
            
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.05
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.05
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.selectedStated(with: self.states[indexPath.row]["abbreviation"] ?? "N/A")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let posi = touch.location(in: view)
            if !tableView.frame.contains(posi){
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

class StateCell: UITableViewCell {
    
    var name:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .left, fontSize: 20, font: .AppleSDGothicNeo_Bold)
        return label
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
        self.layer.cornerRadius = .cornerRadius
        self.layer.masksToBounds = true
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topConstant),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .leftConstant),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .bottomConstant),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .rightConstant),
            name.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }
}
