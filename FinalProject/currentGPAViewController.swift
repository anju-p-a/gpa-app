
import UIKit
protocol tableviewDelegate:class {
    var tableview:UITableView { get }
    
    
}
weak var delegate:tableviewDelegate?
var CoursegpaModel = CourseGpaModel()

class currentGPAViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var currentGpaField: UITextField!

    @IBOutlet weak var saveDetails: UIButton!
    @IBOutlet weak var currentCreditHoursField: UITextField!
    
    @IBOutlet weak var editDetailsButton: UIButton!
    @IBOutlet weak var gpaCalculatedLabel: UILabel!
    @IBOutlet weak var gpaCalculateButton: UIButton!
   
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGpaField.delegate = self
        currentCreditHoursField.delegate = self
        saveDetails.isEnabled = false
        editDetailsButton.isEnabled = false
        //if let _ = CoursegpaModel.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackground(_:)))
        view.addGestureRecognizer(tapGesture)
          }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   if let listViewController = segue.destination as? CourseListViewController {
       listViewController.model = CoursegpaModel
    
    
       }}
    
    func tappedBackground(_ sender: UITapGestureRecognizer)-> Bool {
        
        currentGpaField.resignFirstResponder()
        currentCreditHoursField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
      
        
        guard   let currentGPA =  currentGpaField.text else {
                validationAction(textField)           // check for nil and empty strings
                return }
        guard let currentCreditHours = currentCreditHoursField.text else {
            validationAction(textField)
            return }
        print (currentGPA)
        print(currentCreditHours)

        if currentGPA !=  "" && currentCreditHours != "" {
              if CoursegpaModel.currentGPAviewValidation(currentGPA: currentGPA, currentCreditHours: currentCreditHours){
                    saveDetails.isEnabled = true
////                    calorieserrorLabel.text = ""
                }
               else {
                   validationAction(textField)
            }}
        else {
            validationAction(textField)
        }
    }
    
    func validationAction(_ textField:UITextField){
      saveDetails.isEnabled = false
       
        
//        calorieserrorLabel.text = "Please enter value > 1.0"
      // textField.endEditing(false)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
      currentCreditHoursField.resignFirstResponder()
        
        currentGpaField.resignFirstResponder()
        return true
    }
   
   
    @IBAction func gpaCalculateAction(_ sender: UIButton) {
        gpaCalculatedLabel.text = CoursegpaModel.gpaCalculated()
        
    }
  
   
    @IBAction func skipAction(_ sender: UIButton) {
        
    }
    
    @IBAction func editActionButton(_ sender: UIButton) {
        currentGpaField.becomeFirstResponder()
    }
    @IBAction func saveAction(_ sender: UIButton) {
        
        CoursegpaModel.saveGPA(currentgPA: currentGpaField.text!, TotalCreditHours: Int(currentCreditHoursField.text!)!)
        editDetailsButton.isEnabled = true
        
    }
    
    

}

//extension currentGPAViewController:tableDataRefresh {
//    func refresh() {
//        delegate?.tableview.reloadData()
//    }
//}


