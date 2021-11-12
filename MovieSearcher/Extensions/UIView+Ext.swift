//
//  UIView+Anchor.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import UIKit

extension UIView {
    
    // Top Anchor
      var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
          return self.safeAreaLayoutGuide.topAnchor
        } else {
          return self.topAnchor
        }
      }

      // Bottom Anchor
      var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
          return self.safeAreaLayoutGuide.bottomAnchor
        } else {
          return self.bottomAnchor
        }
      }

      // Left Anchor
      var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
          return self.safeAreaLayoutGuide.leadingAnchor
        } else {
          return self.leadingAnchor
        }
      }

      // Right Anchor
      var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
          return self.safeAreaLayoutGuide.trailingAnchor
        } else {
          return self.trailingAnchor
        }
      }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
