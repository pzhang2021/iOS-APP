//
//  ConfigurationViewController.swift
//  Remote Control
//
//  Created by Pengju Zhang on 3/1/22.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var favoriteCh: UISegmentedControl!
    @IBOutlet weak var channelNum: UILabel!
    @IBOutlet weak var favoriteChLabel: UITextField!
    var dataIsNotModified: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteChLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if dataIsNotModified {return}
        let dataController = tabBarController as! TabBarDataViewController
        dataController.favoriteChannelData[favoriteCh.selectedSegmentIndex] = [favoriteChLabel.text!, channelNum.text!]
    }

    @IBAction func labelText(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func channelStepper(_ sender: UIStepper) {
        channelNum.text = "\(Int(sender.value))"
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dataIsNotModified = true
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if labelIsNotInRange() {return}
        dataIsNotModified = false
    }
    
    func labelIsNotInRange() -> Bool{
        let length = favoriteChLabel.text!.count
        if (length < 1 || length > 4) {
            errorAlert()
            return true
        }
        return false
    }
    
    func errorAlert() {
        let message = "The label must be between 1-4 letters in length."
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
        
        
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
}
