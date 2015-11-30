//
//  ViewController.swift
//  ASDK_CollectionCellNode-TableNode-crash
//
//  Created by Tom King on 11/30/15.
//  Copyright © 2015 iZi Mobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var button: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show table", forState: .Normal)
        button.addTarget(self, action: "showTable:", forControlEvents: .TouchUpInside)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        view.addSubview(button)
        
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44))
    }
    
    func showTable(sender: UIButton)
    {
        presentViewController(UINavigationController(rootViewController: ModalViewController()), animated: true, completion: nil)
    }
}
