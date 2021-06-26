
//Ian Cooper

import UIKit

class FuelPriceVC: UIViewController {
    let cellid:String = "FuelPriceCell"
    
    var tableView:UITableView={
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.layer.cornerRadius = .cornerRadius
        table.layer.masksToBounds = true
        table.separatorStyle = .none
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .left, fontSize: 30, font: .AppleSDGothicNeo_Regular)
        return label
    }()
    
    var close:UIButton={
        let button = UIButton()
        button.Button(text: "")
        button.setImage(UIImage(systemName: "xmark")?.applyingSymbolConfiguration(.init(pointSize: 15, weight: .regular)), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var fuelQuote:FuelQuote!
    var address:Address!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addsubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIView.animate(withDuration: 0.4) {
                self.tableView.transform = .identity
            }
        }
    }
}
