
//Ian Cooper

import UIKit

extension FuelPriceVC{
    
    func addsubviews(){
        
        view.addSubview(close)
        NSLayoutConstraint.activate([
            close.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant),
            close.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant*2),
            close.heightAnchor.constraint(equalToConstant: 40),
            close.widthAnchor.constraint(equalToConstant: 40)
        ])
        close.addTarget(self, action: #selector(dimiss), for: .touchUpInside)
        
        label.text = "Requested Fuel Rate"
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: .topStandAloneConstant),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
        tableView.delegate = self; tableView.dataSource = self; tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.register(FuelPriceCell.self, forCellReuseIdentifier: cellid)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .topConstant*2),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leftConstant*2),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .rightConstant*2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .bottomConstant)
        ])
        tableView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .bottomConstant*4),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        
    }
    @objc private func save(){
        let fuelPrice = FuelPrice(fuelQuote: self.fuelQuote)
        fuelPrice.address = self.address
        fuelPrice.saveQuote()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func dimiss(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension FuelPriceVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        let label = UILabel(frame: view.bounds)
        label.Label(textColor: .Light, textAlignment: .left, fontSize: 18, font: .AppleSDGothicNeo_Regular)
        label.text = ["Delivary Address","Delivary Date","Gallons Requested","Suggested price per gallon", "Total amount due"][section]
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return address == nil ? 0 : 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? FuelPriceCell{
            cell.label.text = ["\(address.addressLineOne) \(address.addressLineTwo), \(address.city) \(address.state) \(address.zipcode)","\(fuelQuote.delivaryDate)","\(fuelQuote.gallonsRequested)","$\(fuelQuote.suggestedPricePerGallon)","$\(fuelQuote.totalAmountDue)"][indexPath.section]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        UIView.animate(withDuration: 0.5) {
            view.transform = .identity
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        UIView.animate(withDuration: 0.5) {
            cell.transform = .identity
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.05
    }
}

class FuelPriceCell: UITableViewCell {
    
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .left, fontSize: 20, font: .AppleSDGothicNeo_Medium)
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
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .rightConstant),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        
    }
}

