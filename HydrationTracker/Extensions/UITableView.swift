//
//  UITableView.swift
//  AllInOne
//
//  Created by Sneha on 05/04/18.
//  Copyright © 2018 Ecsion. All rights reserved.
//

//import Foundation
import UIKit

public extension UITableView {
  
  func registerCellClass(_ cellClass: AnyClass) {
    let identifier = String.className(cellClass)
    self.register(cellClass, forCellReuseIdentifier: identifier)
  }
  
  func registerCellNib(_ cellClass: AnyClass) {
    let identifier = String.className(cellClass)
    let nib = UINib(nibName: identifier, bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
  
  func registerHeaderFooterViewClass(_ viewClass: AnyClass) {
    let identifier = String.className(viewClass)
    self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
  }
  
  func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
    let identifier = String.className(viewClass)
    let nib = UINib(nibName: identifier, bundle: nil)
    self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
  }
    
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
    }
    
    func scrollToHeader() {
        self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    
    func removeHeaderPadding(){
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        }
    }
}


extension UITableView {

    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }

    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                     let indexPath = IndexPath(row: 0, section: 0)
                     self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top,bottom
    }
}


