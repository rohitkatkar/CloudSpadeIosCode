//
//  ExecutiveViewController.swift
//  CloudspadeIos
//
//  Created by GNS065 on 15/09/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//

import Foundation

import UIKit
import SalesforceSDKCore

class ExecutiveViewController : UIViewController {
    @IBOutlet var tableview:UITableView!
    @IBOutlet var navItem:UINavigationItem!
    @IBOutlet var reportImage: UIImageView!
    let transition = SlideInTransition()
    let filterTransition = FilterSlideInTransition()
    var heightNavBar = CGFloat()
    var headerLabelName = String()
    @IBOutlet var customerSummaryUpperPart: UIView!
    @IBOutlet var dateRangeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  setUpNavigationBarItems()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        print("Access Tokens: " + (UserAccountManager.shared.currentUserAccount?.credentials.accessToken!)!)
        print("Refresh Tokens: " + (UserAccountManager.shared.currentUserAccount?.credentials.refreshToken!)!)
      /*
        let imageView : UIImage = UIImage(named:"AppIcon")!
        let titleImageView = UIImageView(image: imageView)
        titleImageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        titleImageView.contentMode = .scaleAspectFit
         navigationItem.titleView = titleImageView
         */
       //  navigationBar.backgroundColor = UIColor.systemTeal
      //  UINavigationBar.appearance().backgroundColor = UIColor.systemTeal
        
        
    }
    
    
    func addLeftBarButtonItems(){
        let iconImage = UIButton.init(type: .custom)
        iconImage.setImage(UIImage(named: "IconImage"), for: .normal)
     //   btnSearch.addTarget(self, action: #selector(MyPageContainerViewController.searchButtonPressed), for: .touchUpInside)
       // iconImage.isEnabled = false
        iconImage.isUserInteractionEnabled = false
      

        let menubutton = UIButton.init(type: .custom)
        menubutton.setImage(UIImage(named: "menuimages"), for: .normal)
        menubutton.addTarget(self, action: #selector(ExecutiveViewController.didTapMenu), for: .touchUpInside)
       
        
        let stackview = UIStackView.init(arrangedSubviews: [menubutton, iconImage])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 2
     
        let leftBarButton = UIBarButtonItem(customView: stackview)
        
        let currentHeight = leftBarButton.customView?.heightAnchor.constraint(equalToConstant: 35)
         currentHeight?.isActive = true
         let currentWidth = leftBarButton.customView?.widthAnchor.constraint(equalToConstant: 90)
         currentWidth?.isActive = true
      
        self.navigationItem.leftBarButtonItem = leftBarButton
        
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
        
     //   print(self.navigationController?.navigationBar.frame.size.height)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
            self.navigationController?.navigationBar.barTintColor = UIColor.systemTeal
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0) {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
     }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
    
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        else{return}
        menuViewController.didTapMenuType = { menuType in
            print(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        
       transition.slideInNavBar = heightNavBar
        present(menuViewController, animated: true, completion: nil)
    
      
    }
    
    @IBAction func didTapFilterButton(_ sender: UIBarButtonItem){
        
        guard let filterViewController = storyboard?.instantiateViewController(withIdentifier: "filterViewController") as? FilterViewController
        else{return}
      
        filterViewController.modalPresentationStyle = .overCurrentContext
        filterViewController.transitioningDelegate = self
        present(filterViewController, animated: true, completion: nil)
        
      
    
    }
    
    
    
    @objc func selectorX() { }
    
    private func setUpNavigationBarItems(){
        
        let width = self.view.frame.width
              let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 70))
         
             self.view.addSubview(navigationBar);
                                            
                                         
              let navigationItem = UINavigationItem(title: "Navigation bar")
              let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(selectorX))
         //     navigationItem.rightBarButtonItem = doneBtn
          //    navigationBar.setItems([navigationItem], animated: false)
        
        
       
        let imageView : UIImage = UIImage(named:"smallicon")!
        let titleImageView = UIImageView(image: imageView)
        titleImageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        titleImageView.contentMode = .scaleAspectFit
         navigationItem.titleView = titleImageView
        
        
        let menuButton: UIImage = UIImage(named:"smallicon")!
        
        let followButton = UIButton(type: .system)
        followButton.setImage(menuButton.withRenderingMode(.alwaysOriginal), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
         navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        
        let firstButton: UIImage = UIImage(named:"smallicon")!
        let refreshButton = UIButton(type: .system)
        refreshButton.setImage(firstButton.withRenderingMode(.alwaysOriginal), for: .normal)
        refreshButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
        
        let secondButton: UIImage = UIImage(named:"smallicon")!
        let filterButton = UIButton(type: .system)
        filterButton.setImage(secondButton.withRenderingMode(.alwaysOriginal), for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: refreshButton),UIBarButtonItem(customView: filterButton)]
    
        navigationBar.setItems([navigationItem], animated: false)
    }
  
   
}

