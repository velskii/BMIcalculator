/**
 *
 * File Name:       CustomTableViewCell.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         1.0
 * Date Created:    December 17, 2021
 */

import UIKit
import Foundation

class CustomTableViewCell: UITableViewCell
{
    var weight:String = ""
    {
        didSet
        {
            if(weight != oldValue)
            {
                weightLabel.text = weight
            }
        }
    }
    
    var bmi: String = ""
    {
        didSet
        {
            if(bmi != oldValue)
            {
                bmiLabel.text = bmi
            }
        }
    }
    
    var date: String = ""
    {
        didSet
        {
            if(date != oldValue)
            {
                dateLabel.text = date
            }
        }
    }
    
    var weightLabel: UILabel!
    var bmiLabel: UILabel!
    var dateLabel: UILabel!
    
    var height: Int = 30
    var titleFontSize: CGFloat = 25
    var stateFontSize: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // weight
        let nameRect = CGRect(
            x: 20,
            y: 10,
            width: 200,
            height: self.height
        )
        weightLabel = UILabel(frame: nameRect)
        weightLabel.textAlignment = NSTextAlignment.left
        weightLabel.font = UIFont.boldSystemFont(ofSize: self.titleFontSize)
        
        // bmi
        let stateRect = CGRect(
            x: 30,
            y: 36,
            width: 200,
            height: self.height
        )
        bmiLabel = UILabel(frame: stateRect)
        bmiLabel.textAlignment = NSTextAlignment.left
        bmiLabel.font = UIFont.boldSystemFont(ofSize: self.stateFontSize)
        
        // date
        dateLabel = UILabel(frame: CGRect(
            x: 200,
            y: 26,
            width: 200,
            height: 30
        ))
        dateLabel.textAlignment = NSTextAlignment.left
        dateLabel.font = UIFont.boldSystemFont(ofSize: self.stateFontSize)
        
        contentView.addSubview(weightLabel)
        contentView.addSubview(bmiLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
