//
//  resultView.swift
//  Holmusk
//
//  Created by Vinupriya on 7/30/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit

@IBDesignable
class resultView: UIView {

    @IBOutlet weak var lblResult: UILabel!
    
    // MARK: IBInspectable
    @IBInspectable var color: UIColor = UIColor.whiteColor()

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
