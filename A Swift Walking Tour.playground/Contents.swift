//: # A Swift Walking Tour
//:
import Foundation
//:
//: ## Walking Tour Stop 1: Variables and Constants
//:
//:
var myVariable = 42
myVariable = 50
let myConstant = 42
//myConstant = 22

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
let explicitFloat: Float = 20

let sum = explicitDouble + Double(explicitFloat)

let label = "The width is "
let width = 94
let widthLabel = label + String(width)

//: String Interpolation

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."


//:
//: ## Walking Tour Stop 2: Arrays, Dictionaries, and Sets
//:

var shoppingList  = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"

let emptyArray = [String]()
let emptyDictionary = [String: Float]()

shoppingList = []
occupations = [:]

var fireflyCharacterSet = Set<String>()
fireflyCharacterSet.insert("Malcolm Reynolds")
fireflyCharacterSet.insert("Zoe Washburne")
fireflyCharacterSet.insert("Malcolm Reynolds")



//: ## Walking Tour Stop 3: Control Flow

//: for loop
var secondForLoop = 0
for var i = 0; i < 4; ++i {
    secondForLoop += i
}
print(secondForLoop)

//: For-in loops
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

//: Switch
let vegetable = "red pepper"
switch vegetable {
  case "celery":
    print("Add some raisins and make ants on a log.")
  case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
  case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
  default:
    print("Everything tastes good in soup.")
    break
}

//: While Loops
var n = 2
while n < 100 {
    n = n * 2
}
print(n)

//: Repeat-While (Do-While) loops
var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)


//: ## Walking Tour Stop 4: Optionals
//:


var optionalString: String? = "Hello"
print(optionalString == nil)

if optionalString != nil {
    print(optionalString!)
}

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}

//: nil coalescing operator

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informGreet = (nickName != nil ? nickName! : fullName)
let informalGreeting = "Hi \(nickName ?? fullName)"

//: Optional chaining
let myName : String? = "Eric Hyche"
let numChars = myName?.characters.count
print("Number of characters in \(myName) is \(numChars)")


//: ## Walking Tour Stop 5: Functions and Closures

func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}
greet("Bob", day: "Tuesday")

func formalGreet(extName name: String, extDay day: String) -> String {
    return "Hello \(name), today is \(day)."
}
formalGreet(extName: "Bob", extDay: "Tuesday")


//: Functions are first-class types
typealias intToBool = (Int) -> Bool
func hasAnyMatches(list: [Int], condition: intToBool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, condition: lessThanTen)

//: Completely specified closure
let sortedNumbers1 = numbers.sort({(first: Int, second: Int) -> Bool in
    return first < second
})

//: Know the function signature, so we can omit
let sortedNumbers2 = numbers.sort({ first, second in
    return first < second
})

//: For single-line closures, can omit the `return`
let sortedNumbers3 = numbers.sort({ first, second in first < second })
sortedNumbers3

//: Can use argument indexes rather than names
let sortedNumbers4 = numbers.sort({ $0 < $1 })
sortedNumbers4

//: If closure is last argument of function, can also write as a trailing closure
let sortedNumbers5 = numbers.sort() { $0 < $1 }
sortedNumbers5

//: If there is a "<" operator which takes two Int's and returns a Bool, then
let sortedNumbers6 = numbers.sort(<)


//: ## Walking Tour Stop 6: Tuples
typealias twoInts = (Int, Int)
typealias successAndError = (Bool, NSError)

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

//: ## Walking Tour Stop 7: Classes and Properties

//: ### Internal / external properties

//: Access Control:
//: - **Public**: Any code in ANY module - for public interface to a framework
//: - **Internal**: Any in SAME module
//: - **Private**: Any code in the same source file

//: We more commonly need:
//: - Methods/properties which are externally available on an object
//: - Methods/properties which are internal to an object (private)

class MyClass {

    // External properties
    var externalProperty: Int = 0

    // Private properties
    private var internalProperty: Int = 0

    // External readonly, but private readwrite property
    private(set) var internalReadwriteExternalReadonly: Int = 0

    // MARK: External methods
    func externalMethod() {
        internalMethod()
    }

    // MARK: Private methods
    private func internalMethod() {

    }
}

var myClass = MyClass()
myClass.externalProperty = 20
//myClass.internalProperty = 10 // Normally you can't do this


class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//: ### Inheritance and Two-Phase Initialization

var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

// Note it doesn't inherit from NSObject
class NamedShape {
    var numberOfSides: Int
    var name: String

    init(name: String) {
        // Must use self.name to distinguish from the argument "name"
        self.name = name
        self.numberOfSides = 0
    }

    func simpleDescription() -> String {
        // Don't have to use self.numberOfSides
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double

    convenience init() {
        // Cannot put anything here
        self.init(sideLength: 1.0, name: "MyQ")
        numberOfSides = 42
    }

    init(sideLength: Double, name: String) {
        // Note we have to give sideLength a value BEFORE we call super.init
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() ->  Double {
        return sideLength * sideLength
    }

    // Note we have to use override to say we are overriding a function in our super class
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()


//: Computed properties
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }

    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

//: ## Walking Tour Stop 8: Enumerations
//:
enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King

    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue

if let convertedRank = Rank(rawValue: 14) {
    let threeDescription = convertedRank.simpleDescription()
}

enum Suit: String {
    case Spades, Hearts, Diamonds, Clubs

    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()

//: Enumeration with associated values
enum ServerResponse {
    case Result(String, String)
    case Error(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese.")

switch success {
  case let .Result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
  case let .Error(error):
    print("Failure...  \(error)")
}

//: ## Walking Tour Stop 9: Structs

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    mutating func changeMySuit() {
        rank = .Ace
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

//: ## Walking Tour Stop 10: Protocols

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

//: ## Walking Tour Stop 11: Extensions

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    // mutating is needed for value types
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)

//: ## Walking Tour Stop 12: Documentation features

class MyDocumentedClass {

    /**
      This is an example of a documented function.
     
      - author: Eric Hyche
      - date: 12/10/2015
      - warning: Don't try this at home.
     
      This function produces users that look like this:

      ![Accessibility Text](http://img.gawkerassets.com/img/17eb87aonwld8jpg/original.jpg "Hover Text")

     
      - parameter name: This is the string argument
     
      - parameter priority: This is the int argument
     
      - returns: This is the return value text
     
      - throws: Not many errors
     
      - seealso: [Markup Formatting Reference](https://developer.apple.com/library/ios/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html#//apple_ref/doc/uid/TP40016497-CH2-SW1)
     */
    func myDocumentedFunc(name: String, priority: Int) -> String {
        return "I Heart Comments"
    }

}

let docClass = MyDocumentedClass()
// Option-click on "myDocumentedFunc" below
docClass.myDocumentedFunc("foo", priority: 1)

