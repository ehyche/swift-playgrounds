//: # Optionals

//: ## Default Values for Optionals

var intOpt: Int?
intOpt = 4

//: ## Can get optionals from Failable Initializers

let thisIsAnInt = "123"
let thisIsNotAnInt = "foo"
let isAnInt = Int(thisIsAnInt)
let isNotAnInt = Int(thisIsNotAnInt)

//: ## Checking for nil and forced unwrapping
if isAnInt != nil {
    print("isAnInt = \(isAnInt)")
    print("isAnInt! = \(isAnInt!)")
}

print("isNotAnInt = \(isNotAnInt)")
//print("isNotAnInt! = \(isNotAnInt!)")

//: ## Optional Binding

let mihaiMapperOpt : [String:String?]? =
    ["mihai1": "Mihai Popa",
     "mihai2": "Radu Mihai Costin",
     "mihai3": "Mihai Constandis",
     "mihai4": "Mihai Tatar",
     "mihai5": "Mihai Garda Popescu",
     "mihai6": "Mihai Vancea",
     "mihai7": "Mihai Pantiru"]

let mihaiToLookup = "mihai4"
if let mihaiMap = mihaiMapperOpt {
    if let mihaiLookupOpt = mihaiMap[mihaiToLookup] {
        if let mihaiLookup = mihaiLookupOpt {
            if mihaiLookup.characters.count > 0 {
                print("[[\(mihaiToLookup)] = \(mihaiLookup)")
            }
        }
    }
}

if let mihaiMap = mihaiMapperOpt, let mihaiLookupOpt = mihaiMap[mihaiToLookup], let mihaiLookup = mihaiLookupOpt where mihaiLookup.characters.count > 0 {
    print("[\(mihaiToLookup)] = \(mihaiLookup)")
}

//: ## Optional Chaining
//: How to avoid the if-let pyramid of death

class Person {
    var residence: Residence?
}

class Residence {
    var address: Address?
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

let john = Person()

let johnsHouse = Residence()
john.residence = johnsHouse

let someAddress = Address()
someAddress.buildingName = "The Carrolton"
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
}
