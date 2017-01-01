
class SaturdayCell: BaseDayCell {
    override func getSchedule() {
        self.classArray = schedule?.saturday
        self.collectionView.reloadData()
    }
}
