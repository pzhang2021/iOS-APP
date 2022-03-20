// Assignment 2 Pengju Zhang
import UIKit

// part (a) binary search
func binarySearch(_ list: [Int], _ key: Int) -> Int {
    var left: Int = 0;
    var right: Int = list.count;
    while (left < right) {
        let middle: Int = left + (right - left)/2;
        if (list[middle] == key) {
            return middle;
        }
        if (list[middle] > key) {
            right = middle;
        }
        else {
            left = middle + 1;
        }
    }
    return -1;
}

// example test
func binarySearchTest(_ list: [Int]) {
    for i in 0...list.count - 1 {
        print(i == binarySearch(list, list[i]))
    }
}

let test = [10, 17, 19, 25, 27, 32, 43, 55]
binarySearchTest(test)

// part(b)
class Fraction {
    var numerator: Int = 0;
    var denominator: Int = 1;
    
    init(_ numerator: Int, over denominator: Int) {
        self.numerator = numerator;
        self.denominator = denominator;
    }
    
    init() {}
    
    func print() {
        Swift.print(self.getString());
    }
    
    func getString() -> String {
        self.reduce();
        return "\(numerator)/\(denominator)";
    }

    func add(_ f: Fraction) -> Fraction {
        let newNumerator: Int = numerator * f.denominator + denominator * f.numerator;
        let newdenominator: Int = denominator * f.denominator;
        return Fraction(newNumerator, over: newdenominator);
    }
    
    func substract(_ f: Fraction) -> Fraction {
        let newNumerator: Int  = numerator * f.denominator - denominator * f.numerator;
        let newdenominator: Int = denominator * f.denominator;
        return Fraction(newNumerator, over: newdenominator);
    }
    
    func multiply(_ f: Fraction) -> Fraction {
        let newNumerator: Int  = numerator * f.numerator;
        let newdenominator: Int = denominator * f.denominator;
        return Fraction(newNumerator, over: newdenominator);
    }
    
    func divid(_ f: Fraction) -> Fraction {
        let newNumerator: Int  = numerator * f.denominator;
        let newdenominator: Int = denominator * f.numerator;
        return Fraction(newNumerator, over: newdenominator);
    }
    
    func reduce(){
        var u = abs(numerator)
        var v = denominator
        var r: Int
        while (v != 0) {
            r = u % v; u = v; v = r
        }
        numerator /= u
        denominator /= u
    }
}


// example test
func fractionTest(_ f1: Fraction, _ f2: Fraction) {
    let list = ["Addition": f1.add(f2), "Substraction": f1.substract(f2), "Multiplication": f1.multiply(f2), "Division": f1.divid(f2)];
    for (methodName, methodRes) in list {
        print("\(methodName): \(methodRes.getString())");
    }
}

let f1 = Fraction(1, over: 2);
let f2 = Fraction(1, over: 3)
fractionTest(f1, f2);

