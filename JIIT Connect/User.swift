
import Foundation

class User: NSObject, NSCoding {
    private var enrollNo: String
    private var password: String
    private var dob: String
    private var year: String
    private var batch: String
    private var college: String
    
    required init?(enrollNo: String, password: String, dob: String, year: String, batch: String, college: String) {
        self.enrollNo = enrollNo
        self.password = password
        self.dob = dob
        self.year = year
        self.batch = batch
        self.college = college
    }
    
    required init(coder aDecoder: NSCoder) {
        enrollNo = aDecoder.decodeObject(forKey: "enrollNo") as! String
        password = aDecoder.decodeObject(forKey: "password") as! String
        dob = aDecoder.decodeObject(forKey: "dob") as! String
        year = aDecoder.decodeObject(forKey: "year") as! String
        batch = aDecoder.decodeObject(forKey: "batch") as! String
        college = aDecoder.decodeObject(forKey: "college") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(enrollNo, forKey: "enrollNo")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(year, forKey: "year")
        aCoder.encode(batch, forKey: "batch")
        aCoder.encode(college, forKey: "college")
    }
    
    func getEnrollNo() -> String {
        return enrollNo
    }
    
    func getPassword() -> String {
        return password
    }
    
    func getDob() -> String {
        return dob
    }
    
    func getYear() -> String {
        return year
    }
    
    func getBatch() -> String {
        return batch
    }
    
    func getCollege() -> String {
        return college
    }
}
