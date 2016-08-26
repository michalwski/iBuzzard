//
//  AppDelegate.swift
//  iBuzzard
//
//  Created by Krzysztof Profic on 26.08.2016.
//  Copyright © 2016 Trifork GmbH. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let streamURL = NSURL(string: "https://tungsten.aaplimg.com/VOD/bipbop_adv_example_v2/master.m3u8")!
    //"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //handleAPN([:])
        
        
        if let notification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [String: AnyObject] {
            let aps = notification["aps"] as! [String: AnyObject]
            handleAPN(aps)
            return true
        }
        
        registerForPushNotifications(application)
        
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        let tgr = UITapGestureRecognizer(target: self, action: #selector(AppDelegate.playStream))
        window?.addGestureRecognizer(tgr)
        
        playStream()
        return true
    }
    
    func registerForPushNotifications(application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Badge, .Sound, .Alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }

    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("Device Token:", tokenString)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register:", error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        let aps = userInfo["aps"] as! [String: AnyObject]
        handleAPN(aps)
    }
    
    func handleAPN(aps: [String: AnyObject]) {
        print("received remote notif \(aps)")
        
        
        playStream()
    }
    
    func sendToken(token: String) {
        let deviceID = "2af328b8d5e70039e858a99a2495210d98fb48563211d8b14a576cda6af9cd19"
        
    }
    
    func playStream() {
        let player = AVPlayer(URL: streamURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        
        window!.rootViewController?.presentViewController(playerViewController, animated: true, completion: { 
            playerViewController.player!.play()
        })
    }
}

