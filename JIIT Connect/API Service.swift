
import Alamofire

class ApiService {
    
    static let sharedInstance = ApiService()
    
    let baseTimeTableUrl = "https://jiit-connect.firebaseapp.com/time_table"
    let baseWebkioskUrl = "https://webkiosk.jiit.ac.in/"
    
    func fetchTimeTable(year: String, batch: String, completionHandler: @escaping (Result<Schedule>) -> Void) {
        let url = "\(baseTimeTableUrl)/\(year)"
        Alamofire.request(url)
            .responseString { response in
                
                // check if responseJSON already has an error
                // e.g., no network connection
                guard response.result.error == nil else {
                    print(response.result.error!)
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Unable to connect to server")))
                    return
                }
                
                guard var jsonString = response.result.value else {
                    print("nil response")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Response is nil")))
                    return
                }
                
                guard jsonString.contains("#\(batch)"),
                jsonString.contains("@\(batch)") else {
                    print("wrong batch")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Batch does not exist")))
                    return
                }
                let startIndex = (jsonString.range(of: "#\(batch)")?.upperBound)!
                let endIndex = (jsonString.range(of: "@\(batch)")?.lowerBound)!
                jsonString = jsonString[startIndex..<endIndex]
                
                self.parseResponse(jsonString: jsonString, completionHandler: completionHandler)
                
            }
    }
    
    func parseResponse(jsonString: String, completionHandler: @escaping (Result<Schedule>) -> Void) {
        // make sure we got JSON and it's a dictionary
        guard let json = jsonString.convertToJSON() else {
            print("string is not JSON")
            completionHandler(.failure(BackendError.objectSerialization(reason: "Did not get JSON dictionary in response")))
            return
        }
        
        // create Todo from JSON, make sure it's not nil
        guard let schedule = Schedule(json: json) else {
            print("problem in JSON response")
            completionHandler(.failure(BackendError.objectSerialization(reason: "Could not create Schedule object from JSON")))
            return
        }

        let preferences = UserDefaults.standard
        preferences.set(jsonString, forKey: "timetable")
        preferences.synchronize()
        
        completionHandler(.success(schedule))
    }
    
    func loginOnWebkiosk(user: User, code: Int, completionHandler: @escaping (Result<Bool>) -> Void) {
        let url = baseWebkioskUrl + "CommonFiles/UserActionn.jsp"
        let params: Parameters = [
            "cookieexists": "false",
            "InstCode": user.getCollege(),
            "UserType": "S",
            "MemberCode": user.getEnrollNo(),
            "DATE1": user.getDob(),
            "Password": user.getPassword(),
            "BTNSubmit": "",
            "txtInst": "Institute",
            "txtuType": "Member Type",
            "txtCode": "Enrollment No",
            "DOB": "DOB",
            "txtPin": "Password/Pin",
            "LoginForm": "",
            "x": "x",
            ]
        Alamofire.request(url, method: .post, parameters: params)
            .responseString { response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Unable to connect to server")))
                    return
                }
                guard let html = response.result.value else {
                    print("nil response")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Response is nil")))
                    return
                }
                if(html.lowercased().contains("invalid")||html.lowercased().contains("please")||html.lowercased().contains("mandatory")) {
                    print("invalid")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Invalid credentials")))
                    return
                }
                else if(html.lowercased().contains("locked")) {
                    print("locked")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Your account is locked")))
                    return
                }
                else {
                    if(code == 0){
                        self.checkLogin(user: user,completionHandler: completionHandler)
                    }
                }
        }
    }
    
    func checkLogin(user: User, completionHandler: @escaping (Result<Bool>) -> Void) {
        let url = baseWebkioskUrl + "CommonFiles/TopTitle.jsp"
        let params: Parameters = [
            "cookieexists": "false",
            "InstCode": user.getCollege(),
            "UserType": "S",
            "MemberCode": user.getEnrollNo(),
            "DATE1": user.getDob(),
            "Password": user.getPassword(),
            "BTNSubmit": "",
            "txtInst": "Institute",
            "txtuType": "Member Type",
            "txtCode": "Enrollment No",
            "DOB": "DOB",
            "txtPin": "Password/Pin",
            "LoginForm": "",
            "x": "x",
            ]
        Alamofire.request(url, method: .post, parameters: params)
            .responseString { response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    completionHandler(.failure(response.result.error!))
                    return
                }
                guard let html = response.result.value else {
                    print("nil response")
                    completionHandler(.failure(BackendError.objectSerialization(reason: "Response is nil")))
                    return
                }
                if(html.lowercased().contains("good")) {
                    print("success")
                    completionHandler(.success(true))
                    return
                }
                else {
                    print("server error")
                    completionHandler(.success(false))
                    return
                }
        }
    }
    
}
