import Foundation

public func testMe() -> String {
    return "I have been tested!"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested!"
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// STRUCT: Money //////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
public struct Money {
    
    public var amount: Int
    public var currency: String
  
    // Calls conversions depending on the received currency.
    public mutating func convert(to: String) -> Money {
        if (currency == "USD") {
            convertUSD(to)
        } else if (currency == "GBP") {
            convertGBP(to)
        } else if (currency == "EUR") {
            convertEUR(to)
        } else if (currency == "CAN") {
            convertCAN(to)
        } else {
            print("Current currency is not USD, GBP, EUR, or CAN.")
        }
        return self
    }
    
    // Converts from USD.
    private mutating func convertUSD(to: String) {
        var dubAmount = Double(amount)
        if (to == "CAN") {
            dubAmount = dubAmount * 1.25
            amount = Int(dubAmount)
            currency = "CAN"
        } else if (to == "EUR") {
            dubAmount = dubAmount * 1.5
            amount = Int(dubAmount)
            currency = "EUR"
        } else if (to == "GBP") {
            dubAmount = dubAmount * 0.5
            amount = Int(dubAmount)
            currency = "GBP"
        } else {
            print("Currency to convert to is not USD, GBP, EUR, or CAN.")
        }
    }
    
    // Converts from CAN.
    private mutating func convertCAN(to: String) {
        var dubAmount = Double(amount)
        dubAmount = dubAmount / 0.8
        if (to == "USD") {
            amount = Int(dubAmount)
            currency = "USD"
        } else if (to == "EUR") {
            dubAmount = dubAmount * 1.5
            amount = Int(dubAmount)
            currency = "EUR"
        } else if (to == "GBP") {
            dubAmount = dubAmount * 0.5
            amount = Int(dubAmount)
            currency = "GBP"
        } else {
            print("Currency to convert to is not USD, GBP, EUR, or CAN.")
        }
    }
    
    // Converts from EUR.
    private mutating func convertEUR(to: String) {
        var dubAmount = Double(amount)
        dubAmount = dubAmount / 0.66
        if (to == "CAN") {
            dubAmount = dubAmount * 1.25
            amount = Int(dubAmount)
            currency = "CAN"
        } else if (to == "USD") {
            amount = Int(dubAmount)
            currency = "USD"
        } else if (to == "GBP") {
            dubAmount = dubAmount * 0.5
            amount = Int(dubAmount)
            currency = "GBP"
        } else {
            print("Currency to convert to is not USD, GBP, EUR, or CAN.")
        }
    }
    
    // Converts from GBP.
    private mutating func convertGBP(to: String) {
        var dubAmount = Double(amount)
        dubAmount = dubAmount * 2
        if (to == "CAN") {
            dubAmount = dubAmount * 1.25
            amount = Int(dubAmount)
            currency = "CAN"
        }
        if (to == "EUR") {
            dubAmount = dubAmount * 1.5
            amount = Int(dubAmount)
            currency = "EUR"
        }
        if (to == "USD") {
            amount = Int(dubAmount)
            currency = "USD"
        } else {
            print("Currency to convert to is not USD, GBP, EUR, or CAN.")
        }
    }
  
    // Returns self, having added received money to self.
    public mutating func add(to: Money) -> Money {
        self.amount = self.amount + to.amount
        return self
    }
    
    // Returns self, having subtracted received amount from self.
    public mutating func subtract(from: Money) -> Money {
        self.amount = self.amount - from.amount
        return self
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS: Job /////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
public class Job {
    
    public var title: String
    public var type: JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
  
    // Initializes Job with received string and JobType.
    public init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
  
    // Receives hours and calculates hourly wage if job is waged by the hour.
    // Receives hours and returns salary if job is salaried.
    public func calculateIncome(hours: Int) -> Int {
        switch type {
            case .Hourly(let hourly):
                return Int(hourly * Double(hours))
            case .Salary(let salary):
                return salary
        }
    }
  
    // Receives an amount and adds it to the employee's salary/wage.
    public func raise(amt: Double) {
        switch type {
            case .Hourly(let hourly):
                type = JobType.Hourly(hourly + amt)
            case .Salary(let salary):
                type = JobType.Salary(salary + Int(amt))
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS: Person //////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
public class Person {
    
    public var firstName : String = ""
    public var lastName : String = ""
    public var age: Int = 0

    // Private variables for
    private var _job: Job?
    private var _spouse: Person?
    
    // If Person has a job, return their job.
    // If not, set the received Job to their job. If they're 16 or under, they have no job.
    public var job: Job? {
        get {
            return self._job
        }
        set(value) {
            if (age < 16) {
                print("Person is too young to legally have a job.")
                self._job = nil
            } else {
                self._job = value
            }
        }
    }
  
    // If Person has a spouse, return spouse.
    // If not, set private spouse to received Person.
    public var spouse: Person? {
        get {
            return self._spouse
        }
        set(value) {
            if (age < 18) {
                print("Person is too young to legally marry.")
                self._spouse = nil
            } else {
                self._spouse = value
            }
        }
    }
  
    // Initializes a Person.
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
  
    // Returns Person's name.
    public func toString() -> String {
        return (firstName + " " + lastName)
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS: Family //////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
public class Family {
  
    private var members: [Person] = []
  
    // Receives two Persons. If they each have no spouse, their spouse is set to each other.
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
        members.append(spouse1)
        members.append(spouse2)
    }
  
    // Receives a Person, sets age to 0. Returns false if there's nobody in the family over 21.
    public func haveChild(child: Person) -> Bool {
        child.age = 0
        var foundAdult = false
        for person in members {
            if person.age == 21 {
                foundAdult = true
            }
        }
        return foundAdult
    }
  
    // 2000
    public func householdIncome() -> Int {
        var income = 0
        for person in members {
            let job = person.job
            if (job != nil) {
                income += (person.job?.calculateIncome(40 * 50))!
            }
        }
        return income
    }
    
}





