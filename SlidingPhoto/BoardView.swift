//
//  BoardView.swift
//  SlidingPhoto
//
//  Created by John Park on 2022-03-16.
//

import UIKit

class BoardView: UIView {
    func test() {
        let button = self.viewWithTag(1) as! UIButton

        button.setTitle(String(1), for: UIControl.State.normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
    
}
