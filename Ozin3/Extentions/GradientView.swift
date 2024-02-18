//
//  GradientLabel.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 10.02.2024.
//

import UIKit
import SnapKit

//class GradientView: UIView {
//    
//    private let gradientLayer = CAGradientLayer()
//
//    // Инициализация градиента
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupGradient()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupGradient()
//    }
//    
//    private func setupGradient() {
//        // Определите цвета градиента
//        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
//        // Определите направление градиента
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
//        // Добавьте градиентный слой в массив слоев view
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
//    
//    // Убедитесь, что градиентный слой обновляется при изменении размера view
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = bounds
//    }
//}
//@IBDesignable
//public class GradientView: UIView {
//   var startColor:   UIColor = .black { didSet { updateColors() }}
//     var endColor:     UIColor = .white { didSet { updateColors() }}
//     var startLocation: Double =   0.05 { didSet { updateLocations() }}
// var endLocation:   Double =   0.95 { didSet { updateLocations() }}
//     var horizontalMode:  Bool =  false { didSet { updatePoints() }}
//     var diagonalMode:    Bool =  false { didSet { updatePoints() }}
//    
//    override public class var layerClass: AnyClass { CAGradientLayer.self }
//    
//    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
//    
//    func updatePoints() {
//        if horizontalMode {
//            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
//            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
//        } else {
//            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
//            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
//        }
//    }
//    func updateLocations() {
//        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
//    }
//    func updateColors() {
//        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
//    }
//    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        updatePoints()
//        updateLocations()
//        updateColors()
//    }
//}
//extension UIColor {
//    static let gradientStart = UIColor(red: 156/255, green: 163/255, blue: 175/255, alpha: 0)
//    static let gradientEnd = UIColor(red: 17/255, green: 24/255, blue: 39/255, alpha: 0)
//    }
//
//class GradientLabel: UILabel {
//    override func drawText(in rect: CGRect) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [UIColor.gradientStart.cgColor, UIColor.gradientEnd.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
//        
//        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        super.drawText(in: rect)
//        
//        // Получаем маску из текущего контекста
//        guard let mask = context.makeImage() else { return }
//        
//        // Применяем маску к градиентному слою
//        gradientLayer.mask = CALayer()
//        gradientLayer.mask?.contents = mask
//        
//        // Рисуем градиентный слой на текущем контексте
//        gradientLayer.render(in: context)
//        
//        // Извлекаем изображение из контекста
//        guard let gradientTextImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
//        UIGraphicsEndImageContext()
//        
//        // Отображаем изображение с градиентным текстом
//        gradientTextImage.draw(in: rect)
//    }
//}
@IBDesignable
public class GradientView: UIView {
    @IBInspectable var startColor:   UIColor = .red { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}
