/**
 *
 * File Name:       TrackViewController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         1.0
 * Date Created:    December 17, 2021
 */

import UIKit

class TrackViewController: UITableViewController {

    var data = Db.init().selectData()
       
    let tableIdentifier = "BMITable"
    let cellSpacingHeight: CGFloat = 10
    let cellHeightForRow: CGFloat = 80
    
    override func viewDidLoad() {
        if (self.data.count < 1)
        {
            let alert = UIAlertController(title: "No data", message: "You will be routed to the Personal Information Screen", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
                self.navigationController?.popViewController(animated: false)
            }))
            present(alert, animated: false)
        }
        
        super.viewDidLoad()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtn))
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    // Set the height of row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightForRow
    }
    
    override func tableView(_ tableView: UITableView,
                       leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let uptAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.uptBtn(rowid: self.data[indexPath.row].id)
            self.data = Db.init().selectData()
            
            tableView.reloadRows(at: [indexPath], with: .none)
            self.tableView.reloadData()
            
            success(true)
        })
        uptAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [uptAction])
    }
    
    override func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title: "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            Db().deleteDate( rowid: self.data[indexPath.row].id )
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            
            if (Db.init().getCount() < 1)
            {
                let alert = UIAlertController(title: "No data", message: "You will be routed to the Personal Information Screen", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
                    self.navigationController?.popViewController(animated: false)
                }))
                self.present(alert, animated: false)
            }
            
            success(true)
        })
        modifyAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as! CustomTableViewCell
            
            let rowData = data[indexPath.row]
            
            cell.weight = "Weight: \(Int(rowData.weight))"
            cell.bmi = "BMI: \(String(format: "%.5f", rowData.bmi))"
            cell.date = "Date: \(rowData.date)"
            
            // add border and color
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            
            return cell
        }

    @objc func addBtn ()
    {
        let alert = UIAlertController(title: "New data", message: "", preferredStyle: .alert)
        alert.addTextField{field in
            field.placeholder = "weight"
        }
        alert.addTextField{field in
            field.placeholder = "height"
        }
        alert.addTextField{field in
            field.placeholder = "date"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {[weak alert] (_) in
       
            Db.init().insertData(
                bmiObj: BMI(
                    name: "Greg",
                    age: 30,
                    gender: "Male",
                    weight: Double((alert?.textFields![0].text)!)!,
                    height: Double((alert?.textFields![1].text)!)!,
                    date: (alert?.textFields![2].text!)!,
                    mode: "Metric"
                ))
            self.data = Db.init().selectData()
            self.tableView.reloadData()
        }))
        present(alert, animated: false)
    }
    
    func uptBtn (rowid: Int64)
    {
        let item = Db.init().getById(rowid: rowid)
        
        let alert = UIAlertController(title: "Update data", message: "Metric units", preferredStyle: .alert)
        alert.addTextField{field in
            field.placeholder = "weight\(item.weight)"
        }
        alert.addTextField{field in
            field.placeholder = "height\(item.height)"
        }
        alert.addTextField{field in
            field.placeholder = "date\(item.date)"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {[weak alert] (_) in
       
            Db.init().updateData(
                bmiObj: BMI(
                    id: rowid,
                    name: "Greg2",
                    age: 31,
                    gender: "Male",
                    weight: Double((alert?.textFields![0].text)!)!,
                    height: Double((alert?.textFields![1].text)!)!,
                    date: (alert?.textFields![2].text!)!,
                    mode: "Metric"
                   )
                )
            self.data = Db.init().selectData()
            self.tableView.reloadData()
        }))
        present(alert, animated: false)
    }
    
  
}
