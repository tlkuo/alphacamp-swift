//
//  ACClassManager.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/5.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ACLesson {
    let name: String
    let url: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.url = json["url"].stringValue
    }
}

struct ACCourse {
    let name: String

    var lessons: [ACLesson]
    
    init(json: JSON) {
        self.name = json["section"]["name"].stringValue
        self.lessons = []
        
        for lesson in json["lessons"].arrayValue {
            lessons.append(ACLesson(json: lesson))
        }
    }
}

struct ACClass {
    let id: String
    let name: String

    var courses: [ACCourse]?
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.courses = nil
    }
}

protocol ACClassDelegate: class {
    func getClassesSuccess(classes: [ACClass])
    func getClassesFail()
    func getCoursesSuccess(id: String, courses: [ACCourse])
    func getCoursesFail()
}

class ACClassManager {

    weak var delegate: ACClassDelegate?

    init(delegate: ACClassDelegate) {
        self.delegate = delegate
    }

    func getClasses(token: String) {

        guard let config = ACConfig.sharedConfig else {
            print("ACConfig: error")
            return
        }

        Alamofire
        .request(.GET, config.courseUrl, parameters: ["api_key": config.apiKey, "auth_token": token])
        .responseJSON { response in

            if let value = response.result.value {
                
                var classes: [ACClass] = []

                for json in JSON(value)["courses"].arrayValue {
                    classes.append(ACClass(json: json))
                }

                self.delegate?.getClassesSuccess(classes)

            } else {

                self.delegate?.getClassesFail()
            }
        }
    }

    func getCourses(token: String, id: String) {

        guard let config = ACConfig.sharedConfig else {
            print("ACConfig: error")
            return
        }

        Alamofire
        .request(.GET, config.courseUrl.URLByAppendingPathComponent(id), parameters: ["api_key": config.apiKey, "auth_token": token])
        .responseJSON { response in
            
            if let value = response.result.value {

                var courses: [ACCourse] = []
                
                for course in JSON(value)["syllabus"].arrayValue {
                    courses.append(ACCourse(json: course))
                }

                self.delegate?.getCoursesSuccess(id, courses: courses)

            } else {

                self.delegate?.getCoursesFail()
            }
        }
    }
}
