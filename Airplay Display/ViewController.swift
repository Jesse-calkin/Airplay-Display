//
//  ViewController.swift
//  Airplay Display
//
//  Created by jesse calkin on 2/1/16.
//  Copyright © 2016 jesse calkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let screenCoordinator = (UIApplication.sharedApplication().delegate as! AppDelegate).screenCoordinator

    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("colorPicked:"), name: ColorPickerDidPickNotification, object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if screenCoordinator.showingSecondScreen && self != screenCoordinator.secondWindow?.rootViewController {
            performSegueWithIdentifier("ShowColorPickerSegue", sender: self)
        }
    }

    //MARK: - Internal

    func colorPicked(notification: NSNotification) {
        guard let color = notification.object as? UIColor else { return }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.backgroundColor = color
            }) { (finished) -> Void in
                if finished {
//                    print("Changed color!")
                }
        }
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {}
}
