//
//  UILabel+Extentions.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 27.02.2024.
//


import UIKit

extension UILabel {
    var maxNumberOfLines: Int {
            let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
            let text = self.text ?? ""
            let textHeight = sizeThatFits(maxSize).height
         //   let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font!], context: nil).height
            let lineHeight = font.lineHeight
            return Int(ceil(textHeight / lineHeight))
        }
}

