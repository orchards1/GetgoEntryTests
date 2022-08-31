//
//  ViewController.swift
//  GetgoEntryTests
//
//  Created by Michael Louis on 31/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var service = Service()
    var characters : [Characters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        service.getCharacters { char in
            self.characters = char
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Detail", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        vc.detail = characters[indexPath.row]
        navigationController?.pushViewController(vc, animated:true)
        
    }
}

