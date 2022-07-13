//
//  CalculatingHeightOfText.swift
//  Lite_iTunes
//
//  Created by Eduard on 31.08.2021.
//

import UIKit

class CalculatingHeightOfText {

    func findHeightForText(text: String, havingWidth widthValue: CGFloat, andFont font: UIFont) -> CGSize {
        var size = CGSize.zero
            if text.isEmpty == false {
                let frame = text.boundingRect(with:CGSize(width: widthValue, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
                size = CGSize(width: frame.size.width, height: ceil(frame.size.height))
            }
            return size
    }
}
