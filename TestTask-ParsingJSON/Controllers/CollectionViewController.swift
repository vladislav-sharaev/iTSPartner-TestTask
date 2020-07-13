//
//  CollectionViewController.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var humanArray = [Human]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()

    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.collectionCellID)
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return humanArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellID, for: indexPath) as! CollectionViewCell
        
        cell.indexPath = indexPath
        cell.nameLabel.text = humanArray[indexPath.row].name
        
        if humanArray[indexPath.row].gender == Gender.male {
            cell.nameLabel.text! +=  " 👨"
        } else if humanArray[indexPath.row].gender == Gender.female {
            cell.nameLabel.text! += " 👩"
        }
        
        if humanArray[indexPath.row].isActive == true {
            cell.isActiveBtn.backgroundColor = .green
        } else if humanArray[indexPath.row].isActive == false {
            cell.isActiveBtn.backgroundColor = .red
        } else {
            cell.isActiveBtn.backgroundColor = .gray
        }
        
        if let url = URL(string: (humanArray[indexPath.row].picture)!) {
            UrlLoaderManager.shared.downloadImage(url: url) { (data) in
                let image = UIImage(data: data)
                guard indexPath == cell.indexPath else { return }
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        } else {
            cell.photoImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.ageLabel.text = String(humanArray[indexPath.row].age ?? 00) + " " + "age_text".localized()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / CGFloat(Constants.cellsCountInARow)
        let heightCell = widthCell / 3.5
        let spacing = CGFloat(Constants.cellsCountInARow + 1) * CGFloat(Constants.offSet) / CGFloat(Constants.cellsCountInARow)
        
        return CGSize(width: widthCell - spacing, height: heightCell - (CGFloat(Constants.cellsCountInARow) * CGFloat(Constants.offSet)))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "MoreInformationViewController") as! MoreInformationViewController
        vc.indexPath = indexPath
        vc.human = humanArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