extension ExecutiveViewController:UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let menuViewController = MenuViewController()
        if(presented.isKind(of: MenuViewController.self) ){
            transition.isPresenting = true
            return transition
        }
        filterTransition.isPresenting = true
        return filterTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if(dismissed.isKind(of: MenuViewController.self) ){
            transition.isPresenting = false
            return transition
        }
        
        filterTransition.isPresenting = false
        return filterTransition
    }
    
}

extension ExecutiveViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You Table View")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0;//Choose your custom row height
    }
    
 
}

extension ExecutiveViewController:  UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  print("********** Inside cell  For   Row  at ********************")
        let cell = tableview.dequeueReusableCell(withIdentifier: "TableViewCell",for:indexPath) as! TableViewCell
        if(indexPath.row%2 == 0){
            headerLabelName = "AAA Cooper Transportation"
           // cell.contentImage.backgroundColor = .red
         //   cell.contentImage.image = UIImage(contentsOfFile: "summaryimage")
        }
        else{
            headerLabelName = "Able Sales Company"
        }
        
        
      //  print("********** Inside cellForRowat ********************")
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return  140
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // print("********** Inside numberOfSections ********************")
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("********** Inside numberOfRowsInSection ********************")
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customerSummaryUpperPart.frame.size.height * 0.8
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         
        let headerPart = tableview.dequeueReusableCell(withIdentifier: "cellHeader") as! HeaderCell
        headerPart.headerLabel.text = headerLabelName
        return headerPart
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
        }

    
   
}




  /*
    var dataRows = [[String: Any]]()
    override func viewDidLoad() {
       setUpNavigationBarItems()
    }
    // MARK: - View lifecycle
    
    private func setUpNavigationBarItems(){
        let imageView : UIImage = UIImage(named:"mainlogo")!
        let titleImageView = UIImageView(image: imageView)
        titleImageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        
        let menuButton: UIImage = UIImage(named:"menuicon")!
        
        let followButton = UIButton(type: .system)
        followButton.setImage(menuButton.withRenderingMode(.alwaysOriginal), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        
        let firstButton: UIImage = UIImage(named:"refreshicon")!
        let refreshButton = UIButton(type: .system)
        refreshButton.setImage(firstButton.withRenderingMode(.alwaysOriginal), for: .normal)
        refreshButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
        
        let secondButton: UIImage = UIImage(named:"filtericon")!
        let filterButton = UIButton(type: .system)
        filterButton.setImage(secondButton.withRenderingMode(.alwaysOriginal), for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: refreshButton),UIBarButtonItem(customView: filterButton)]
    }
    override func loadView() {
        super.loadView()
        self.title = "Mobile SDK Sample App"
        let request = RestClient.shared.request(forQuery: "SELECT Name FROM Contact LIMIT 10", apiVersion: SFRestDefaultAPIVersion)
        
        RestClient.shared.send(request: request) { [weak self] (result) in
            switch result {
                case .success(let response):
                    self?.handleSuccess(response: response, request: request)
                case .failure(let error):
                     SalesforceLogger.d(RootViewController.self, message:"Error invoking: \(request) , \(error)")
            }
        }
  
        //NOTE: An alternative way of consuming the response
        //RestClient.shared.send(request: request) { [weak self] (result) in
        //   do {
        //      try self?.handleSuccess(response: result.get(),request: request)
        //   }
        //   catch(let error) {
        //       SalesforceLogger.d(RootViewController.self, message:"Error invoking: \(request) , \(error)")
        //   }
        //}
    
    }
    
    func handleSuccess(response: RestResponse, request: RestRequest) {
        guard let jsonResponse  = try? response.asJson() as? [String:Any], let records = jsonResponse["records"] as? [[String:Any]]  else {
                SalesforceLogger.d(RootViewController.self, message:"Empty Response for : \(request)")
                return
        }
        SalesforceLogger.d(type(of:self), message:"Invoked: \(request)")
        DispatchQueue.main.async {
           self.dataRows = records
           self.tableView.reloadData()
       }
        
    }

    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.dataRows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellIdentifier"
        
        // Dequeue or create a cell of the appropriate type.
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // If you want to add an image to your cell, here's how.
        let image = UIImage(named: "icon.png")
        cell.imageView?.image = image
        
        // Configure the cell to show the data.
        let obj = dataRows[indexPath.row]
        cell.textLabel?.text = "Rohit katkar"
        
        // This adds the arrow to the right hand side.
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
  */

