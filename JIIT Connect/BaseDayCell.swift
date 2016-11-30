//
//  FeedCell.swift
//  Youtube
//
//  Created by Sanchit Garg on 25/11/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

import UIKit

class BaseDayCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var classArray: [Class]?
    var schedule: Schedule? {
        didSet{
            getSchedule()
        }
    }
    
    func getSchedule() {
        
    }

    let cellId = "cellId"

//    func fetchVideos() {
//        ApiService.sharedInstance.fetchTimeTable(urlString: "timetable.json", completionHandler: { result in
//            guard result.error == nil else {
//                // got an error in getting the data, need to handle it
//                print("error calling POST on /todos/")
//                print(result.error!)
//                return
//            }
//            guard let schedule = result.value else {
//                print("error calling POST on /todos/: result is nil")
//                return
//            }
//            // success!
//            self.classArray = schedule.monday
//            self.collectionView.reloadData()
//        })
//    }
    
    override func setupViews() {
        super.setupViews()
        
//        fetchVideos()
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ClassCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath as IndexPath) as! ClassCell
        
        cell.classObject = classArray?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: frame.width, height: height + 16 + 88)
        return CGSize(width: frame.width, height: 74)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
