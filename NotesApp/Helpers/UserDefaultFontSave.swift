//
//  UserDefaultFontSave.swift
//  NotesApp
//
//  Created by Evgenii Mikhailov on 06.02.2023.
//

import Foundation
import UIKit

extension UserDefaults {

    func set(font : UIFont, forKey key : String)
    {
        let fontName = font.fontName
        let fontSize = font.pointSize
        self.set(fontName, forKey: key + "_name")
        self.set(Float(fontSize), forKey: key + "_size")
    }

    func font(forKey key : String) -> UIFont?
    {
        guard let fontName = string(forKey: key + "_name") else { return nil }
        let fontSize = float(forKey: key + "_size")
        if fontSize == 0.0 { return nil }
        return UIFont(name: fontName, size: CGFloat(fontSize))
    }
}
