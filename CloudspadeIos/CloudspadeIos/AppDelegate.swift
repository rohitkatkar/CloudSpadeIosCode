/*
 Copyright (c) 2015-present, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Foundation
import UIKit
import MobileSync


class AppDelegate : UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var dataRows = [[String: Any]]()
    
    override init() {
        super.init()
        MobileSyncSDKManager.initializeSDK()
        
        
        AuthHelper.registerBlock(forCurrentUserChangeNotifications: {
            self.resetViewState {
               
                let accessTokens = UserAccountManager.shared.currentUserAccount?.credentials.accessToken
                let refreshTokens = UserAccountManager.shared.currentUserAccount?.credentials.refreshToken
                print("*******************************************************************")
                print("*******************************************************************")
                print("*******************************************************************")
                print("*******************************************************************")
                print("Access Tokens: " + accessTokens!)
                print("Refresh Tokens: " + refreshTokens!)
                print("*******************************************************************")
                print("*******************************************************************")
                print("*******************************************************************")
                print("*******************************************************************")
               
                
            
                
                self.setupRootViewController()
                
            }
        })
        
    }
    
    // MARK: - App delegate lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.initializeAppViewState()
        
        // If you wish to register for push notifications, uncomment the line below.  Note that,
        // if you want to receive push notifications from Salesforce, you will also need to
        // implement the application(application, didRegisterForRemoteNotificationsWithDeviceToken) method (below).
//        self.registerForRemotePushNotifications()

        //Uncomment the code below to see how you can customize the color, textcolor,
        //font and fontsize of the navigation bar
//        self.customizeLoginView()
        
        AuthHelper.loginIfRequired {
            
            // let accessTokens = UserAccountManager.shared.currentUserAccount?.credentials.accessToken
           //  let refreshTokens = UserAccountManager.shared.currentUserAccount?.credentials.refreshToken
             
         
        /*
            let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom

            // 2. check the idiom
            switch (deviceIdiom) {

            case .pad:
                print("iPad style UI")
            case .phone:
                print("*******************************************************************")
                print("*******************************************************************")
                print("*******************************************************************")
                print("iPhone and iPod touch style UI")
                print("*******************************************************************")
                print("*******************************************************************")
                print("*******************************************************************")
            case .tv:
                print("tvOS style UI")
            default:
                print("Unspecified UI idiom")
            }
            */
            
            // /v1/displayAccounts
            //https://aquagulf--sandbox.lightning.force.com/services/apexrest/Account
           // https://aquagulf--sandbox.lightning.force.com/services/apexrest/Account
           // request2.endpoint = "/services/apexrest/Account"
           // let request1 = RestRequest(method: .GET, serviceHostType: .instance,path: "",queryParams: nil)
           // request1.endpoint = "https://aquagulf--sandbox.lightning.force.com/services/apexrest/Account"
          
         //   let request3 =  RestRequest.customUrlRequest(with: RestRequest.Method.GET, baseURL: "aquagulf--sandbox.lightning.force.com", path: "/services/apexrest/Account", queryParams: nil)
            
            
            
            
           //aquagulf--sandbox.lightning.force.com/services/v1/displayAccounts
            
            
            
            
          //  let request4 = RestRequest(method: .GET, baseURL: "", path: "https://aquagulf--sandbox.lightning.force.com", queryParams: nil)
           let request4 = RestRequest(method: .GET, serviceHostType: .instance, path: "/services/apexrest/Account", queryParams: nil)
            
           // request4.baseURL = "aquagulf--sandbox.lightning.force.com"
            request4.endpoint = ""
            
      //  let request = RestClient.shared.request(forQuery: "Select Id, name, phone from Account limit 10", apiVersion: SFRestDefaultAPIVersion)
            
                   RestClient.shared.send(request: request4) { [weak self] (result) in
                       switch result {
                           case .success(let response):
                          
                               self?.handleSuccess(response: response, request: request4)
                           // self?.setupRootViewController()
                           case .failure(let error):
                            print("******************************************")
                            print("******************************************")
                            print("******************************************")
                           // print("request.baseURL"+request.baseURL)
                            print("failure")
                            print(" request   :  ")
                            print(request4)
                            print("******************************************")
                            print("******************************************")
                            print("******************************************")
                                   return
                                SalesforceLogger.d(RootViewController.self, message:"Error invoking: \(request4) , \(error)")
                       }
                   }
           
           self.setupRootViewController()
            
        }
        
        return true
    }
    
    func handleSuccess(response: RestResponse, request: RestRequest) {
           guard let jsonResponse  = try? response.asJson() as? [String:Any], let records = jsonResponse["attributes"] as? [[String:Any]]  else {
            print("******************************************")
            print("******************************************")
            print("******************************************")
           // print("request.baseURL"+request.baseURL)
            print("Success")
            print(" request   :  ")
            
            print(request)
            
            print(" base Url :")
            print(request.baseURL)
            print(" end point : ")
            print(request.endpoint)
            print(" Path :")
            print(request.path)
            print("Response")
            print(response.asString())
            print("******************************************")
            print("******************************************")
            print("******************************************")
            
            SalesforceLogger.d(RootViewController.self, message:"Empty Response for : \(request)")
         
                   return
           }
       /*
        print("******************************************")
        print("******************************************")
        print("******************************************")
       // print("request.baseURL"+request.baseURL)
        print("Success")
        print(" request   :  ")
        
        print(request)
        
        print(" base Url :")
        print(request.baseURL)
        print(" end point : ")
        print(request.endpoint)
        print(" Path :")
        print(request.path)
        print("Records")
        print(records)
        print("******************************************")
        print("******************************************")
        print("******************************************")
        */
        /*endpoint: /services/data
         method: GET
         path: /v49.0/query
         queryParams: {
           "q" : "Select Id, name, phone from Account limit 10"
         } */
        
           SalesforceLogger.d(type(of:self), message:"Invoked: \(request)")
           DispatchQueue.main.async {
              self.dataRows = records
          
            //  self.tableView.reloadData()
          }
       }
    
    func registerForRemotePushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    PushNotificationManager.sharedInstance().registerForRemoteNotifications()
                }
            } else {
                SalesforceLogger.d(AppDelegate.self, message: "Push notification authorization denied")
            }

            if let error = error {
                SalesforceLogger.e(AppDelegate.self, message: "Push notification authorization error: \(error)")
            }
        }
    }
    
    func customizeLoginView() {
        let loginViewConfig = SalesforceLoginViewControllerConfig()
        
        // Set showSettingsIcon to false if you want to hide the settings
        // icon on the nav bar
        loginViewConfig.showsSettingsIcon = false
        
        // Set showNavBar to false if you want to hide the top bar
        loginViewConfig.showsNavigationBar = false
        loginViewConfig.navigationBarColor = UIColor(red: 0.051, green: 0.765, blue: 0.733, alpha: 1.0)
        loginViewConfig.navigationTitleColor = UIColor.white
        loginViewConfig.navigationBarFont = UIFont(name: "Helvetica", size: 16.0)
        UserAccountManager.shared.loginViewControllerConfig = loginViewConfig
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Uncomment the code below to register your device token with the push notification manager
//        didRegisterForRemoteNotifications(deviceToken)
    }
    
    func didRegisterForRemoteNotifications(_ deviceToken: Data) {
        PushNotificationManager.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
        if let _ = UserAccountManager.shared.currentUserAccount?.credentials.accessToken {
            PushNotificationManager.sharedInstance().registerForSalesforceNotifications { (result) in
                switch (result) {
                    case  .success(let successFlag):
                        SalesforceLogger.d(AppDelegate.self, message: "Registration for Salesforce notifications status:  \(successFlag)")
                    case .failure(let error):
                        SalesforceLogger.e(AppDelegate.self, message: "Registration for Salesforce notifications failed \(error)")
                }
            }
        }
    }    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error ) {
        // Respond to any push notification registration errors here.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey 
 : Any] = [:]) -> Bool {
        // Uncomment following block to enable IDP Login flow
//        return self.enableIDPLoginFlowForURL(url, options: options)
        return false;
    }
    
    func enableIDPLoginFlowForURL(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return  UserAccountManager.shared.handleIdentityProviderResponse(from: url, with: options)
    }
    
    // MARK: - Private methods
    func initializeAppViewState() {
        if (!Thread.isMainThread) {
            DispatchQueue.main.async {
                self.initializeAppViewState()
            }
            return
        }
        
        self.window?.rootViewController = InitialViewController(nibName: nil, bundle: nil)
        self.window?.makeKeyAndVisible()
    }
    
    func setupRootViewController() {
      // let rootVC = RootViewController(nibName: nil, bundle: nil)
    // let rootVC = ExecutiveViewController(nibName: nil, bundle: nil)
    //  let navVC = UINavigationController(rootViewController: rootVC)
    //   self.window?.rootViewController = navVC
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Executive", bundle: nil)
        let exampleViewController: BaseViewController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewId") as! BaseViewController
        //et navi =  UINavigationController.init(rootViewController: exampleViewController)
          
         self.window?.rootViewController = exampleViewController
         exampleViewController.navigationController?.navigationBar.backgroundColor = UIColor.systemTeal
       // self.window?.rootViewController = navi
        self.window?.makeKeyAndVisible()
        
        //   navi.navigationBar.backgroundColor = UIColor.systemTeal
        // let navigationController =  UINavigationController(rootViewController: exampleViewController)
        
       //  exampleViewController.present(navigationController, animated: true, completion: nil)
      //  self.window?.rootViewController?.present(navigationController, animated: true, completion: nil)
         //  self.window?.rootViewController?.presentedViewController
         //  var vc: ExecutiveViewController = mainStoryboard.instantiateViewController(withIdentifier: "ExecutiveId") as! ExecutiveViewController
       // let navigationController = UINavigationController(rootViewController: vc)
        //   .presentViewController(navigationController, animated: true, completion: nil)
        
    }
    /*
     
     self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];

         UIViewController *viewController = // determine the initial view controller here and instantiate it with [storyboard instantiateViewControllerWithIdentifier:<storyboard id>];

         self.window.rootViewController = viewController;
         [self.window makeKeyAndVisible];

     
     */
    func resetViewState(_ postResetBlock: @escaping () -> ()) {
        if let rootViewController = self.window?.rootViewController {
            if let _ = rootViewController.presentedViewController {
                rootViewController.dismiss(animated: false, completion: postResetBlock)
                return
            }
        }
        postResetBlock()
    }
    
    
}
