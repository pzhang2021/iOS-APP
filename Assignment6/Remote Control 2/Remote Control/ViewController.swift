//
//  ViewController.swift
//  Remote Control
//
//  Created by Pengju Zhang on 2/7/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var powerStatus: UILabel!
    @IBOutlet weak var volumeStatus: UILabel!
    @IBOutlet weak var channelStatus: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var favChannel: UISegmentedControl!
    
    var currentChannel: Int = 0
    var isPowerOn: Bool = true
    var input: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        powerStatus.text = "On"
        channelStatus.text = "N/A"
        volumeStatus.text = "10"
    }

    
    @IBAction func volumeSlider(_ sender: UISlider) {
        volumeStatus.text = "\(Int(sender.value))"
    }
    @IBAction func powerSwitch(_ sender: UISwitch) {
        isPowerOn = sender.isOn
        powerStatus.text = isPowerOn ? "On" : "Off"
        powerOffRest()
    }
    @IBAction func nextChannel(_ sender: UIButton) {
        if !isPowerOn || currentChannel == 99 {return}
        currentChannel += 1
        updateChannel()
    }
    @IBAction func prevChannel(_ sender: UIButton) {
        if !isPowerOn || currentChannel == 0 {return}
        currentChannel -= 1
        updateChannel()
    }
    @IBAction func channelInput(_ sender: UIButton) {
        if !isPowerOn {return}
        if let num = sender.currentTitle {
            input += num
            if (input.count == 2) {
                currentChannel = Int(input)!
                input = ""
                updateChannel()
            }
        }
    }
    @IBAction func favChannel(_ sender: UISegmentedControl) {
        if let name = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            channelStatus.text = name
        }
    }
    func updateChannel() {
        channelStatus.text = String(currentChannel)
    }
    func powerOffRest() {
        channelStatus.text = "N/A"
        volumeStatus.text = "10"
        volumeSlider.value = 10
        favChannel.selectedSegmentIndex = 0
        volumeSlider.isEnabled = isPowerOn
        favChannel.isEnabled = isPowerOn
    }
}

