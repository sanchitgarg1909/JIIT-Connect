//
//  ViewController.swift
//  JIIT Connect
//
//  Created by Sanchit Garg on 27/11/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

import UIKit

class TimeTableController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let numberOfDays = 6
    let mondayCellId = "monday"
    let tuesdayCellId = "tuesday"
    let wednesdayCellId = "wednesday"
    let thursdayCellId = "thursday"
    let fridayCellId = "friday"
    let saturdayCellId = "saturday"
    let titles = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Monday"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setUpMenuBar()
//        setUpNavBarButtons()
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(BaseDayCell.self, forCellWithReuseIdentifier: mondayCellId)
//        collectionView?.register(TuesdayCell.self, forCellWithReuseIdentifier: tuesdayCellId)
//        collectionView?.register(WednesdayCell.self, forCellWithReuseIdentifier: wednesdayCellId)
//        collectionView?.register(WednesdayCell.self, forCellWithReuseIdentifier: thursdayCellId)
//        collectionView?.register(WednesdayCell.self, forCellWithReuseIdentifier: fridayCellId)
//        collectionView?.register(WednesdayCell.self, forCellWithReuseIdentifier: saturdayCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.timeTableController = self
        return mb
    }()
    
    private func setUpMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
//    func setUpNavBarButtons(){
//        
//        let searchButton = UIBarButtonItem(image: UIImage(named: "ic_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
//        
//        let moreButton = UIBarButtonItem(image: UIImage(named: "ic_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
//        
//        navigationItem.rightBarButtonItems = [moreButton,searchButton]
//    }
//    
//    func handleSearch(){
//        print(456)
//    }
//    
//    func handleMore(){
//        print(123)
//    }
    
    func setTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / CGFloat(numberOfDays)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
        setTitleForIndex(index: Int(index))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDays
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let identifier: String
//        if indexPath.item == 0 {
//            identifier = trendingCellId
//        } else if indexPath.item == 1 {
//            identifier = subscriptionCellId
//        } else if indexPath.item == 2 {
//            identifier = subscriptionCellId
//        } else if indexPath.item == 3 {
//            identifier = subscriptionCellId
//        } else if indexPath.item == 4 {
//            identifier = subscriptionCellId
//        } else if indexPath.item == 5 {
//            identifier = subscriptionCellId
//        } else if indexPath.item == 6 {
//            identifier = subscriptionCellId
//        }
//        switch indexPath.item {
//        case 0:
//            
//        case 1:
//            
//        case 2:
//            
//        case 3:
//            
//        case 4:
//            
//        case 5:
//            
//        case 6:
//            
//        default:
//            
//        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mondayCellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }


}

