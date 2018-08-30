//
//  ViewController.swift
//  FinalProject
//
//  Created by Srinivas Chakravarthi Thandu on 7/29/17.
//  Copyright © 2017 Anju. All rights reserved.
//

import UIKit



class CourseListViewController: UIViewController {
    @IBOutlet weak var CourseTableView: UITableView!
    var model:CourseGpaModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        CourseTableView.delegate = self
        CourseTableView.dataSource = self
        CourseTableView.reloadData()
        model?.delegate = self
        
        
    }
    

    var indexRow:Int?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addViewController = segue.destination as? AddCourseViewController {
            addViewController.delegate = self
            
        }else if let editViewController = segue.destination as? CourseListEditViewController {
            editViewController.delegate = self
            if let indeX = CourseTableView.indexPathForSelectedRow?.row  {
            editViewController.courseToBeEdited =  model?.courseDetail(index: indeX )
            }
    }

    
    }}

extension CourseListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (model?.listCount()) ?? 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cellValue = tableView.dequeueReusableCell(withIdentifier: "CourseListCell", for: indexPath) as? CourseListCellDetails,
            let cellDetail = model?.courseDetail(index: indexPath.row)
            else {
                return UITableViewCell()}
        
        cellValue.listViewDetails(coursedetails: cellDetail)
        return cellValue
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    
    }
    
    
    
}

extension CourseListViewController:tableDataRefresh {
    func refresh() {
        CourseTableView.reloadData()
    }
}
extension CourseListViewController:tableviewDelegate {
    var tableview:UITableView {
        return CourseTableView
    }
}

extension CourseListViewController:addData,editCourseInfo {
    func savedata(coursedetails: courseDetails) {
        model?.save(coursedetails: coursedetails)
            }
    func gradePoint(creditHours:Int,Grade:String)->Double? {
        return model?.gradePoints(creditHours: creditHours, Grade: Grade)
        
    }
    func returnData() -> courseDetails {
              return (model?.courseDetail(index: (CourseTableView.indexPathForSelectedRow?.row)!))!
       // return courseDetails()
    }
    
    func saveEditedData(coursedetails: courseDetails) {
        model?.editdata(for: (CourseTableView.indexPathForSelectedRow?.row)!, with: coursedetails)
        
    }
}
//pass this part by using segue in tableview
//extension CourseListViewController:editCourseInfo {
//    func returnData() -> courseDetails {
////        return model?.courseDetail(index: (CourseTableView.indexPathForSelectedRow?.row)!) ?? courseDetails(courseName: "nill", creditHours: 0,grade:"A")
//        return courseDetails()
//    }
//    
//    func saveEditedData(coursedetails: courseDetails) {
//        model?.editdata(for: (CourseTableView.indexPathForSelectedRow?.row)!, with: coursedetails)
//    
//    }

   

//}
