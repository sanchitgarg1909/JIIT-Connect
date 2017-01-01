
class ThursdayCell: BaseDayCell {
    override func getSchedule() {
        self.classArray = schedule?.thursday
        self.collectionView.reloadData()
    }
}
