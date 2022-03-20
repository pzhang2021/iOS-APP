//
//  ViewController.swift
//  calculator
//
//  Created by Pengju Zhang on 2/1/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearAll()
    }
    
    var TextToDisplay = ""
    var sum = 0
    var restart = false
    
    func clearAll() {
        calculatorResult.text = ""
        TextToDisplay = ""
    }
    
    func addTextToDisplay(_ value: String) {
        TextToDisplay += value
        calculatorResult.text = TextToDisplay
    }
    
    @IBAction func plus(_ sender: UIButton) {
        restart = false
        sum += Int(TextToDisplay) ?? 0
        clearAll();
        calculatorResult.text = "+"
    }
    
    @IBAction func equal(_ sender: UIButton) {
        restart = !restart
        sum += Int(TextToDisplay) ?? 0
        clearAll()
        calculatorResult.text = String(sum)
    }
    
    @IBAction func addNum(_ sender: UIButton) {
        if restart && calculatorResult.text != "+" {
            sum = 0
        }
        addTextToDisplay(String(sender.tag))
    }
    

}

