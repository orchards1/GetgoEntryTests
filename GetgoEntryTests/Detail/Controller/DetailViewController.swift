//
//  DetailViewController.swift
//  GetgoEntryTests
//
//  Created by Michael Louis on 31/08/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    
    var detail : Characters?
    var content : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content.append(detail?.name ?? "")
        content.append(detail?.species.rawValue ?? "")
        content.append(detail?.status.rawValue ?? "")
        if let imgUrl = detail?.image {
            self.imageView.setImageFrom(imgUrl)
        }
    }
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = content[indexPath.row]
        return cell
    }
    
    
}

extension UIImageView {
    
    func setImageFrom(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        
        let downloadImageTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let imageData = data {
                    DispatchQueue.main.async {[weak self] in
                        let downloadedImage = UIImage(data: imageData)
                        self?.image = downloadedImage
                    }
                }
            }
            session.finishTasksAndInvalidate()
        }
        downloadImageTask.resume()
    }
    
}


