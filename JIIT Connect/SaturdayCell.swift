//
//  MondayCell.swift
//  JIIT Connect
//
//  Created by Sanchit Garg on 29/11/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

class SaturdayCell: BaseDayCell {
    override func getSchedule() {
        self.classArray = schedule?.saturday
        self.collectionView.reloadData()
    }
}
