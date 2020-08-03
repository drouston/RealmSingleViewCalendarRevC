//
//  DateCell.swift
//  SingleViewPrgm
//
//  Created by Drew Collier on 3/24/20.
//  Copyright © 2020 Drew Collier. All rights reserved.
//

import UIKit
import EventKit
import JTAppleCalendar
import RealmSwift

class DateCell: JTACDayCell {
    
    let dateLabel = UILabel()
    let scheduleAnimationView = UIView()
    let allDayEventIndicator = UIView()
    let firstAllDayEventIndicator = UIView()
    let secondAllDayEventIndicator = UIView()
    let thirdAllDayEventIndicator = UIView()
    var eventIntervals: [DateInterval] = []
    var event: EKEvent!
    
    var circularPath = UIBezierPath()
    var pathCenter = CGPoint()
    var outerRadius = CGFloat()
    var middleRadius = CGFloat()
    var innerRadius = CGFloat()
    let outerTrackLayer = CAShapeLayer()
    let middleTrackLayer = CAShapeLayer()
    let innerTrackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        firstAllDayEventIndicator.isHidden = true
        secondAllDayEventIndicator.isHidden = true
        thirdAllDayEventIndicator.isHidden = true
        layoutSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }
    
     //MARK: layoutSubviews()
    override func layoutSubviews() {
        
        let cellWidth = contentView.frame.width
        let cellHeight = contentView.frame.height
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        dateLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateLabel.clipsToBounds = true
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: cellWidth/2-12).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -cellHeight/2+15).isActive = true
        scheduleAnimationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scheduleAnimationView)
        scheduleAnimationView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scheduleAnimationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        scheduleAnimationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        scheduleAnimationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        contentView.addSubview(firstAllDayEventIndicator)
        firstAllDayEventIndicator.translatesAutoresizingMaskIntoConstraints = false
        firstAllDayEventIndicator.heightAnchor.constraint(equalToConstant: 3).isActive = true
        firstAllDayEventIndicator.widthAnchor.constraint(equalToConstant: (contentView.frame.width - 2)).isActive = true
        firstAllDayEventIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        firstAllDayEventIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        contentView.addSubview(secondAllDayEventIndicator)
        secondAllDayEventIndicator.translatesAutoresizingMaskIntoConstraints = false
        secondAllDayEventIndicator.heightAnchor.constraint(equalToConstant: 3).isActive = true
        secondAllDayEventIndicator.widthAnchor.constraint(equalToConstant: (contentView.frame.width - 2)).isActive = true
        secondAllDayEventIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        secondAllDayEventIndicator.bottomAnchor.constraint(equalTo: firstAllDayEventIndicator.topAnchor, constant: -2).isActive = true
        contentView.addSubview(thirdAllDayEventIndicator)
        thirdAllDayEventIndicator.translatesAutoresizingMaskIntoConstraints = false
        thirdAllDayEventIndicator.heightAnchor.constraint(equalToConstant: 3).isActive = true
        thirdAllDayEventIndicator.widthAnchor.constraint(equalToConstant: (contentView.frame.width - 2)).isActive = true
        thirdAllDayEventIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        thirdAllDayEventIndicator.bottomAnchor.constraint(equalTo: secondAllDayEventIndicator.topAnchor, constant: -2).isActive = true
        
        pathCenter = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        outerRadius = self.frame.width / 2 - 4
        outerTrackLayer.lineWidth = 6
        outerTrackLayer.lineCap = CAShapeLayerLineCap.round
        outerTrackLayer.fillColor = UIColor.clear.cgColor
        outerTrackLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        circularPath = UIBezierPath(arcCenter: pathCenter, radius: outerRadius, startAngle: 0, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        outerTrackLayer.path = circularPath.cgPath
        
        middleRadius = scheduleAnimationView.layer.frame.width / 2 - 11//self.frame.width / 2 - 11
        middleTrackLayer.lineWidth = 6
        middleTrackLayer.lineCap = CAShapeLayerLineCap.round
        middleTrackLayer.fillColor = UIColor.clear.cgColor
        middleTrackLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        circularPath = UIBezierPath(arcCenter: pathCenter, radius: middleRadius, startAngle: 0, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        middleTrackLayer.path = circularPath.cgPath
        
        innerRadius = self.frame.width / 2 - 18
        innerTrackLayer.lineWidth = 6
        innerTrackLayer.lineCap = CAShapeLayerLineCap.round
        innerTrackLayer.fillColor = UIColor.clear.cgColor
        innerTrackLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        circularPath = UIBezierPath(arcCenter: pathCenter, radius: innerRadius, startAngle: 0, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        innerTrackLayer.path = circularPath.cgPath
        self.layoutIfNeeded()
    }
    
    func allDay(events: Results<EventItem>) {
        
        for event in events {
            var calendarColor = UIColor()
            if event.groupCalendars.count > 0 {
                calendarColor = UIColor(hexString: event.groupCalendars[0].color) ?? UIColor.black
            } else {
                calendarColor = UIColor.white
            }
            if firstAllDayEventIndicator.isHidden == false, secondAllDayEventIndicator.isHidden == false, thirdAllDayEventIndicator.isHidden == false {
            } else if firstAllDayEventIndicator.isHidden == false, secondAllDayEventIndicator.isHidden == false {
                thirdAllDayEventIndicator.isHidden = false
                thirdAllDayEventIndicator.backgroundColor = calendarColor
            } else if firstAllDayEventIndicator.isHidden == false {
                secondAllDayEventIndicator.isHidden = false
                secondAllDayEventIndicator.backgroundColor = calendarColor
            } else {
                firstAllDayEventIndicator.isHidden = false
                firstAllDayEventIndicator.backgroundColor = calendarColor
            }
        }
    }
    
     //MARK: cellGraphics()
    func cellGraphics(date: Date, events: Results<EventItem>, cell: DateCell) {
        //print("cellGraphics date: ", date)//\nevents: \(events)")
        let midnight = Calendar.current.startOfDay(for: date)
        
        for event in events {
            var radius = CGFloat()
            var startHour: TimeInterval = event.startDate.timeIntervalSince(midnight)
            var endHour: TimeInterval = event.endDate.timeIntervalSince(midnight)
            var calendar = ""
            
             //When calendar picker is available, set these strings to the top three calendars from picker array
             //Determine which 3/4 arc trackLayer for the calendar/event and add layer to scheduleAnimationView sublayers. Layer must be added and removed, .isHidden does not provide desired results
            
            if event.groupCalendars[0].calendarTitle != "" {
                calendar = event.groupCalendars[0].calendarTitle
            } else {
                print("No groupCalendar title")
            }
            if calendar == "Travel" {
                //print("outerRadius")
                radius = outerRadius
                self.scheduleAnimationView.layer.addSublayer(outerTrackLayer)
            } else if calendar == "Drew Collier" {
                //print("middleRadius")
                radius = middleRadius
                self.scheduleAnimationView.layer.addSublayer(middleTrackLayer)
            } else if calendar == "Groupston" {
                //print("innerRadius")
                radius = innerRadius
                self.scheduleAnimationView.layer.addSublayer(innerTrackLayer)
            } else {
                print("/nError: trackLayer and radius not set: \n\(cell) \n\(event)")
                print("calendar: \(calendar)")
            }
            
             //Animation angles will need to correlate to start and end hours. Animations cannot occur outside of 3/4 arc trackLayer.
            if startHour < 21600 {
                startHour = 0
            } else {
                startHour = startHour - 21600
            }
            
            if endHour < 21600 {
                endHour = 64800
            } else if endHour > 86400 {
                endHour = 64800
            } else {
                endHour = endHour - 21600
            }
            
            let strokeLayer = CAShapeLayer()
            var startAngle = CGFloat()
            var endAngle = CGFloat()
            
            startAngle = CGFloat((startHour/64800) * 1.5 * .pi)
            endAngle = CGFloat((endHour/64800) * 1.5 * .pi)
            circularPath = UIBezierPath(arcCenter: pathCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            //print("pathCenter: ", pathCenter)
            self.scheduleAnimationView.layer.addSublayer(strokeLayer)
            strokeLayer.path = circularPath.cgPath
            
            if event.groupCalendars.count > 0 {
                strokeLayer.strokeColor = UIColor(hexString: event.groupCalendars[0].color)?.cgColor
            } else {
                strokeLayer.strokeColor = UIColor.black.cgColor
            }
            
            strokeLayer.lineWidth = 6
            strokeLayer.lineCap = CAShapeLayerLineCap.round
            strokeLayer.strokeEnd = 0
            strokeLayer.fillColor = UIColor.clear.cgColor
            strokeLayer.name = event.eventId
            
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.toValue = 1
            basicAnimation.duration = 1
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
            strokeLayer.add(basicAnimation, forKey: strokeLayer.name)
            
        }
    }
}

