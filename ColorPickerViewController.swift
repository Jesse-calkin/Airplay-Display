//
//  ColorPickerViewController.swift
//  Airplay Display
//
//  Created by jesse calkin on 2/1/16.
//  Copyright © 2016 jesse calkin. All rights reserved.
//

import UIKit

let ColorPickerDidPickNotification = "ColorPickerDidPickNotification"

class ColorPickerViewController: UIViewController {

    let screenCoordinator = (UIApplication.sharedApplication().delegate as! AppDelegate).screenCoordinator

    @IBAction func pickColor(sender: UIButton) {
        guard let color = sender.backgroundColor else { return }

        NSNotificationCenter.defaultCenter().postNotificationName(ColorPickerDidPickNotification, object: color)

        if !screenCoordinator.showingSecondScreen {
            performSegueWithIdentifier("UnwindSegue", sender: self) }
    }
}
