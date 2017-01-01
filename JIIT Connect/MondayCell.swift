
class MondayCell: BaseDayCell {
    override func getSchedule() {
        self.classArray = schedule?.monday
        self.collectionView.reloadData()
    }
}
