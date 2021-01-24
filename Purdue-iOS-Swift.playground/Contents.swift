//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Foundation

// 1. Declaring variables
    // Two Options: var vs. let
    var myVar = "myVar"
    let myLet = "myLet"
    
    // "let" variables are constants
    // myLet = "newVal" <-- Not allowed

    // You can specify variable type in two ways
    var myInt = 5 // automatically interpreted as integer
    var myInt2: Int = 5 // explicitly stated as integer (useful for people reading your code and class vars)

// 2. Arrays
    // Initializing an array
    var myNums = [1, 2, 3, 4, 5]

    // Elements don't have to be of same type
    var myStuff: [Any] = [1, "Hi", 3.6] // have to specify it is an array of "Any" type

    // Useful methods
    myNums.append(6) // append element
    myNums.remove(at: 0) // remove at index 0
    print(myNums)
    // there are many more
    // Tip: type "<array/variable name>." to see a list of suggested methods

// 3. Functions
    // Declaring a function
    func myFunction(_ arg1: String, arg2: Int) {
        // Tip: Interpolate variable into strings with backslash-parentheses
        print("Your arg1 is \(arg1) and arg2 is \(arg2)")
    }

    // The underscore in the function signature before arg1 means we don't need to label it, but typically it is useful to label arguments.
    myFunction("Hello", arg2: 47)

    // Specifying return type
    func myReturningFunction(arg1: Int) -> String { // returns a String
        return "The number is \(arg1)"
    }

// 4. Control Statements
    // If statement
    var ifInt = Int.random(in: 0..<3)  // Produces a random integer between 0 (inclusive) and 3 (exclusive)
    if ifInt == 2 {
        print("myInt was 2!")
    }
    else if ifInt == 1 {
        print("myInt was 1!")
    }
    else {
        print("myInt was 0!")
    }

    // Switch statement
    switch ifInt {
        case 2:
            print("Switch says 2!")
            break
        case 1:
            print("Switch says 1!")
            break
        default:
            print("Switch says 0!")
            break
    }

    // For loop
    for num in 0...5 { // Range from 0 (inclusive) to 5 (inclusive)
        print("num is \(num)")
    }

    // Looping through an array
    var myItems = ["Hello", "to", "Purdue", "iOS!"]
    for word in myItems {
        print(word)
    }

// 5. Classes and structs
    // Creating a Class
    class myClass {
        var property1: Int
        var property2: String
        var property3: Float
        
        // Initializer
        init(property1: Int, property2: String, property3: Float) {
            self.property1 = property1
            self.property2 = property2
            self.property3 = property3
        }
        
        // Instance method; called on an instance of myClass
        func printProperties() {
            print("Prop1: \(self.property1), Prop2: \(self.property2), Prop3: \(self.property3)")
        }
        
        // class func; doesn't belong to a specific instance
        class func myClassFunc() {
            print("Hello from myClass!")
        }
    }

    // Creating an instance
    var myClassInstance = myClass(property1: 3, property2: "myProperty2", property3: 4.7)
    myClassInstance.printProperties() // called on our instance
    myClass.myClassFunc() // called on the class itself

    // Creating a Struct
    struct myStruct {
        var structProp1: Int
        var structProp2: String
        var structProp3: Float
        
        // standard initializer automatically created--no need to write one
    }

    // Creating an instance
    var myStructInstance = myStruct(structProp1: 4, structProp2: "myStructProp2", structProp3: 6.5)

    // Structs are generally more lightweight than classes
    // Additionally, structs are considered "value types,"
        // which means functions can't alter their properties directly,
    func myAlterations(myClassArg: myClass, myStructArg: myStruct) {
        myClassArg.property1 += 1
        // myStructArg.structProp1 += 1 <-- This is illegal because the function gets a read-only copy of the struct
    }

    // **Optional topic** If you do want to pass the original struct directly, you can pass it by reference
    func alterStruct(myStructArg: inout myStruct) { // the "inout" keyword indicates we are passing the reference to the original struct
        myStructArg.structProp1 += 1
    }

    print("Original Val: \(myStructInstance.structProp1)")
    alterStruct(myStructArg: &myStructInstance)
    print("New Val: \(myStructInstance.structProp1)")

// 6. Optionals
    // Optionals are one of the most unique features of Swift
    // They are Swift's way to handle the possibility of receiving a null (called nil in Swift) value
    
    // Normal variables can't hold nil
    // var myString: String = nil <-- illegal

    // However, an optional variable can
    var myOptString: String? = nil // the question mark specifies the type as an optional String

    // Let's see how this could be useful
    // Consider a function that takes in a string and prints it out
    func printString(arg: String) {
        // Because we know regular Strings cannot be assigned nil, we don't have to worry about
        // how this will behave if arg is nil, because it never will be
        print("String is \(arg)")
    }

    // Now consider a UILabel that might be in your app
    var myLabel = UILabel()
    myLabel.text = "Hello" // the text attribute of a label is an optional String

    // We cannot pass the text of this label into our function directly
    // printString(arg: myLabel.text) <-- throws error "Value of optional type 'String?' must be unwrapped to a value of type 'String'"

    // How do we deal with this?
    // Option 1: Force unwrapping (not recommended)
    // With the exclamation mark, we can "force unwrap" the optional string to be a normal string
    printString(arg: myLabel.text!)
    // This will work as long as myLabel.text is not nil
    // If myLabel.text is nil, however, you'll get an error and the app will likely crash which is why force unwrapping is not recommended

    // Option 2: nil coalescing
    // We can pass a back-up value into the function in case myLabel.text is nil
    printString(arg: myLabel.text ?? "Default val") // <-- passes in "Default val" if myLabel.text is nil, otherwise just passes in myLabel.text

    // Option 3: Unwrapping the optional
    // Let's make a wrapper function that accepts an optional string
    func printStringWrapper(arg: String?) {
        // Option 3.1: If-let
        if let contents = arg {
            // we unwrap the optional into the variable "contents"
            // we'll fall into this condition only if arg is not nil
            printString(arg: contents)
        }
        else {
            // if the arg is nil, we'll fall into this else condition
            print("The value was nil")
            return
        }
        
        // print(contents) <-- with if-let, we can't access contents outside of the if statement
        
        // Option 3.2: Guard-let
        guard let contents2 = arg else {
            // we unwrap the optional into "contents2"
            // This is what runs if arg is nil
            print("The value was nil")
            return
        }
        
        printString(arg: contents2) // <-- with guard-let, we have full access to unwrapped string contents2 after the guard statement
    }

    // We can now pass the label text into the wrapper
    printStringWrapper(arg: myLabel.text) // prints the text

    myLabel.text = nil
    printStringWrapper(arg: myLabel.text) // prints "The value was nil"

    // Unwrapping the optional is particularly useful for situations like parsing network calls, where we don't know if we received a valid response in some variables.
    // It allows us to easily define how we want to handle cases when a variable has a nil value.
