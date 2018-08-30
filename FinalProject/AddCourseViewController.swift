//
//  AddCourseViewController.swift
//  FinalProject
//
//  Created by Srinivas Chakravarthi Thandu on 7/29/17.
//  Copyright © 2017 Anju. All rights reserved.
//

import UIKit
protocol addData :class{
    func   savedata(coursedetails:courseDetails)
    func gradePoint(creditHours:Int,Grade:String)->Double?
    
}
var  gradeArray = [" ","Select","A","A-","B+","B","B-","C+","C","C-","D+","D-","F","FN", " "]
let previousGradeArray = ["A","A-","B+","B","B-","C+","C","C-","D+","D-","F","FN"]


class AddCourseViewController: UIViewController {
    var gradePoint:Double?
    var isSubstitute:Bool?
    weak var delegate: addData?

    
    @IBOutlet weak var previousGradePicker: UIPickerView!
    @IBOutlet weak var NoSubstituteButton: UIButton!
   
    @IBOutlet weak var creditHourStepper: UIStepper!
  
    @IBOutlet weak var creditHourField: UITextField!
    @IBOutlet weak var gradePicker: UIPickerView!
    
    @IBOutlet weak var yesSubstituteButton: UIButton!
    @IBOutlet weak var addCourseButton: UIButton!
    @IBOutlet weak var courseNameField: UITextField!

    @IBOutlet weak var previousGradeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradePicker.delegate = self
        gradePicker.dataSource = self
        previousGradePicker.delegate = self
        previousGradePicker.dataSource = self
        previousGradePicker.isHidden = true
        creditHourStepper.minimumValue = 1
        creditHourStepper.maximumValue = 6
        creditHourStepper.value = 3
        creditHourField.text = String(creditHourStepper.value)
        isSubstitute = false
        NoSubstituteButton.backgroundColor = UIColor.green
        yesSubstituteButton.backgroundColor = UIColor.lightGray
        previousGradeLabel.isHidden = true
        
        
}
  

    
    
    @IBAction func yesSubstituteAction(_ sender: UIButton) {
        yesSubstituteButton.backgroundColor = UIColor.green
        NoSubstituteButton.backgroundColor = UIColor.lightGray
        previousGradePicker.isHidden = false
        previousGradeLabel.isHidden = false
        isSubstitute = true
        
        
        
    }
    
    @IBAction func noSubstituteAction(_ sender: UIButton) {
        NoSubstituteButton.backgroundColor = UIColor.green
        yesSubstituteButton.backgroundColor = UIColor.lightGray
        previousGradePicker.isHidden = true
        previousGradeLabel.isHidden = true
        isSubstitute = false
    }
    

    
    @IBAction func creditStepperAction(_ sender: UIStepper) {
        creditHourField.text = String(creditHourStepper.value)
    }
    @IBAction func addCourseAction(_ sender: UIButton) {
        guard  let _ = courseNameField.text,(creditHourField.text != nil)
            else {
                return
        }
        
        var pickerData = gradeArray[gradePicker.selectedRow(inComponent: 0)]
        let previousgrade = previousGradeArray[previousGradePicker.selectedRow(inComponent: 0)]
        if pickerData == " " { pickerData = "Select" }
        if let courseText = courseNameField.text ,let creditText = creditHourField.text {
            let credittoInt = Int(Double(creditText)!)
            print(credittoInt)
            delegate?.savedata(coursedetails: courseDetails(courseName: courseText, creditHours: credittoInt, grade: pickerData, gradePoints: delegate?.gradePoint(creditHours: credittoInt, Grade: pickerData), isSubstitute: isSubstitute!,previousGrade: previousgrade ))}
        
        let _ = navigationController?.popViewController(animated: true)
        

       

    }}


  extension AddCourseViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == previousGradePicker {
            return previousGradeArray.count
        }
        return gradeArray.count
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == previousGradePicker {
            return previousGradeArray[row]
        }
        return gradeArray[row]
    }
//    //action on each picker view item on select
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//       
//       }
    
    

    
}
