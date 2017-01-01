
import Foundation

class Class {
    var course_id: String
    var time: String
    var venue: String
    var course_name: String
    var type: String
    
    required init?(course_id: String, time: String, venue: String, course_name: String, type: String) {
        self.course_id = course_id
        self.time = time
        self.venue = venue
        self.course_name = course_name
        self.type = type
    }
    
    convenience init?(json: [String: AnyObject]) {
        guard let course_id = json["course_id"] as? String,
            let time = json["time"] as? String,
            let venue = json["venue"] as? String,
            let course_name = json["course_name"] as? String,
            let type = json["type"] as? String else{
                print("problem in class")
                return nil
        }
        
        self.init(course_id: course_id,time: time,venue: venue,course_name: course_name,type: type)
    }

}
