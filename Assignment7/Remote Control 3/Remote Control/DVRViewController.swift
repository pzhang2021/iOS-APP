//
//  DVRViewController.swift
//  Remote Control
//
//  Created by Pengju Zhang on 2/21/22.
//

import UIKit

class DVRViewController: UIViewController {

    @IBOutlet weak var power: UILabel!
    @IBOutlet weak var state: UILabel!
    var isPowerOn: Bool = true
    var responseMessages = [
        "Play": "Playing",
        "Stop": "Stopped",
        "Pause": "Paused",
        "Forward": "Forwarding",
        "Rewind": "Rewinding",
        "Record": "Recording"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        power.text = "On"
        state.text = "Playing"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func powerSwitch(_ sender: UISwitch) {
        isPowerOn = sender.isOn
        power.text = isPowerOn ? "On" : "Off"
        state.text = isPowerOn ? "Playing" : "N/A"
    }
    
    @IBAction func statePressed(_ sender: UIButton) {
        if !isPowerOn {return}
        if let title = sender.currentTitle {
            stateHandler(title)
        }
    }
    func stateHandler(_ pressedButton: String) {
        let currentState: String = state.text!
        if let newState =  responseMessages[pressedButton] {
            if (currentState == newState) {return}
            if (currentState != "Playing" &&
            (newState == "Paused" ||
             newState == "Forwarding" ||
             newState == "Rewinding")) {
                errorOneAlert(newState)
                return
            }
            if (currentState != "Stopped" &&
                newState == "Recording") {
                errorTwoAlert(newState)
                return
            }
            state.text = newState
        }
    }
    
    func errorOneAlert(_ newState: String) {
        let message = "Pausing, forwarding or rewinding is only possible when the DVR is in the Playing state. Do you want force proceed?"
        let title = "Error"
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .alert)

        // Create the action.
        let cancelAction =
            UIAlertAction(title: "NO",
                          style: .cancel,
                          handler: nil)
        
        let confirmAction =
            UIAlertAction(title: "YES",
                          style: .default,
                          handler: {(ACTION) in self.state.text = newState}
                          )
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    func errorTwoAlert(_ newState: String) {
        let message = "Recording can only start when the DVR is in the Stopped state. Playing, pausing, fast forwarding or rewinding is not possible when the DVR is in the Recording state. Do you want force proceed?"
        let title = "Error"
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .alert)

        // Create the action.
        let cancelAction =
            UIAlertAction(title: "NO",
                          style: .cancel,
                          handler: nil)
        
        let confirmAction =
            UIAlertAction(title: "YES",
                          style: .default,
                          handler: {(ACTION) in self.state.text = newState}
                          )
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
}

