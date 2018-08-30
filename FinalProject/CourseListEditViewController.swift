//
//  CourseListEditViewController.swift
//  FinalProject
//
//  Created by Srinivas Chakravarthi Thandu on 7/29/17.
//  Copyright © 2017 Anju. All rights reserved.
//

import UIKit

protocol editCourseInfo:class {
    func returnData()->courseDetails
    func saveEditedData(coursedetails:courseDetails)
    func gradePoint(creditHours: Int, Grade: String)->Double?
    
}
var model:CourseGpaModel?


class CourseListEditViewController: UIViewController ,UITextFieldDelegate{
    
    weak var delegate: editCourseInfo?
    
    @IBOutlet weak var gradePicker: UIPickerView!
   
    @IBOutlet weak var courseCreditField: UITextField!
    @IBOutlet weak var creditPointStepper: UIStepper!
    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var courseToBeEdited:courseDetails?
    let  gradeArray = [ "Select","A","A-","B+","B-"]
        
   
    @IBOutlet weak var yesSubstituteButton: UIButton!
    @IBOutlet weak var noSubstituteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNameField.delegate = self
        gradePicker.delegate = self
        gradePicker.dataSource = self
        // initialising the default value of the fields in the screen
        courseNameField.text = courseToBeEdited?.courseName ?? "nil"
        let creditValue = (courseToBeEdited?.creditHours) ?? 0
        
        
        let pickerGradeEdited = (courseToBeEdited?.grade) ?? "a"
        let indexValue = (gradeArray.index(of: pickerGradeEdited)) ?? 0
         gradePicker.selectRow(indexValue, inComponent: 0, animated: true)
        
        creditPointStepper.minimumValue = 1
        creditPointStepper.maximumValue = 6
        creditPointStepper.value = Double(creditValue)
        courseCreditField.text = String(creditPointStepper.value)
        
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackground(_:)))
        view.addGestureRecognizer(tapGesture)
        saveButton.isEnabled = false
        
        
        
    }
    
   
    
    
    @IBAction func creditStepperAction(_ sender: UIStepper) {
        courseCreditField.text = String(creditPointStepper.value)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let _ = courseNameField.text,let creditText = courseCreditField.text,let creditConvert = Double(creditText)
            else {
                return
        }
         let pickerData = gradeArray[gradePicker.selectedRow(inComponent: 0)]
        delegate?.saveEditedData(coursedetails:courseDetails(courseName:  courseNameField.text!, creditHours: Int(creditConvert), grade: pickerData, gradePoints: delegate?.gradePoint(creditHours: Int(creditConvert), Grade: pickerData), isSubstitute: (courseToBeEdited?.isSubstitute)!,previousGrade:courseToBeEdited?.previousGrade))
        
       
        let _ = navigationController?.popViewController(animated: true)
        
    }
    
    func tappedBackground(_ sender: UITapGestureRecognizer)-> Bool {
        courseNameField.resignFirstResponder()
        courseCreditField.resignFirstResponder()
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        courseNameField.resignFirstResponder()
        courseCreditField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
            guard let textValue = textField.text
                else {
                    saveButton.isEnabled = false
                    return
            }
            
            if textValue != " " {
                saveButton.isEnabled = true
            }else {
                saveButton.isEnabled = false
            }
        }
    }
    
    


extension CourseListEditViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradeArray[row]
}
}




