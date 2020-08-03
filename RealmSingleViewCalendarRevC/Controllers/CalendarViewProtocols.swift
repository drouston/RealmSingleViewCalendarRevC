//
//  CalendarViewController.swift
//  RealmSingleViewCalendarRevC
//
//  Created by Drew Collier on 8/3/20.
//  Copyright © 2020 Drew Collier. All rights reserved.
//

import UIKit
import JTAppleCalendar
import RealmSwift

extension ViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        print("configureCalendar")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2020 01 01")!
        let endDate = formatter.date(from: "2020 12 31")!

        if numberOfRows == 6 { 
            return ConfigurationParameters(startDate: startDate,
                                           endDate: endDate)
        } else {
            return ConfigurationParameters(startDate: startDate,
                                           endDate: endDate,
                                           numberOfRows: numberOfRows,
                                           generateInDates: .forFirstMonthOnly,
                                           generateOutDates: .off,
                                           hasStrictBoundaries: false)
        }
    }
}

extension ViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        //print("cellForItemAt: \(indexPath)")
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
        
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell  else { return }
        cell.scheduleAnimationView.layer.sublayers?.removeAll()
        configureCell(cell: cell, cellState: cellState)
        handleAllDayViews(cell: cell, cellState: cellState)
        handleAnimations(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        //print("didScrolltoSegmentWith visibleDates: \(visibleDates)")
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let firstDay = visibleDates.monthDates.first?.date
        let headerDate = formatter.string(from: firstDay!)
        searchController.searchBar.placeholder = headerDate
        if numberOfRows == 1 { } else {
            adjustCalendarViewHeight()
        }
        
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        
        guard let cell = cell as? DateCell  else { return }
        configureCell(cell: cell, cellState: cellState)
        selectedDate = cellState.date
        timelinePagerView.state?.move(to: cellState.date)
        tableView.reloadData()
    }

    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell  else { return }
        configureCell(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        
        if cellState.isSelected == true {
            toggle(UITapGestureRecognizer(), cellState: cellState)
        }
        return true
    }
}
