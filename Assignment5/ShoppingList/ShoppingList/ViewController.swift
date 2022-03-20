//
//  ViewController.swift
//  ShoppingList
//
//  Created by Pengju Zhang on 2/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shoppingList: UITableView!
    @IBOutlet var textField: [UITextField]!
    @IBOutlet weak var test: UILabel!
    @IBOutlet var viewList: [UIView]!

    var list = [String]()
    var isListEmpty = true
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingList.delegate = self
        shoppingList.dataSource = self
        viewInit()
        noItemNotification()
    }
    

    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
        print("background touch")
    }
    
    
    // clear, edit, add button
    @IBAction func clearList(_ sender: UIButton) {
        isListEmpty = true
        noItemNotification()
    }
    
    @IBAction func edit(_ sender: UIButton) {
        for tf in textField {
            tf.text = ""
            tf.resignFirstResponder()
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        if checkInputValidation() == false {return}
        if (isListEmpty == true) {
            isListEmpty = false
            noItemNotification()
        }
        list.insert(stringfy(), at: 0)
        shoppingList.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
    }

    func stringfy() -> String{
        let description = textField[0].text
        let quantity = textField[1].text
        return "\(description!): \(quantity!)"
    }
    func viewInit() {
        for eachView in viewList {
            eachView.addTapGesture(tapNumber: 1, target: self, action: #selector(viewTapGesture(_:)))
        }
    }
    func checkInputValidation() -> Bool {
        if (textField[0].text == "" || textField[1].text == "" || Int(textField[1].text!) == nil) {
            errorAlert()
            return false
        }
        return true
    }
    func noItemNotification() {
        list.removeAll()
        shoppingList.reloadData()
        if (isListEmpty == true) {
            list.insert("No Item", at: 0)
            shoppingList.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    func errorAlert() {
        let message = "You should ensure that neither input is empty, and the quantity field is an integer."
        let title = "Error"
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .alert)

        // Create the action.
        let cancelAction =
            UIAlertAction(title: "OK",
                          style: .cancel,
                          handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
    @objc func viewTapGesture(_ gesture: UITapGestureRecognizer) {
        for tf in textField {
            tf.resignFirstResponder()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") {  (action, view, handler) in
            self.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension UIView {
  func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
    let tap = UITapGestureRecognizer(target: target, action: action)
    tap.numberOfTapsRequired = tapNumber
    addGestureRecognizer(tap)
    isUserInteractionEnabled = true
  }
}
