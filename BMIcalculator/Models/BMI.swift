
import Foundation

class BMI
{
    // instance variables (Data members / fields)
    private var m_id: Int64
    private var m_name: String
    private var m_age: Int
    private var m_gender: String
    private var m_weight: Double
    private var m_height: Double
    private var m_bmi: Double
    private var m_date: String
    private var m_mode: String
    
    // public properties
    public var id: Int64
    {
        get
        {
            return m_id
        }
    }
    public var mode: String
    {
        get
        {
            return m_mode
        }
    }
    public var name: String
    {
        get
        {
            return m_name
        }
        
        set(newName)
        {
            m_name = newName
        }
    }
    public var age: Int
    {
        get
        {
            return m_age
        }
    }
    public var gender: String
    {
        get
        {
            return m_gender
        }
    }
    public var weight: Double
    {
        get
        {
            return m_weight
        }
        
        set(newWeight)
        {
            m_weight = newWeight
        }
    }
    
    public var height: Double
    {
        get
        {
            return m_height
        }
        
        set(newHeight)
        {
            m_height = newHeight
        }
    }
    public var bmi: Double
    {
        get
        {
            return m_bmi
        }
        
        set(newBmi)
        {
            m_bmi = newBmi
        }
    }
    public var date: String
    {
        get
        {
            return m_date
        }
        
        set(newDate)
        {
            m_date = newDate
        }
    }
    
    // initializer (constructor)
    init(id: Int64 = 0, name: String = "Greg", age:Int = 30, gender:String = "Male", weight: Double = 0, height: Double = 0, date: String = "", mode: String = "Imperial")
    {
        m_name = name
        m_age = age
        m_gender = gender
        
        m_weight = weight
        m_height = height
        m_date = date
        if (mode == "Imperial")
        {
            m_bmi = (weight * 703) / (height*height)
        }
        else
        {
            m_bmi = weight / (height*height)
        }
        
        m_id = id
        m_mode = mode
    }
    

}
