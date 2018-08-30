
import Foundation

var grades:[String:Double] = [ "A":4.0, "A-":3.7,"B+":3.3,"B":3.0,"B-":2.7,"C+":2.3,"C":2.0,"C-":1.7,"D+":1.3,"D-":0.7,"F":0,"FN":0]


    var currentGPA :Double?
     var totalCreditHours:Int?

//var currentGPAStruct:currentAcademicProgress?
var gpaTotalVariable:Double?

struct courseDetails {
    var courseName:String
    var creditHours:Int
    var grade:String
    var gradePoints:Double?
    var isSubstitute:Bool
    var previousGrade:String?
}

protocol tableDataRefresh:class {
    func refresh()
}

protocol CourseListUpdatingInterface  {
    func save(coursedetails:courseDetails)
    func courseDetail(index:Int) -> courseDetails?
    func listCount() -> Int
    func editdata(for index:Int,with data:courseDetails )
    
    
    
}



protocol gpaCalculatorInterface {
    
    func gpaCalculated()->String
    
    
    func saveGPA(currentgPA:String,TotalCreditHours:Int)->()
    
    
    
}

protocol validationInterface {
    func currentGPAviewValidation(currentGPA:String,currentCreditHours:String)->Bool
        
    
}
class CourseGpaModel  : CourseListUpdatingInterface{
    private var courseList = [courseDetails]()
    weak var delegate: tableDataRefresh?
    
    func save(coursedetails:courseDetails) {
        courseList.append(coursedetails)
        delegate?.refresh()
        print(courseList.count)
        print(courseList)
    }
    
    func courseDetail(index:Int) -> courseDetails?{
        return courseList[index]
        
    }
    
    func listCount() -> Int {
        return courseList.count
        
    }
    
    func editdata(for index: Int,with data:courseDetails) {
        courseList[index] = data
        delegate?.refresh()
        
        
    }
    
    func gradePoints(creditHours:Int,Grade:String)->Double?{
        
        if let gradeValue = grades[Grade]{
            
             let convertedCreditHours = Double(creditHours)
                return convertedCreditHours * gradeValue
            
            
        }
        else{
        return nil
        
        }
    }
    
    func sumOfGradePoints()->(Double?){
        var sumOfPoints = 0.0
        for courseElement in courseList {
            if let point = courseElement.gradePoints {
                if courseElement.isSubstitute == true {
                    sumOfPoints = sumOfPoints - gradePoints(creditHours: courseElement.creditHours, Grade: courseElement.previousGrade!)!
                }
                sumOfPoints += point
            }
            
        }
        return sumOfPoints
    }
    
    func sumOfCreditHours()->Double? {
        var sumOfHours = 0
        for courseElement in courseList {
            if let _ = courseElement.gradePoints{
        sumOfHours = sumOfHours + courseElement.creditHours
            }}
            return Double(sumOfHours)
    }
  
    
}

extension CourseGpaModel : gpaCalculatorInterface {
    func saveGPA(currentgPA:String,TotalCreditHours:Int){
         currentGPA = Double(currentgPA)!
        totalCreditHours = Int(TotalCreditHours)
        
        
    }
    
    
    
    
    
   
    func gpaCalculated() -> String {
        if listCount() == 0{
            if let gpaValueExists = currentGPA {
                gpaTotalVariable = gpaValueExists
                return String(gpaTotalVariable!)
            } else {
                return "Add Course/Enter Current GPA"
            }
        }
        else {
            var totalGradePoints = 0.0
           
            
            if let gpaValueExists = currentGPA,   let creditHourExists = totalCreditHours {
                 totalGradePoints = gpaValueExists * Double(creditHourExists)

            }
            
            if totalGradePoints == 0.0 {
                
                if sumOfGradePoints() == 0.0 {
                    return " Provide a Grade in List / current GPA"
                }
                
             gpaTotalVariable = (sumOfGradePoints()! / sumOfCreditHours()!)
             return String(format:"%.3f",gpaTotalVariable!)
            } else {
                gpaTotalVariable = (totalGradePoints + sumOfGradePoints()!)/(Double(totalCreditHours!) + sumOfCreditHours()!)
                return String(format:"%.3f",gpaTotalVariable!)
            }
            
            
            
            
            
           
            
            
        }
       
    }
}

extension CourseGpaModel:validationInterface {
    
    func currentGPAviewValidation(currentGPA:String,currentCreditHours:String)->Bool
    {
       
        guard let GPAconverted = Double(currentGPA) else {
            return false
        }
        if GPAconverted >= 0 && GPAconverted <= 4 {
            if Int(currentCreditHours) == 0 && GPAconverted > 0 {
                return false
            }
            return true
        }else {
            return false
        }
    }
    }

