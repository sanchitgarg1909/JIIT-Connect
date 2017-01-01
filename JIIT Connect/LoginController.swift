
import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    typealias typeCompletionHandler = () -> ()
    var completion: typeCompletionHandler = { }
    var activeField: UITextField?
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.frame = self.view.bounds
        sv.contentSize = self.view.bounds.size
        sv.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return sv
    }()
    
    let collegeChoice: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["JIIT","J128"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 80, green: 101, blue: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let enrollNoField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enrollment No"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorView1 = SeparatorView()
    
    let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let separatorView2 = SeparatorView()
    
    let dobField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "DOB (dd-mm-yyyy)"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorView3 = SeparatorView()
    
    let yearField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Year Eg. 3"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorView4 = SeparatorView()
    
    let batchField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Batch Eg. 3"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enrollNoField.delegate = self
        passwordField.delegate = self
        dobField.delegate = self
        yearField.delegate = self
        batchField.delegate = self
        
        view.backgroundColor = UIColor.rgb(red: 61, green: 91, blue: 151)
        
        view.addSubview(scrollView)

        scrollView.addSubview(inputsContainerView)
        scrollView.addSubview(collegeChoice)
        scrollView.addSubview(loginButton)
        
        setupInputsContainerView()
        setupCollegeChoice()
        setupLoginButton()
    }
    
    func handleLogin() {
        
        view.endEditing(true)
    
        guard let enrollNo = enrollNoField.text,
        !enrollNo.isEmpty,
        let password = passwordField.text,
        !password.isEmpty,
        let dob = dobField.text,
        !dob.isEmpty,
        let year = yearField.text,
        !year.isEmpty,
        let batch = batchField.text,
        !batch.isEmpty,
        let college = collegeChoice.titleForSegment(at: collegeChoice.selectedSegmentIndex) else {
            let alertDialog = UIAlertController(title: "Information missing", message: "Please fill all the details", preferredStyle: UIAlertControllerStyle.alert)
            alertDialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { UIAlertAction in
                alertDialog.dismiss(animated: true, completion: nil)
            }))
            present(alertDialog, animated: true, completion: nil)
            return
        }
        guard let user = User(enrollNo: enrollNo, password: password ,dob: dob, year: year, batch: batch, college: college) else {
            print("Unable to create user")
            return
        }
        
        let loadingDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingDialog.animationType = .zoomOut
        loadingDialog.label.text = "Logging in"
        
        ApiService.sharedInstance.loginOnWebkiosk(user: user, code: 0, completionHandler: { result in
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
            guard let success = result.value else {
                print("error in value")
                return
            }
            if(success) {
                let preferences = UserDefaults.standard
                preferences.set(true, forKey: "login status")
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
                preferences.set(encodedData, forKey: "user")
                preferences.synchronize()
                self.dismiss(animated: true, completion: {
                    self.completion()
                })
            }
            else {
                print("server error")
                let alertDialog = UIAlertController(title: "Error", message: "Please try again later", preferredStyle: UIAlertControllerStyle.alert)
                alertDialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { UIAlertAction in
                    alertDialog.dismiss(animated: true, completion: nil)
                }))
                self.present(alertDialog, animated: true, completion: nil)
            }
        })
    }
    
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        inputsContainerView.addSubview(enrollNoField)
        inputsContainerView.addSubview(separatorView1)
        inputsContainerView.addSubview(passwordField)
        inputsContainerView.addSubview(separatorView2)
        inputsContainerView.addSubview(dobField)
        inputsContainerView.addSubview(separatorView3)
        inputsContainerView.addSubview(yearField)
        inputsContainerView.addSubview(separatorView4)
        inputsContainerView.addSubview(batchField)
        
        enrollNoField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        enrollNoField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        enrollNoField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        enrollNoField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        separatorView1.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        separatorView1.topAnchor.constraint(equalTo: enrollNoField.bottomAnchor).isActive = true
        separatorView1.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        passwordField.topAnchor.constraint(equalTo: enrollNoField.bottomAnchor).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        passwordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        separatorView2.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        separatorView2.topAnchor.constraint(equalTo: passwordField.bottomAnchor).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        dobField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        dobField.topAnchor.constraint(equalTo: passwordField.bottomAnchor).isActive = true
        dobField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        dobField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        separatorView3.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        separatorView3.topAnchor.constraint(equalTo: dobField.bottomAnchor).isActive = true
        separatorView3.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        yearField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        yearField.topAnchor.constraint(equalTo: dobField.bottomAnchor).isActive = true
        yearField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        yearField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        separatorView4.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor).isActive = true
        separatorView4.topAnchor.constraint(equalTo: yearField.bottomAnchor).isActive = true
        separatorView4.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView4.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        batchField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        batchField.topAnchor.constraint(equalTo: yearField.bottomAnchor).isActive = true
        batchField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        batchField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
    }
    
    func setupCollegeChoice() {
        collegeChoice.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        collegeChoice.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -16).isActive = true
        collegeChoice.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        collegeChoice.heightAnchor.constraint(equalToConstant: 50)
    }
    
    func setupLoginButton() {
        loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func dismissController(completionHandler: @escaping typeCompletionHandler) {
        self.completion = completionHandler
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            var visibleFrame: CGRect = self.view.frame
            visibleFrame.size.height -= keyboardSize.height
            if !(visibleFrame.contains(activeField!.frame.origin)) {
                let scrollPoint: CGPoint = CGPoint(x: 0, y: activeField!.frame.origin.y - keyboardSize.height)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
}
