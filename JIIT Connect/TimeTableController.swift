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
    let mondayCellId = Days.Monday.rawValue
    let tuesdayCellId = Days.Tuesday.rawValue
    let wednesdayCellId = Days.Wednesday.rawValue
    let thursdayCellId = Days.Thursday.rawValue
    let fridayCellId = Days.Friday.rawValue
    let saturdayCellId = Days.Saturday.rawValue
    let titles = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var schedule: Schedule? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        perform(#selector(handleLogout), with: nil, afterDelay: 0)

        //        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Monday"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        let preferences = UserDefaults.standard
        if let timetable = preferences.string(forKey: "timetable") {
            ApiService.sharedInstance.parseResponse(jsonString: timetable, completionHandler: { result in
                guard result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("network error")
                    print(result.error!)
                    return
                }
                guard let schedule = result.value else {
                    print("error in json response")
                    return
                }
                // success!
                self.schedule = schedule
                self.collectionView?.reloadData()
                //                loadingDialog.hide(animated: true)
            })
        } else {
            fetchSchedule()
        }
        setupCollectionView()
        setUpMenuBar()
//        setUpNavBarButtons()
        
    }
    
    func handleLogout() {
        present(LoginController(), animated: true, completion: nil)
    }
    
    func fetchSchedule() {
        let loadingDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingDialog.animationType = .zoomOut
        loadingDialog.label.text = "Loading"

        
        ApiService.sharedInstance.fetchTimeTable(urlString: "timetable.json", completionHandler: { result in
            guard result.error == nil else {
                // got an error in getting the data, need to handle it
                print("network error")
                print(result.error!)
                return
            }
            guard let schedule = result.value else {
                print("error in json response")
                return
            }
            // success!
            self.schedule = schedule
            self.collectionView?.reloadData()
            loadingDialog.hide(animated: true)
        })
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(MondayCell.self, forCellWithReuseIdentifier: mondayCellId)
        collectionView?.register(TuesdayCell.self, forCellWithReuseIdentifier: tuesdayCellId)
        collectionView?.register(WednesdayCell.self, forCellWithReuseIdentifier: wednesdayCellId)
        collectionView?.register(ThursdayCell.self, forCellWithReuseIdentifier: thursdayCellId)
        collectionView?.register(FridayCell.self, forCellWithReuseIdentifier: fridayCellId)
        collectionView?.register(SaturdayCell.self, forCellWithReuseIdentifier: saturdayCellId)
        
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
        let identifier: String
        switch indexPath.item {
        case 0:
            identifier = mondayCellId
            break
        case 1:
            identifier = tuesdayCellId
            break
        case 2:
            identifier = wednesdayCellId
            break
        case 3:
            identifier = thursdayCellId
            break
        case 4:
            identifier = fridayCellId
            break
        case 5:
            identifier = saturdayCellId
            break
        default:
            identifier = mondayCellId
            break
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BaseDayCell
        cell.schedule = self.schedule
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }


}

