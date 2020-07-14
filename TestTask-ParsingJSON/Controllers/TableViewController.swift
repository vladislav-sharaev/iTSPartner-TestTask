//
//  TableViewController.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var humanArray = [Human]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTalbeView()

    }
    
    func configTalbeView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return humanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.tableViewCell, for: indexPath) else {
            let cell = UITableViewCell()
            return cell
        }
        
        cell.indexPath = indexPath
        cell.nameLabel.text = humanArray[indexPath.row].name
        
        if humanArray[indexPath.row].gender == Gender.male {
            cell.nameLabel.text! +=  " 👨"
        } else if humanArray[indexPath.row].gender == Gender.female {
            cell.nameLabel.text! += " 👩"
        }
        
        if humanArray[indexPath.row].isActive == true {
            cell.isActiveLabel.backgroundColor = .green
        } else if humanArray[indexPath.row].isActive == false {
            cell.isActiveLabel.backgroundColor = .red
        } else {
            cell.isActiveLabel.backgroundColor = .gray
        }
        
        if let url = URL(string: (humanArray[indexPath.row].picture)!) {
            UrlLoaderManager.shared.downloadImage(url: url) { (result) in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    guard indexPath == cell.indexPath else { return }
                    DispatchQueue.main.async {
                        cell.photoImageView.image = image
                    }
                case .failure(let error):
                    print("Cant load human image in TableViewController")
                    print(error)
                }
            }
        } else {
            cell.photoImageView.image = R.image.defaultImage()
        }
        
        cell.ageLabel.text = String(humanArray[indexPath.row].age ?? 00) + " " + R.string.localizable.age_text()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = R.storyboard.main.moreInformationViewController() else { return }
        vc.indexPath = indexPath
        vc.human = humanArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
