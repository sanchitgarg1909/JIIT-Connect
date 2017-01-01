
class TuesdayCell: BaseDayCell {
    override func getSchedule() {
        self.classArray = schedule?.tuesday
        self.collectionView.reloadData()
    }
}
