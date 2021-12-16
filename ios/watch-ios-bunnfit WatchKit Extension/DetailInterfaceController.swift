//
//  DetailInterfaceController.swift
//  watch-ios-bunnfit WatchKit Extension
//
//  Created by Bunnit on 2021/11/18.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {
  
  @IBOutlet weak var detailLabel: WKInterfaceLabel!
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    // Configure interface objects here.
    if let detailData = context as? String {
      detailLabel.setText("Next: "+detailData)
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  @IBAction func GoToRestTimer() {
    pushController(withName: "RestTimerInterfaceController", context: nil)
  }
}
