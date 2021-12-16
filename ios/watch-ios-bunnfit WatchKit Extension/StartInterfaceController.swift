//
//  StartInterfaceController.swift
//  watch-ios-bunnfit WatchKit Extension
//
//  Created by Bunnit on 2021/12/14.
//

import WatchKit
import Foundation
import WatchConnectivity

class StartInterfaceController: WKInterfaceController, WCSessionDelegate{
  
  var session: WCSession?
  
  var array : [String] = []
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    setTitle("Bunn.Fit")
    // Configure interface objects here.
    if WCSession.isSupported(){
      self.session = WCSession.default
      self.session?.delegate = self
      self.session?.activate()
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
  
  // 위의 class InterfaceController: WKInterfaceController,WCSessionDelegate에서 WCSessionDelegate 부분 에러 안나게 하려면 필요
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
    
    let message = message as NSDictionary
    
//    print(type(of: message))
//    print(message)
//
    for (_,value) in message{
//      print(value)
      array.append(String(describing: value))
    }
    print(array)
  }
  
  @IBAction func ConnectButtonTapped() {
    if array.count > 0 {
      pushController(withName: "InterfaceController", context: array)
    }
    return
  }
}
