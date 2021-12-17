/**
 * Final project
 * File Name:       Db.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         1.0
 * Date Created:    December 17  2021
 */
import Foundation
import SQLite


class Db
{
    
    let path = try! FileManager.default
        .url(for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            )
        .appendingPathComponent("bmi_calculator.sqlite").path
    
    let tableResource = Table("mapd714_bmi_calculator")
    
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let weight = Expression<Double?>("weight")
    let height = Expression<Double?>("height")
    let bmi = Expression<Double?>("bmi")
    let date = Expression<String?>("date")
    
    init(){
        do {
            let db = try Connection(path)
     
            try db.run(tableResource.create(ifNotExists: true)  {
                t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(weight)
                t.column(height)
                t.column(bmi)
                t.column(date)
            })
        } catch {
            print(error)
        }
    }
    
    func insertData(bmiObj: BMI){
        do {
            let db = try Connection(path)
            
            let insert = tableResource.insert(
                name <- bmiObj.name,
                weight <- bmiObj.weight,
                height <- bmiObj.height,
                bmi <- bmiObj.bmi,
                date <- bmiObj.date
            )
            let rowid = try db.run(insert)
            print(rowid)
        } catch {
            print(error)
        }
    }
    
    func getById(rowid: Int64) -> BMI{
        
        do {
            let db = try Connection(path)
            for item in try db.prepare(tableResource) {
                
                if (item[id] == rowid) {
                    
                   return BMI(
                        name: item[name]!,
                        weight: item[weight]!,
                        height: item[height]!,
                        date: item[date]!
                    )
                }
            }
        } catch {
            print(error)
        }
        return BMI()
    }
    func getCount() -> Int{
        do {
            let db = try Connection(path)
            return try db.scalar(tableResource.count) as Int
        }catch {
            print(error)
        }
        return 0
    }
    
    func getLatestRow() -> BMI{
        do {
           
            let db = try Connection(path)
            let cc = try db.scalar(tableResource.count) as Int
            if ( cc < 1)
            {
                return BMI()
            }
            let rowid = try db.scalar("select *from mapd714_bmi_calculator ORDER BY id DESC LIMIT 1;") as! Int64
            for item in try db.prepare(tableResource) {
                
                if (item[id] == rowid) {
                    
                   return BMI(
                        name: item[name]!,
                        weight: item[weight]!,
                        height: item[height]!,
                        date: item[date]!
                    )
                }
            }
            
        }catch {
            print(error)
        }
        return BMI()
    }
    
    func selectData() -> [BMI]{
        do {
            let db = try Connection(path)
            
            var newItems: [BMI] = []
            
            for item in try db.prepare(tableResource) {
            
                newItems.append(
                    BMI(
                        id: item[id],
                        name: "Greg",
                        weight: item[weight]!,
                        height: item[height]!,
                        date: item[date]!
                    )
                )
                
            }
            
            return newItems
        } catch {
            print(error)
        }
        
        return []
    }
    
    func updateData(bmiObj: BMI)
    {
        do {
            let db = try Connection(path)
            let item = tableResource.filter(id == bmiObj.id)

            try db.run(
                item.update(
                    name <- bmiObj.name,
                    weight <- bmiObj.weight,
                    height <- bmiObj.height,
                    bmi <- bmiObj.bmi,
                    date <- bmiObj.date
                )
            )
        } catch {
            print(error)
        }
        
    }
    
    
    
    
    func deleteDate(rowid: Int64) {
        do {
            print("delete id:\(rowid)")
            let db = try Connection(path)
            let item = tableResource.filter(id == rowid)
            try db.run(item.delete())
            
        } catch {
            print(error)
        }
    }
    
    
    
    
    
}
