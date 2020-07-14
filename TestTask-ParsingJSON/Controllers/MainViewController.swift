//
//  MainViewController.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var gender = Gender.unknown
    var usableArray = [Human]()
    var humanArray = [Human]()
    var childType = ChildType.table
    var sorted = false

    @IBOutlet weak var sortBtn: UIBarButtonItem!
    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var tableBtn: UIBarButtonItem!
    @IBOutlet weak var collectionBtn: UIBarButtonItem!
    @IBOutlet weak var filterSegmentedCntrl: UISegmentedControl!
    @IBOutlet weak var viewForChild: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        configLocalization()
        configUIElements(isLoaded: false)
        let jsonParser = JSONParser()
        jsonParser.parseJson(jsonUrlString: Constants.jsonUrlString) { (result) in
            switch result {
            case .success(let humans):
                self.usableArray = humans
                self.humanArray = humans
                print(self.usableArray.count)
                self.getChildVC(childType: self.childType)
                self.configUIElements(isLoaded: true)
            case .failure(let error):
                print("Can't parse JSON in MainVC")
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func configLocalization() {
        tableBtn.title = R.string.localizable.tableBtn_text()
        collectionBtn.title = R.string.localizable.collectionBtn_text()
        filterSegmentedCntrl.setTitle(R.string.localizable.segment0_text(),forSegmentAt: 0)
        filterSegmentedCntrl.setTitle(R.string.localizable.segment1_text(),forSegmentAt: 1)
        filterSegmentedCntrl.setTitle(R.string.localizable.segment2_text(),forSegmentAt: 2)
    }
    
    func configUIElements(isLoaded: Bool) {
        DispatchQueue.main.async {
            if isLoaded == false {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    func changeVC(vc: UIViewController) {
        vc.view.frame = viewForChild.bounds
        self.addChild(vc)
        viewForChild.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func getChildVC(childType: ChildType) {
        switch childType {
        case .table:
            DispatchQueue.main.async {
                guard let vc = R.storyboard.main.tableViewController() else { return }
                self.changeVC(vc: vc)
                vc.humanArray = self.usableArray
                vc.tableView.reloadData()
            }
        case .collection:
            DispatchQueue.main.async {
                guard let vc = R.storyboard.main.collectionViewController() else { return }
                self.changeVC(vc: vc)
                vc.humanArray = self.usableArray
                vc.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func sortBtnAction(_ sender: UIBarButtonItem) {
        let sorter = SortManager()
        if sorted == false {
            sender.image = UIImage(systemName: "arrow.up")
            usableArray = sorter.sortByIncrease(array: usableArray)
            getChildVC(childType: childType)
            sorted = true
        } else if sorted == true {
            sender.image = UIImage(systemName: "arrow.down")
            usableArray = sorter.sortByDecrease(array: usableArray)
            getChildVC(childType: childType)
            sorted = false
        }
    }
    
    @IBAction func refreshBtnAction(_ sender: UIBarButtonItem) {
        collectionBtn.tintColor = .blue
        tableBtn.tintColor = .black
        configUIElements(isLoaded: false)
        filterSegmentedCntrl.selectedSegmentIndex = 0
        sorted = false
        sortBtn.image = UIImage(systemName: "arrow.up.arrow.down")
        let jsonParser = JSONParser()
        jsonParser.parseJson(jsonUrlString: Constants.jsonUrlString) { (result) in
            switch result {
            case .success(let humans):
                self.usableArray = humans
                self.humanArray = humans
                print(self.usableArray.count)
                self.getChildVC(childType: self.childType)
                self.configUIElements(isLoaded: true)
            case .failure(let error):
                print("Can't parse JSON in MainVC")
                print(error)
            }
        }
    }
    @IBAction func tableBtnAction(_ sender: UIBarButtonItem) {
        collectionBtn.tintColor = .blue
        tableBtn.tintColor = .black
        childType = .table
        getChildVC(childType: childType)
    }
    @IBAction func collectionBtnAction(_ sender: UIBarButtonItem) {
        collectionBtn.tintColor = .black
        tableBtn.tintColor = .blue
        childType = .collection
        getChildVC(childType: childType)
    }
    @IBAction func filterSegmentedControlAction(_ sender: UISegmentedControl) {
        sorted = false
        sortBtn.image = UIImage(systemName: "arrow.up.arrow.down")
        let sorter = SortManager()
        if sender.selectedSegmentIndex == 0 {
            gender = .unknown
            usableArray = humanArray
            getChildVC(childType: childType)
        } else if sender.selectedSegmentIndex == 1 {
            gender = .male
            usableArray = sorter.sortByGender(gender: gender, array: humanArray)
            getChildVC(childType: childType)
        } else if sender.selectedSegmentIndex == 2 {
            gender = .female
            usableArray = sorter.sortByGender(gender: gender, array: humanArray)
            getChildVC(childType: childType)
        }
    }
    
}
