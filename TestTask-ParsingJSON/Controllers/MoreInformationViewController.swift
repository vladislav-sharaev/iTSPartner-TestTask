//
//  MoreInformationViewController.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class MoreInformationViewController: UIViewController {
    var human: Human?
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isActiveLabel: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var favoriteFruit: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var guID: UILabel!
    
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var favoriteFruitLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var guIDLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLocalization()
        isActiveLabel.layer.cornerRadius = 10
        isActiveLabel.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let person = human {
            nameLabel.text = person.name
            
            if person.gender == Gender.male {
                nameLabel.text! +=  " 👨"
            } else if person.gender == Gender.female {
                nameLabel.text! += " 👩"
            }
            
            if person.isActive == true {
                isActiveLabel.backgroundColor = .green
            } else if person.isActive == false {
                isActiveLabel.backgroundColor = .red
            } else {
                isActiveLabel.backgroundColor = .gray
            }
            
            if let url = URL(string: (person.picture)!) {
                UrlLoaderManager.shared.downloadImage(url: url) { (result) in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.pictureImageView.image = image
                        }
                    case .failure(let error):
                        print("Cant load human image in MoreInformationViewController")
                        print(error)
                    }
                }
            } else {
                pictureImageView.image = R.image.defaultImage()
            }
            
            age.text = String(person.age ?? 00)
            balance.text = person.balance
            favoriteFruit.text = person.favoriteFruit
            eyeColor.text = person.eyeColor
            guID.text = person.guid
            guard let id = person._id else { return }
            navigationItem.title = R.string.localizable.id() + id
        }
    }

    func configLocalization() {
        eyeColorLabel.text = R.string.localizable.eyeColor_text()
        ageLabel.text = R.string.localizable.age2_text()
        favoriteFruitLabel.text = R.string.localizable.favoriteFruit_text()
        balanceLabel.text = R.string.localizable.balance_text()
        guIDLable.text = R.string.localizable.guID_text()
    }
}
