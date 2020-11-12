//
//  MenuViewController.swift
//  CloudspadeIos
//
//  Created by GNS065 on 20/09/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//

import UIKit

import SalesforceSDKCore
//#import "Reachability.h";

enum MenuType:Int{
    case home
    case camera
    case profile
}

class MenuViewController: UIViewController {
    var dataRows = [[String: Any]]()
    private weak var button: UIButton!
    var mainViewController: BaseViewController?
   // private var headerPart
    
    
    @IBOutlet  var tableview: UITableView!
    
    var heightNavBar1 = CGFloat()
 
   
    var didTapMenuType: ((MenuType) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        setHeaderView()
        getData()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Executive", bundle: nil)
        mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewId") as? BaseViewController
        
       // addRightBarButtonItems()
       // addLeftBarButtonItems()
        self.extendedLayoutIncludesOpaqueBars = true
     //   tableview.topAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
        navigationController?.navigationBar.tintColor = UIColor.systemTeal
        navigationController?.isNavigationBarHidden = false
        
       //  addRightBarButtonItems()
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
     
        UserAccountManager.shared.logout()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0) {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        if Reachability.isConnectedToNetwork() != true{
            self.notInternetDetected()
        }
      
     }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    func getData(){
         
        let request = RestClient.shared.request(forQuery: "Select Id, name, phone from Account limit 10", apiVersion: SFRestDefaultAPIVersion)
        
       
        if Reachability.isConnectedToNetwork() == true{
        LoaderController.sharedInstance.showLoader()
        }
                 RestClient.shared.send(request: request) { [weak self] (result) in
                     switch result {
                         case .success(let response):
                        self?.handleSuccess(response: response, request: request)
                         // self?.setupRootViewController()
                         case .failure(let error):
                           
                             
                              SalesforceLogger.d(RootViewController.self, message:"Error invoking: \(request) , \(error)")
                     }
                 }
    }
    func handleSuccess(response: RestResponse, request: RestRequest) {
           guard let jsonResponse  = try? response.asJson() as? [String:Any], let records = jsonResponse["records"] as? [[String:Any]]  else {
                   SalesforceLogger.d(RootViewController.self, message:"Empty Response for : \(request)")
                   return
           }
        
         let accessTokens = UserAccountManager.shared.currentUserAccount?.credentials.accessToken
         let refreshTokens = UserAccountManager.shared.currentUserAccount?.credentials.refreshToken
        
           SalesforceLogger.d(type(of:self), message:"Invoked: \(request)")
           DispatchQueue.main.async {
              self.dataRows = records
            LoaderController.sharedInstance.removeLoader()
            self.tableview.reloadData()
 
            //  self.tableView.reloadData()
          }
       }
    
    func notInternetDetected(){
        
           let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
           let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
          // let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

           controller.addAction(ok)
          // controller.addAction(cancel)

        self.present(controller, animated: true, completion: nil)
    }
    
