
import UIKit

class FuelQuoteVC: UIViewController {
    
    let cellid:String = "FuelQuoteCell"
    
    var label:UILabel={
        let label = UILabel()
        label.Label(textColor: .Dark, textAlignment: .center, fontSize: 30, font: .AppleSDGothicNeo_Medium)
        label.text = "Previous Quotes"
        return label
    }()
    
    var tableView:UITableView={
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.layer.cornerRadius = .cornerRadius
        table.layer.masksToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var fuelQuotes:[FuelQuote]=[]
    var address:Address!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addsubviews()
    }
    
}
