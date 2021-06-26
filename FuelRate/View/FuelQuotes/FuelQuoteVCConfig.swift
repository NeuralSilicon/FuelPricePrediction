

import UIKit

extension FuelQuoteVC{
    
    func addsubviews(){
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
        tableView.delegate = self; tableView.dataSource = self
        tableView.register(FuelQuoteCell.self, forCellReuseIdentifier: cellid)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topConstant),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant*2),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant*2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .bottomConstant)
        ])
        
        DatabaseStack.shared.RetrieveList()
        DatabaseStack.shared.group.notify(queue: .main) {
            self.fuelQuotes = DatabaseStack.shared.fuelQuotes
            self.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .middle)
        }
    }
    
}

extension FuelQuoteVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.05
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fuelQuotes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? FuelQuoteCell{
            cell.label.text = "Gallons requested: " + fuelQuotes[indexPath.row].gallonsRequested.toString
            cell.date.text = "Delivary date: \n" + fuelQuotes[indexPath.row].delivaryDate
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

            let vc = FuelPriceVC()
            vc.fuelQuote = self.fuelQuotes[indexPath.row]
            
            guard self.address != nil else {
                DatabaseStack.shared.RetrieveAddress()
                DatabaseStack.shared.group.notify(queue: .main) {
                    self.address = DatabaseStack.shared.address
                    vc.address = self.address
                    self.present(vc, animated: true, completion: nil)
                }
                return
            }
            
            vc.address = self.address
            self.present(vc, animated: true, completion: nil)
        }

    }
}

class FuelQuoteCell: UITableViewCell {
    
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .left, fontSize: 17, font: .AppleSDGothicNeo_Light)
        return label
    }()
    
    var date:UILabel={
        let label = UILabel()
        label.Label(textColor: .Light, textAlignment: .right, fontSize: 15, font: .AppleSDGothicNeo_Light)
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
        contentView.backgroundColor = .clear
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topConstant),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .leftConstant),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .bottomConstant),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.width/2),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        
        contentView.addSubview(date)
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topConstant),
            date.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: .leftConstant*2),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .bottomConstant),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .rightConstant),
            date.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }
}
