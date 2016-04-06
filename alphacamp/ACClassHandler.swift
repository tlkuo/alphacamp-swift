//
//  ACClassHandler.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/5.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Alamofire

struct ACLesson {
    let name: String
    let url: String
}

struct ACCourse {
    let name: String

    var lessons: [ACLesson]?
}

struct ACClass {
    let id: String
    let name: String

    var courses: [ACCourse]?
}

protocol ACClassDelegate: class {
    func getClassesSuccess(classes: [ACClass])
    func getClassesFail()
    func getCoursesSuccess(id: String, courses: [ACCourse])
    func getCoursesFail()
}

class ACClassHandler {

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

            let jsonResponse = response.result.value

            if let acClasses = jsonResponse?["courses"] as? NSArray {

                var classes: [ACClass] = []

                for acClass in acClasses {
                    classes.append(ACClass(
                        id: acClass.valueForKey("id") as? String ?? "",
                        name: acClass.valueForKey("name") as? String ?? "",
                        courses: nil
                    ))
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

            let jsonResponse = response.result.value

            if let acCourses = jsonResponse?["syllabus"] as? NSArray {

                var courses: [ACCourse] = []

                for acCourse in acCourses {

                    var course = ACCourse(
                        name: acCourse.valueForKey("section")?.valueForKey("name") as? String ?? "",
                        lessons: []
                    )

                    if let acLessons = acCourse.valueForKey("lessons") as? NSArray {

                        for acLesson in acLessons {
                            course.lessons?.append(ACLesson(
                                name: acLesson.valueForKey("name") as? String ?? "",
                                url: acLesson.valueForKey("url") as? String ?? ""
                            ))
                        }
                    }

                    courses.append(course)
                }

                self.delegate?.getCoursesSuccess(id, courses: courses)

            } else {

                self.delegate?.getCoursesFail()
            }
        }
    }
}
