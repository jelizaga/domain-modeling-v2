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
// PROTOCOL: Mathematics //////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

// Protocol for mathematics performed with Money.
protocol Mathematics {
    func add(this: Money, that: Money) -> Money
    func sub(this: Money, from: Money) -> Money
}

// Returns Money: X + Y.
// If Y's currency does not match the currency of X, it is converted to the currency of X.
func add(this: Money, that: Money) -> Money {
    var computed: Int = 0
    if (this.currency == that.currency) {
        computed = this.amount + that.amount
    } else {
        var thatConverted = that
        thatConverted.convert(this.currency)
        computed = this.amount + thatConverted.amount
    }
    return Money(amount: computed, currency: this.currency)
}

// Returns Money: X - Y.
// If Y's currency does not match the currency of X, it is converted to the currency of X.
func sub(from: Money, this: Money) -> Money {
    var computed: Int = 0
    if (from.currency == this.currency) {
        computed = from.amount - this.amount
    } else {
        var thisConverted = this
        thisConverted.convert(this.currency)
        computed = this.amount - thisConverted.amount
    }
    return Money(amount: computed, currency: this.currency)
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// EXTENSION: Double //////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

// A Double can now be converted into Money.
extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    var CAN: Money {
        return Money(amount: Int(self), currency: "CAN")
    }
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// STRUCT: Money //////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

public struct Money: CustomStringConvertible {
    
    public var amount: Int
    public var currency: String
    public var description: String {
        get {
            return ("\(amount) \(currency)")
        }
    }
    
    var add: Double {
        return 0.0
    }
  
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

public class Job: CustomStringConvertible {
    
    public var title: String
    public var type: JobType
    public var description: String {
        get {
            return ("Job: \(title)")
        }
    }
    
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

public class Person: CustomStringConvertible {
    
    public var firstName : String = ""
    public var lastName : String = ""
    public var age: Int = 0
    public var description: String {
        get {
            return ("\(firstName) \(lastName), age \(age).")
        }
    }

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
  
    // Returns the household income, as in, the total income of every person in the household.
    public func householdIncome() -> Int {
        var income = 0
        for person in members {
            if person.job != nil {
                switch (person.job!.type) {
                case .Hourly(let amount):
                    income += (person.job?.calculateIncome(Int(amount) * 2000))!
                case .Salary(let amount):
                    income += amount
                }
            }
        }
        return income
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UNIT TESTS /////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

print("Beginning tests.")

// Testing CustomStringConvertible.
var moneyTest = Money(amount: 5, currency: "USD")
var jobTest = Job(title: "Yolo", type: .Hourly(15.0))
var personTest = Person(firstName: "Ted", lastName: "Neward", age: 50)

print("Description of a Money: \(moneyTest.description)")
print("Description of a Job: \(jobTest.description)")
print("Description of a Person: \(personTest.description)")

// Testing Mathematics.


// Testing Double extension.
var doubleTest1 = 5.0
var doubleTest2 = 0.0
var doubleTest3 = 100.00
var doubleTest4 = 7.0
print("\(doubleTest1) in USD: \(doubleTest1.USD)")
print("\(doubleTest2) in CAN: \(doubleTest2.CAN)")
print("\(doubleTest3) in EUR: \(doubleTest3.EUR)")
print("\(doubleTest4) in GBP: \(doubleTest4.GBP)")

print("")
print("Tests complete.")


