//
//  ScreenCoordinator.swift
//  Airplay Display
//
//  Created by jesse calkin on 2/1/16.
//  Copyright © 2016 jesse calkin. All rights reserved.
//

import UIKit

class ScreenCoordinator: NSObject {

    var showingSecondScreen: Bool {
        guard let secondWindow = secondWindow, let vc = secondWindow.rootViewController else { return false }
        return !vc.view.hidden
    }

    var secondWindow: UIWindow?

    override init() {
        super.init()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleScreenDidConnect:"), name: UIScreenDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleScreenDidDisconnect:"), name: UIScreenDidDisconnectNotification, object: nil)

        checkForExistingScreenAndInitializeIfPresent()
    }

    //MARK: - Screen Initialization

    func checkForExistingScreenAndInitializeIfPresent() {
        guard UIScreen.screens().count > 1, let secondScreen = UIScreen.screens().last else { return }
        print("📺✅ Found existing second screen")
        setupSecondScreen(secondScreen)
    }

    func setupSecondScreen(screen: UIScreen) {
        let screenBounds = screen.bounds

        secondWindow = UIWindow(frame: screenBounds)
        secondWindow?.screen = screen;

        let name = "Main"

        guard let initialVC = UIStoryboard(name: name, bundle: NSBundle.mainBundle()).instantiateInitialViewController() else {
            print("Unable to instantiate \(name) ViewController")
            return
        }

        initialVC.view.backgroundColor = UIColor.orangeColor()

        secondWindow?.rootViewController = initialVC
        secondWindow?.hidden = false;
    }

    //MARK: - Notification Handling

    func handleScreenDidConnect(notification: NSNotification) {
        guard let newScreen = notification.object as? UIScreen else {
            print("Received \(notification.name) but no UIScreen was found.")
            return
        }
        print("📺✅ \(notification.name)")
        setupSecondScreen(newScreen)
    }

    func handleScreenDidDisconnect(notification: NSNotification) {
        print("📺❌ \(notification.name)")

        if let secondWindow = secondWindow {
            secondWindow.hidden = true
        }

        secondWindow = nil
    }
}
