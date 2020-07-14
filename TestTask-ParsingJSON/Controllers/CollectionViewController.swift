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
    let cellsCountInARow = 2
    let offSet: CGFloat = 8.0
    let collectionCellID = "CollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()

    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.collectionViewCell)
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return humanArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.collectionViewCell, for: indexPath) else {
            let cell = UICollectionViewCell()
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
            cell.isActiveBtn.backgroundColor = .green
        } else if humanArray[indexPath.row].isActive == false {
            cell.isActiveBtn.backgroundColor = .red
        } else {
            cell.isActiveBtn.backgroundColor = .gray
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
                    print("Cant load human image in CollectionViewController")
                    print(error)
                }
            }
        } else {
            cell.photoImageView.image = R.image.defaultImage()
        }
        
        cell.ageLabel.text = String(humanArray[indexPath.row].age ?? 00) + " " + R.string.localizable.age_text()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / CGFloat(cellsCountInARow)
        let heightCell = widthCell 
        let spacing = CGFloat(cellsCountInARow + 1) * offSet / CGFloat(cellsCountInARow)
        
        return CGSize(width: widthCell - spacing, height: heightCell - (CGFloat(cellsCountInARow) * offSet))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = R.storyboard.main.moreInformationViewController() else { return } 
        vc.indexPath = indexPath
        vc.human = humanArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