    func addRightBarButtonItems()
    {
        let btnRefresh = UIButton.init(type: .custom)
        btnRefresh.setImage(UIImage(named: "refreshimages"), for: .normal)
     
        let filterButton = UIButton.init(type: .custom)
        filterButton.setImage(UIImage(named: "filterPage"), for: .normal)
        filterButton.addTarget(self, action: #selector(ExecutiveViewController.didTapFilterButton), for: .touchUpInside)
        
        let stackview = UIStackView.init(arrangedSubviews: [btnRefresh,filterButton])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 4
    
        let rightBarButton = UIBarButtonItem(customView: stackview)
       let currentHeight = rightBarButton.customView?.heightAnchor.constraint(equalToConstant: 35)
        currentHeight?.isActive = true
        let currentWidth = rightBarButton.customView?.widthAnchor.constraint(equalToConstant: 90)
        currentWidth?.isActive = true
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    @IBAction func logOutButtonClicked(_ sender: Any) {
    }
    private func setHeaderView(){
      
        var headerPart: MenuHeaderView  = {
            let view = MenuHeaderView(frame: CGRect.zero)
            view.backgroundColor = UIColor(named: "light_gray_color")
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()

        headerPart.descriptionButton.setTitle(UserAccountManager.shared.currentUserAccount?.idData.displayName, for: .normal)
        
        let adminImage = UserAccountManager.shared.currentUserAccount?.photo
        
        headerPart.adminImageView.image = adminImage
        
        headerPart.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 10)
        headerPart.adminImageView.widthAnchor.constraint(equalTo: headerPart.widthAnchor, multiplier: 0.2).isActive = true
        headerPart.adminImageView.heightAnchor.constraint(equalTo: headerPart.widthAnchor, multiplier: 0.15).isActive = true
        headerPart.adminImageView.topAnchor.constraint(equalTo: headerPart.topAnchor, constant: 50)
        headerPart.adminImageView.bottomAnchor.constraint(equalTo: headerPart.bottomAnchor, constant: 50)
        /*
        let menuImage = UIImage(named:"menuimages")
        let buttonMenu = UIButton()
      //  buttonMenu.setImage(menuImage, for: .normal)
        
        buttonMenu.tintColor = UIColor.systemTeal
        buttonMenu.setBackgroundImage(menuImage, for: .normal)
        
        buttonMenu.addTarget(self, action: #selector(ExecutiveViewController.didTapMenu), for: .touchUpInside)
        
        buttonMenu.isEnabled = false
        let image = UIImage(named:"reportimages")
        let buttonImage = UIButton()    
        buttonImage.setImage(image, for: .normal)
        buttonImage.addTarget(self, action:#selector(MenuViewController.didTapMenu), for: .touchUpInside)
        buttonImage.contentMode = UIView.ContentMode.scaleAspectFill

       // headerPart.stackButtonView = UIStackView.init(arrangedSubviews: [buttonMenu, buttonImage])
        headerPart.stackButtonView.addArrangedSubview(buttonMenu)
        headerPart.stackButtonView.addArrangedSubview(buttonImage)
         */
        headerPart.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true

        
        self.view.addSubview(headerPart);
        tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
    
    }
    @IBAction func didTapMenu(_ sender: UIButton!) {
    
      
    }
    @IBAction func buttonClicked(sender: UIButton!){
       
    }
    private func setUpNavigationBarItems(){
        
        let width = self.view.frame.width
              let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 70))
        
        self.view.addSubview(navigationBar);
   
        let navigationItem = UINavigationItem(title: "Admin Name Here")
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(selectorX))
        
        let logoButton: UIImage = UIImage(named:"user_60")!
        
        let followButton = UIButton(type: .system)
        followButton.setImage(logoButton.withRenderingMode(.alwaysOriginal), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
         navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        
        let firstButton: UIImage = UIImage(named:"expense_report_60")!
        let menuButton = UIButton(type: .system)
        menuButton.backgroundColor = UIColor.systemTeal
        menuButton.setImage(firstButton.withRenderingMode(.alwaysOriginal), for: .normal)
        menuButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
        
       
        let secondButton: UIImage = UIImage(named:"rows_60")!
    
        let summaryButton = UIButton(type: .system)
        
        summaryButton.setImage(secondButton.withRenderingMode(.alwaysOriginal), for: .normal)
        summaryButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
       // navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
       navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: menuButton),UIBarButtonItem(customView: summaryButton)]
  
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(image: secondButton, style: .plain, target: self, action: #selector(selectorX)))
        
        items.append(UIBarButtonItem(image: secondButton, style: .plain, target: self, action: #selector(selectorX)))
         
       // navigationItem.rightBarButtonItems = items
        
        
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
         
        
        let viewFN = UIView(frame:  CGRect(x: 0, y: 0, width: 4, height: 4))
        viewFN.backgroundColor = UIColor.yellow
            let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
        button1.setImage(UIImage(named: "rows_60"), for: UIControl.State.normal)
        button1.setTitle("one", for: .normal)

        button1.addTarget(self, action: #selector(self.didTapOnRightButton), for: UIControl.Event.touchUpInside)

        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
        button2.setImage(UIImage(named: "expense_report_60"), for: UIControl.State.normal)
        button2.setTitle("two", for: .normal)
        button2.addTarget(self, action: #selector(self.didTapOnRightButton), for: UIControl.Event.touchUpInside)
        stackView.addSubview(button1)
        stackView.addSubview(button2)
 
        navigationBar.setItems([navigationItem], animated: false)
    }
    @objc func selectorX() { }
    
    @objc func didTapOnRightButton(){
   
    }
    
 

}

extension MenuViewController:UITableViewDelegate{
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You Table View")
       
        guard let menuType = MenuType(rawValue: indexPath.row) else{return}
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
         }
           
    }
 */
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
           // self.present(mainViewController!, animated: true, completion: nil)
            let parentViewConrtoller = self.parent as! BaseViewController
            parentViewConrtoller.activateButtons()
             willMove(toParent: BaseViewController())
             view.removeFromSuperview()
              removeFromParent()
 
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50;//Choose your custom row height
        }
 
}

extension MenuViewController:  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return dataRows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "MenuViewCell",for:indexPath)as! MenuViewCell
     
        let obj = dataRows[indexPath.row]
     
        cell.menuLabel.text = obj["Name"] as? String
   
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
        }

    
 
   
}
