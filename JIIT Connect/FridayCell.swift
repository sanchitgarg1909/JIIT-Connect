
class FridayCell: BaseDayCell {
    override func getSchedule() {
        self.classArray = schedule?.friday
        self.collectionView.reloadData()
    }
}
