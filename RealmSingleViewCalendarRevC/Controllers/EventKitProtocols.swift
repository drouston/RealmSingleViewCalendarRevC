//
//  EventKitDelegate.swift
//  RealmSingleViewCalendarRevC
//
//  Created by Drew Collier on 7/31/20.
//  Copyright © 2020 Drew Collier. All rights reserved.
//

import Foundation
import EventKit
import EventKitUI

extension ViewController: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        print("eventView didCompleteWith")
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        print("eventEditView didCompleteWith")
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
