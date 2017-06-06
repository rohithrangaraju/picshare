//  ParseStarterProject-Swift
//
//  Created by Rohith on 05/06/17.
//  Copyright © 2017 Parse. All rights reserved.
//
import UIKit

import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        
        let parseConfiguration = ParseClientConfiguration(block: { (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = "0c355ebe0f9abff257028fd5723653dcc0be0090"
            ParseMutableClientConfiguration.clientKey = "ad7be9172724acd035c2e72ad37168d8bfdb8e28"
            ParseMutableClientConfiguration.server =  "http://ec2-34-209-238-84.us-west-2.compute.amazonaws.com:80/parse"
        })
        
        Parse.initialize(with: parseConfiguration)


        

        let defaultACL = PFACL();

       
        defaultACL.getPublicReadAccess = true

        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)

        if application.applicationState != UIApplicationState.background {
            
        }

        return true
    }

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation.setDeviceTokenFrom(deviceToken)
        installation.saveInBackground()

        PFPush.subscribeToChannel(inBackground: "") { (succeeded, error) in // (succeeded: Bool, error: NSError?) is now (succeeded, error)
            if succeeded {
                print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n");
            } else {
                print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n", error)
            }
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handle(userInfo)
        if application.applicationState == UIApplicationState.inactive {
            PFAnalytics.trackAppOpened(withRemoteNotificationPayload: userInfo)
        }
    }

    
}
