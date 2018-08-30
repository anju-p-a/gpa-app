

import UIKit

class CourseListCellDetails: UITableViewCell {


    @IBOutlet weak var gradePointsLabel: UILabel!
    @IBOutlet weak var courseName: UILabel!
    func listViewDetails(coursedetails:courseDetails) {
       courseName.text = "\(coursedetails.courseName)"
        if coursedetails.gradePoints == nil {
            gradePointsLabel.text = "No Grade Entered"
        }else {
        gradePointsLabel.text = "Grade Points: \(coursedetails.gradePoints!)"
        }
//        courseGrade.text = "A"
//        courseCredits.text = "2.0"
//        courseGradePoints.text = "6.0"
        
    }

   
}
