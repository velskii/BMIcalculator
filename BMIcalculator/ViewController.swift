/**
 *
 * File Name:       ViewController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         1.0
 * Date Created:    December 16, 2021
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var genderText: UITextField!
    
    @IBOutlet weak var weightText: UITextField!
    
    @IBOutlet weak var heightText: UITextField!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    
    
    
    @IBAction func calculateBtn(_ sender: UIButton)
    {
        let name = nameText.text!
        let age = ageText.text!
        let gender = genderText.text!
        let weight: Double = Double(weightText.text!) ?? 0
        let height: Double = Double(heightText.text!) ?? 0
        
        let BMI: Double = (weight * 703) / (height*height)
        
        scoreLabel.text = String(format: "%f", BMI)
        categoryLabel.text = calculateCategory(score: BMI)
        
        
        
        
//        let alert = UIAlertController(title: "Are you sure?", message: name, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            present(alert, animated: false)
    }
    
    
    
    @IBOutlet weak var nameMetric: UITextField!
    
    @IBOutlet weak var ageMetric: UITextField!
    
    @IBOutlet weak var genderMetric: UITextField!
    
    @IBOutlet weak var weightInKilograms: UITextField!
    
    @IBOutlet weak var heightInMeters: UITextField!
    
    @IBOutlet weak var BMI_metric: UILabel!
    
    @IBOutlet weak var category_metric: UILabel!
    
    @IBAction func calculateBtn_metric(_ sender: UIButton)
    {
        let name = nameMetric.text!
        let age = ageMetric.text!
        let gender = genderMetric.text!
        let weight: Double = Double(weightInKilograms.text!) ?? 0
        let height: Double = Double(heightInMeters.text!) ?? 0
        
        let BMI: Double = weight / (height*height)
        
        BMI_metric.text = String(format: "%f", BMI)
        category_metric.text = calculateCategory(score: BMI)
    }
    
    
    
    
    
    
    
    
    
    
    func calculateCategory(score: Double) -> String
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
    
    


}

