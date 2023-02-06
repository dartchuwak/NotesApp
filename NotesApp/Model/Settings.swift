//
//  Settings.swift
//  NotesApp
//
//  Created by Evgenii Mikhailov on 03.02.2023.
//

import Foundation
import UIKit



class Settings {
    static let shared: Settings = .init()
    var notesColor: String?
    var textFont: UIFont?
    var titleFont : UIFont?
}


var pickerData = [Int]()


func populatePickerData(){
    for i in 20...100 {
         pickerData.append(i)
    }
}

