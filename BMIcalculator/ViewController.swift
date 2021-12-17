/**
 *
 * File Name:       ViewController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         1.0
 * Date Created:    December 16, 2021
 */

import UIKit

/**
 The ui is designed with tab bar, so the user can toggle from imprial units to metric units.
 */
class ViewController: UIViewController {

    var data = Db.init().getLatestRow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (data.mode == "Imperial")
        {
            nameText?.text = data.name
            ageText?.text = String(data.age)
            genderText?.text = data.gender
            weightText?.text = String(data.weight)
            heightText?.text = String(data.height)
            scoreLabel?.text = String(data.bmi)
            categoryLabel?.text = showCategory(score: data.bmi)
            
        } else {
            nameMetric.text = data.name
            ageMetric.text = String(data.age)
            genderMetric.text = data.gender
            weightInKilograms.text = String(data.weight)
            heightInMeters.text = String(data.height)
            BMI_metric.text = String(data.bmi)
            category_metric.text = showCategory(score: data.bmi)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var genderText: UITextField!
    
    @IBOutlet weak var weightText: UITextField!
    
    @IBOutlet weak var heightText: UITextField!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    // Imperial BMI calculate
    @IBAction func calculateBtn(_ sender: UIButton)
    {
        let nameInput = nameText.text!
        let age = ageText.text!
        let gender = genderText.text!
        let weight: Double = Double(weightText.text!) ?? 0
        let height: Double = Double(heightText.text!) ?? 0
        
//        let BMIvalue: Double = (weight * 703) / (height*height)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let bmiObj = BMI(
            name: nameInput,
            age: Int(age)!,
            gender: gender,
            weight: Double(weight),
            height: Double(height),
            date: dateFormatter.string(from: Date()),
            mode: "Imperial"
        )
        Db.init().insertData(bmiObj: bmiObj)
        
        scoreLabel.text = String(format: "%f", bmiObj.bmi)
        categoryLabel.text = showCategory(score: bmiObj.bmi)
    }
    
    
    @IBOutlet weak var nameMetric: UITextField!
    
    @IBOutlet weak var ageMetric: UITextField!
    
    @IBOutlet weak var genderMetric: UITextField!
    
    @IBOutlet weak var weightInKilograms: UITextField!
    
    @IBOutlet weak var heightInMeters: UITextField!
    
    @IBOutlet weak var BMI_metric: UILabel!
    
    @IBOutlet weak var category_metric: UILabel!
    
    // Metric BMI calculate
    @IBAction func calculateBtn_metric(_ sender: UIButton)
    {
        let nameInput = nameMetric.text!
        let age = ageMetric.text!
        let gender = genderMetric.text!
        let weight: Double = Double(weightInKilograms.text!) ?? 0
        let height: Double = Double(heightInMeters.text!) ?? 0
        
//        let BMI: Double = weight / (height*height)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let bmiObj = BMI(
            name: nameInput,
            age: Int(age)!,
            gender: gender,
            weight: Double(weight),
            height: Double(height),
            date: dateFormatter.string(from: Date()),
            mode: "Metric"
        )
        Db.init().insertData(bmiObj: bmiObj)
        
        BMI_metric.text = String(format: "%f", bmiObj.bmi)
        category_metric.text = showCategory(score: bmiObj.bmi)
    }
    
    
    func showCategory(score: Double) -> String
    {
        var category: String = ""
        
        switch score
        {
        case 0..<16:
            category = "Severe Thinness"
        case 16..<17:
            category = "Moderate Thinness"
        case 17..<18.5:
                category = "Mild Thinness"
        case 18.5..<25:
            category = "Normal"
        case 25..<30:
            category = "Overweight"
        case 30..<35:
            category = "Obese Class I"
        case 35..<40:
            category = "Obese Class II"
        case 40...:
            category = "Obese Class III"
        default:
            category = "Normal"
        }
        return category
    }
    
    
    @IBAction func trackingBtn(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Track") as! TrackViewController
        
        navigationController?.pushViewController(vc, animated: false)
    }
    

}

