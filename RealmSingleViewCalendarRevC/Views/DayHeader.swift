//
//  DayHeader.swift
//  RealmSingleViewCalendar
//
//  Created by Drew Collier on 5/7/20.
//  Copyright © 2020 Drew Collier. All rights reserved.
//

import Foundation
import UIKit

class DayHeader {
    
    var monthLabel = UILabel()
    let monLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textAlignment = .center
        label.text = "Sun"
        return label
    }()
    let tueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textAlignment = .center
        label.text = "Mon"
        return label
    }()
    let wedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textAlignment = .center
        label.text = "Tue"
        return label
    }()
    let thuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textAlignment = .center
        label.text = "Wed"
        return label
    }()
    let friLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textAlignment = .center
        label.text = "Thu"
        return label
    }()
    let satLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textAlignment = .center
        label.text = "Fri"
        return label
    }()
    let sunLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textAlignment = .center
        label.text = "Sat"
        return label
    }()
    //let dayLabelFrame = CGRect(x: 0, y: 0, width: 10, height: 20)
    
    lazy var dayStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [monLabel, tueLabel, wedLabel, thuLabel, friLabel, satLabel, sunLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.backgroundColor = .lightGray
        stack.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return stack
    }()
}
