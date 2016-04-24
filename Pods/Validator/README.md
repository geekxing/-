# Validator

Validator is a user input validation library written in Swift.

![demo-vid](resources/demo.mp4.gif)

> 👴 If you're looking for the old Objective-C implementation (AJWValidator) visit the [objc branch](https://github.com/adamwaite/Validator/tree/objc).

## Features

- [x] Validation rules:
  - [x] Required
  - [x] Equality
  - [x] Comparison
  - [x] Length (min, max, range)
  - [x] Pattern (email, password constraints and more...)
  - [x] Contains
  - [x] URL
  - [x] Payment card (Luhn validated, accepted types)
  - [x] Condition (quickly write your own)
- [x] Swift standard library type extensions with one API (not just strings!)
- [x] UIKit element extensions
- [x] Flexible validation error types
- [x] An open protocol-oriented implementation
- [x] Comprehensive test coverage

## Installation

Install Validator with [CocoaPods](http://cocoapods.org):

`pod 'Validator'`

Install Validator with [Carthage](https://github.com/Carthage/Carthage):

`github "adamwaite/Validator"`

*Note - Embedded frameworks require a minimum deployment target of iOS 8.*

## Usage

`Validator` can validate any `Validatable` type using one or multiple `ValidationRule`s. A validation operation returns a `ValidationResult` which matches either `.Valid` or `.Invalid([ValidationErrorType])`, where `ValidationErrorType` extends `ErrorType`.

```swift
let rule = ValidationRulePattern(pattern: .EmailAddress, failureError: someValidationErrorType)

let result = "invalid@email,com".validate(rule: rule)
// Note: the above is equivalent to Validator.validate(input: "invalid@email,com", rule: rule)

switch result {
case .Valid: print("😀")
case .Invalid(let failures): print(failures.first?.message)
}
```

### Validation Rules

#### Required

Validates any type exists (not-nil).

```swift
let stringRequiredRule = ValidationRuleRequired<String?>(failureError: someValidationErrorType)

let floatRequiredRule = ValidationRuleRequired<Float?>(failureError: someValidationErrorType)
```

*Note - You can't use `validate` on an optional `Validatable` type (e.g. `myString?.validate(aRule...)` because the optional chaining mechanism will bypass the call. `"thing".validate(rule: aRule...)` is fine. To validate an optional for required in this way use: `Validator.validate(input: anOptional, rule: aRule)`.*

#### Equality

Validates an `Equatable` type is equal to another.

```swift
let staticEqualityRule = ValidationRuleEquality<String>(target: "hello", failureError: someValidationErrorType)

let dynamicEqualityRule = ValidationRuleEquality<String>(dynamicTarget: { return textField.text ?? "" }, failureError: someValidationErrorType)
```

#### Comparison

Validates a `Comparable` type against a maximum and minimum.

```swift
let comparisonRule = ValidationRuleComparison<Float>(min: 5, max: 7, failureError: someValidationErrorType)
```

#### Length

Validates a `String` length satisfies a minimum, maximum or range.

```swift
let minLengthRule = ValidationRuleLength(min: 5, failureError: someValidationErrorType)

let maxLengthRule = ValidationRuleLength(max: 5, failureError: someValidationErrorType)

let rangeLengthRule = ValidationRuleLength(min: 5, max: 10, failureError: someValidationErrorType)
```

#### Pattern

Validates a `String` against a pattern. Validator provides some common patterns in the `ValidationPattern` enum.

```swift
let emailRule = ValidationRulePattern(pattern: .EmailAddress, failureError: someValidationErrorType)

let digitRule = ValidationRulePattern(pattern: .ContainsDigit, failureError: someValidationErrorType)

let helloRule = ValidationRulePattern(pattern: ".*hello.*", failureError: someValidationErrorType)
```

#### Contains

Validates an `Equatable` type is within a predefined `SequenceType`'s elements (where the `Element` of the `SequenceType` matches the input type).

```swift
let stringContainsRule = ValidationRuleContains<String, [String]>(sequence: ["hello", "hi", "hey"], failureError: someValidationErrorType)

let rule = ValidationRuleContains<Int, [Int]>(sequence: [1, 2, 3], failureError: someValidationErrorType)
```

#### URL

Validates a `String` to see if it's a valid URL conforming to RFC 2396.

```swift
let urlRule = ValidationRuleURL(failureError: someValidationErrorType)
```

#### Payment Card

Validates a `String` to see if it's a valid payment card number by firstly running it through the [Luhn check algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm), and secondly ensuring it follows the format of a number of payment card providers.

```swift
public enum PaymentCardType: Int {
    case Amex, Mastercard, Visa, Maestro, DinersClub, JCB, Discover, UnionPay
    ///...
```

To be validate against any card type (just the Luhn check):

```swift
let anyCardRule = ValidationRulePaymentCard(failureError: someValidationErrorType)
```

To be validate against a set of accepted card types (e.g Visa, Mastercard and American Express in this example):

```swift
let acceptedCardsRule = ValidationRulePaymentCard(acceptedTypes: [.Visa, .Mastercard, .Amex], failureError: someValidationErrorType)
```

#### Condition

Validates a `Validatable` type with a custom condition.

```swift
let conditionRule = ValidationRuleCondition<[String]>(failureError: someValidationErrorType) { $0.contains("Hello") }
```

#### Create Your Own

Create your own validation rules by conforming to the `ValidationRule` protocol:

```swift
protocol ValidationRule {
    typealias InputType
    func validateInput(input: InputType) -> Bool
    var failureError: ValidationErrorType { get }
}
```

Example:

```swift
struct HappyRule {
    typealias InputType = String
    var failureError: ValidationError(message: "U mad?") }
    func validateInput(input: String) -> Bool {
        return input == "😀"
    }
}
```

> If your custom rule doesn't already exist in the library and you think it might be useful for other people, then it'd be great if you added it in with a [pull request](https://github.com/adamwaite/AJWValidator/pulls).

### Multiple Validation Rules (`ValidationRuleSet`)

Validation rules can be combined into a `ValidationRuleSet` containing a collection of rules that validate a type.

```swift
var passwordRules = ValidationRuleSet<String>()

let minLengthRule = ValidationRuleLength(min: 5, failureError: someValidationErrorType)
passwordRules.addRule(minLengthRule)

let digitRule = ValidationRulePattern(pattern: .ContainsDigit, failureError: someValidationErrorType)
passwordRules.addRule(digitRule)
```

### Validatable

Any type that conforms to the `Validatable` protocol can be validated using the `validate:` method.

```swift
// Validate with a single rule:

let result = "some string".validate(rule: aRule)

// Validate with a collection of rules:

let result = 42.validate(rules: aRuleSet)
```

#### Extend Types As Validatable

Extend the `Validatable` protocol to make a new type validatable.

`extension Thing : Validatable { }`

Note: The implementation inside the protocol extension should mean that you don't need to implement anything yourself unless you need to validate multiple properties.

### ValidationResult

The `validate:` method returns a `ValidationResult` enum. `ValidationResult` can take one of two forms:

1. `.Valid`: The input satisfies the validation rules.
2. `.Invalid`: The input fails the validation rules. An `.Invalid` result has an associated array of types conforming to `ValidationErrorType`.

You can combine two or more `ValidationResult`s together with `merge:`.

```swift
let result1 = ValidationResult.Invalid([someError])
let result2 = ValidationResult.Invalid([someError2])
let allResults = result1.merge(result2) // = ValidationResult.Invalid([someError1, someError2])
```

### ValidationErrorType

The `ValidationErrorType` extends `ErrorType` and adds a message property for holding a validation error message. This means that they're compatible with [Swift 2 error handling](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html) and flexible for defining your own.

```swift
struct User: Validatable {

    let email: String

    enum ValidationErrors: String, ValidationErrorType {
        case EmailInvalid = "Email address is invalid"
        var message { return self.rawValue }
    }

    func validate() -> ValidationResult {
        let rule ValidationRulePattern(pattern: .EmailAddress, failureError: ValidationErrors.EmailInvalid)
        return email.validate(rule: rule)
    }
}

```

Validator also ships with a basic `ValidationError` struct if you'd prefer to use that. It implements `ValidationErrorType`:

```swift
public struct ValidationError: ValidationErrorType {
    public let message: String
    public init(message m: String) {
        message = m
    }
}
```

### Validating UIKit Elements

UIKit elements that conform to `ValidatableInterfaceElement` can have their input validated with the `validate:` method.

```swift
let textField = UITextField()
textField.text = "I'm going to be validated"

let slider = UISlider()
slider.value = 0.3

// Validate with a single rule:

let result = textField.validate(rule: aRule)

// Validate with a collection of rules:

let result = slider.validate(rules: aRuleSet)
```

#### Validate On Input Change

A `ValidatableInterfaceElement` can be configured to automatically validate when the input changes in 3 steps.

1. Attach a set of default rules:

    ```swift
    let textField = UITextField()
    let rules = ValidationRuleSet<String>()
    rules.addRule(someRule)
    textField.validationRules = rules
    ```

2. Attach a closure to fire on input change:

    ```swift
    textField.validationHandler = { result, control in
	  switch result {
      case .Valid:
		    control.textColor = UIColor.blackColor()
      case .Invalid(let failureErrors):
		    let messages = failureErrors.map { $0.message }
            print(messages)
		    control.textColor = UIColor.redColor()
      }
    }
    ```

3. Begin observation:

    ```swift
    textField.validateOnInputChange(true)
    ```

Note - Use `.validateOnInputChange(false)` to end observation.

#### Extend UI Elements As Validatable

Extend the `ValidatableInterfaceElement` protocol to make an interface element validatable.

Example:

```swift
extension UITextField: ValidatableInterfaceElement {

    typealias InputType = String

    var inputValue: String { return text ?? "" }

    func validateOnInputChange(validationEnabled: Bool) {
        switch validationEnabled {
        case true: addTarget(self, action: "validateInputChange:", forControlEvents: .EditingChanged)
        case false: removeTarget(self, action: "validateInputChange:", forControlEvents: .EditingChanged)
        }
    }

    @objc private func validateInputChange(sender: UITextField) {
        sender.validate()
    }

}
```

The implementation inside the protocol extension should mean that you should only need to implement:

1.  The `typealias`: the type of input to be validated (e.g `String` for `UITextField`).
2.  The `inputValue`: the input value to be validated (e.g the `text` value for `UITextField`).
3.  The `validateOnInputChange:` method: to configure input-change observation.

## Examples

There's an example project in this repository.

## Contributing

Any contributions and suggestions are most welcome! Please ensure any new code is covered with unit tests, and that all existing tests pass. Please update the README with any new features. Thanks!

## Contact

[@adamwaite](http://twitter.com/adamwaite)

## License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
