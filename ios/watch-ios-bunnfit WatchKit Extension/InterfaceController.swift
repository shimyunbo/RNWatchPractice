//
//  InterfaceController.swift
//  watch-ios-bunnfit WatchKit Extension
//
//  Created by Bunnit on 2021/11/15.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
  var session: WCSession?
  
  @IBOutlet var myTable: WKInterfaceTable!
  @IBOutlet weak var myDate: WKInterfaceDate!
  @IBOutlet weak var myTimer: WKInterfaceTimer!
  @IBOutlet weak var startButton: WKInterfaceButton!
  @IBOutlet weak var endButton: WKInterfaceButton!
  
  let arr = ["벤치프레스", "스쿼트", "데드리프트", "오버헤드프레스"]
  var array : [String] = []
  
  var isTimerStarted = false
  var startTime = Date()
  var elapsedTime: TimeInterval = 0.0
  
  override func awake(withContext context: Any?) {
    // Configure interface objects here.
    //    if WCSession.isSupported(){
    //      self.session = WCSession.default
    //      self.session?.delegate = self
    //      self.session?.activate()
    //    }
    guard let values = context as? [Any] else { return }
    array = values.compactMap {String(describing: $0)}
    print(array)
    loadData()
  }
  
  struct WorkoutTime {
    var time : TimeInterval = 0.0
  }
  
  var wt = WorkoutTime()
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
  }
  
  private func loadData() {
    
    myTable.setNumberOfRows(array.count, withRowType: "RowController")
    for (index, labelText) in array.enumerated(){
      if let row = myTable.rowController(at: index) as? RowController{
        row.titleLabel.setText(labelText)
      }
    }
    
  }
  
  private func sendWatchMessage() {
    if(WCSession.default.isReachable){
      let message = ["Workout Time": wt.time]
      WCSession.default.sendMessage(message, replyHandler: nil)
    }
  }
  
  @IBAction func startButtonAction() {
    if array.count > 1 {
      loadData()
      isTimerStarted = !isTimerStarted
      if isTimerStarted {
        startTime = Date()
        startButton.setTitle("운동 정지")
        myTimer.setDate(Date(timeIntervalSinceNow: elapsedTime)) // 0초부터 지금까지의 시간
        myTimer.start()
      } else {
        let stoppedTime = Date()
        elapsedTime -= stoppedTime.timeIntervalSince(startTime)
        wt.time = elapsedTime * -1
        print(wt.time)
        startButton.setTitle("운동 시작")
        myTimer.stop()
      }
    }
    return
  }
  
  @IBAction func endButtonAction() {
    //    startTime = Date()
    //    elapsedTime = 0.0
    //    myTimer.setDate(startTime)
    isTimerStarted = false
    let stoppedTime = Date()
    elapsedTime -= stoppedTime.timeIntervalSince(startTime)
    wt.time = elapsedTime * -1
    print(wt.time)
    myTimer.stop()
    sendWatchMessage()
    pushController(withName: "EndInterfaceController", context: nil)
  }
  
//    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
//      pushController(withName: "DetailInterfaceController", context: arr[rowIndex])
//    }
  
  // 위에는 되는데 아래는 안됨
  //    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
  //      let text = message["text"] as! String
  //      testLabel.setText(text)
  //    }
}
