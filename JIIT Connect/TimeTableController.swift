
import UIKit

class TimeTableController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let preferences = UserDefaults.standard
    let numberOfDays = 6
    let mondayCellId = Days.Monday.rawValue
    let tuesdayCellId = Days.Tuesday.rawValue
    let wednesdayCellId = Days.Wednesday.rawValue
    let thursdayCellId = Days.Thursday.rawValue
    let fridayCellId = Days.Friday.rawValue
    let saturdayCellId = Days.Saturday.rawValue
    let titles = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var schedule: Schedule? = nil
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        //        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Monday"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setUpMenuBar()
        setUpNavBarButtons()
        
    }
    
    func setup() {
        if ((preferences.object(forKey: "login status") != nil) && preferences.object(forKey: "user") != nil) {
            let loginStatus = preferences.bool(forKey: "login status")
            if(loginStatus) {
                let decoded  = preferences.object(forKey: "user") as! Data
                user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? User
                setupTimetable()
            }
            else {
                perform(#selector(handleLogout), with: nil, afterDelay: 0)
            }
        }
        else {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    func setupTimetable() {
        if let timetable = preferences.string(forKey: "timetable") {
            ApiService.sharedInstance.parseResponse(jsonString: timetable, completionHandler: { result in
                guard result.error == nil else {
                    // got an error in getting the data, need to handle it
                    let error = result.error as! BackendError
                    var errorMessage = ""
                    switch error {
                    case let .objectSerialization(reason):
                        errorMessage = reason
                        break
                    }
                    let alertDialog = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
                    alertDialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { UIAlertAction in
                        alertDialog.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alertDialog, animated: true, completion: nil)
                    return
                }
                guard let schedule = result.value else {
                    print("error in json response")
                    return
                }
                // success!
                self.schedule = schedule
                self.collectionView?.reloadData()
            })
        }
        else {
            fetchSchedule()
        }
    }
    
    func openLogin() {
        let controller = LoginController()
        controller.dismissController {
            self.setup()
        }
        present(controller, animated: true, completion: nil)
    }
    
    func fetchSchedule() {
        let loadingDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingDialog.animationType = .zoomOut
        loadingDialog.label.text = "Loading"
        let year = (user?.getYear())!
        let batch = (user?.getBatch())!
        ApiService.sharedInstance.fetchTimeTable(year: "year\(year).txt", batch: batch , completionHandler: { result in
            loadingDialog.hide(animated: true)
            guard result.error == nil else {
                // got an error in getting the data, need to handle it
                let error = result.error as! BackendError
                var errorMessage = ""
                switch error {
                case let .objectSerialization(reason):
                    errorMessage = reason
                    break
                }
                let alertDialog = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
                alertDialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { UIAlertAction in
                    alertDialog.dismiss(animated: true, completion: nil)
                }))
                self.present(alertDialog, animated: true, completion: nil)
                return
            }
            guard let schedule = result.value else {
                print("error in json response")
                return
            }
            // success!
            self.schedule = schedule
            self.collectionView?.reloadData()
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
    
    func setUpNavBarButtons(){
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        logoutButton.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItems = [logoutButton]
    }
    
    func handleLogout(){
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "login status")
        preferences.removeObject(forKey: "user")
        preferences.removeObject(forKey: "timetable")
        self.schedule = nil
        self.collectionView?.reloadData()
        openLogin()
    }
    
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

