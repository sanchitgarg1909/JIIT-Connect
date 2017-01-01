
class WednesdayCell: BaseDayCell {
    override func getSchedule() {
        self.classArray = schedule?.wednesday
        self.collectionView.reloadData()
    }
}
