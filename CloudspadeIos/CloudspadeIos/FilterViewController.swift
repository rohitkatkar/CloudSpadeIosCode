//
//  FilterViewController.swift
//  CloudspadeIos
//
//  Created by GNS065 on 13/10/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//

import SwiftUI
import DropDown

class FilterViewController : UIViewController {
        
    @IBOutlet weak var dateRangeView: UIView!
    
   
    @IBOutlet weak var divisionView: UIView!
    
   // @IBOutlet weak var lastWeekView: UIView!
    
    @IBOutlet var preDefinedView: UIView!
    var dateRangeViewNSLayoutConstraint:NSLayoutConstraint!
    var labelConstraint:NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet var comparisonYearLabel: UILabel!
    @IBOutlet weak var stackButton1: UIButton!
    @IBOutlet weak var stackButton2: UIButton!
    @IBOutlet weak var stackButton3: UIButton!
    
    @IBOutlet weak var divisionButton1: UIButton!
    
    @IBOutlet weak var divisionButton2: UIButton!
    
    @IBOutlet weak var divisionButton3: UIButton!
    
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var weekRangeView: UIView!
    
    @IBOutlet var weekFrom: UIButton!
    @IBOutlet var yearFrom: UIButton!
    @IBOutlet var dateFrom: UIButton!
    
    @IBOutlet var weekTo: UIButton!
    @IBOutlet var yearTo: UIButton!
    @IBOutlet var dateTo: UIButton!
    
    
    let dropDown = DropDown()
    let valueDropDown = DropDown()
    let weekFromDropDown = DropDown()
    let yearFromDropDown = DropDown()
    let dateFromDropDown = DropDown()
    let weekToDropDown = DropDown()
    let yearToDropDown = DropDown()
    let dateToDropDown = DropDown()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initValuesInViews()
    }
    func initValuesInViews(){
      //  self!.weekFrom.setTitle("51", for: UIControl.State.normal)
        self.setWeekFromDataSource(selectedWeek: "2019")
        self.setWeekToDataSource(selectedWeek: "2019")
       // self?.setFromDate(week: "", year: self!.yearFrom.currentTitle!)
    }
    func initViews(){
        dateRangeView.layer.borderWidth = 1.0
        divisionView.layer.borderWidth = 1.0
                preDefinedView.layer.borderWidth = 1.0
      //  buttonStackView.layer.borderWidth = 1.0
        stackButton1.layer.borderWidth = 1.0
        stackButton2.layer.borderWidth = 1.0
        stackButton3.layer.borderWidth = 1.0
                
        divisionButton1.layer.borderWidth = 1.0
        divisionButton2.layer.borderWidth = 1.0
        divisionButton3.layer.borderWidth = 1.0
                
        weekFrom.layer.borderWidth = 1.0
        yearFrom.layer.borderWidth = 1.0
        dateFrom.layer.borderWidth = 1.0
                
        weekTo.layer.borderWidth = 1.0
        yearTo.layer.borderWidth = 1.0
        dateTo.layer.borderWidth = 1.0
                
        
        dateRangeView.layer.borderColor = UIColor.lightGray.cgColor
        dateRangeView.translatesAutoresizingMaskIntoConstraints = false
        divisionView.layer.borderColor = UIColor.lightGray.cgColor
        preDefinedView.layer.borderColor = UIColor.lightGray.cgColor
      //  buttonStackView.layer.borderColor = UIColor.lightGray.cgColor
        stackButton1.layer.borderColor = UIColor.lightGray.cgColor
        stackButton2.layer.borderColor = UIColor.lightGray.cgColor
        stackButton3.layer.borderColor = UIColor.lightGray.cgColor
        divisionButton1.layer.borderColor = UIColor.lightGray.cgColor
        divisionButton2.layer.borderColor = UIColor.lightGray.cgColor
        divisionButton3.layer.borderColor = UIColor.lightGray.cgColor
                
        weekFrom.layer.borderColor = UIColor.lightGray.cgColor
        yearFrom.layer.borderColor = UIColor.lightGray.cgColor
        dateFrom.layer.borderColor = UIColor.lightGray.cgColor
                        
        weekTo.layer.borderColor = UIColor.lightGray.cgColor
        yearTo.layer.borderColor = UIColor.lightGray.cgColor
        dateTo.layer.borderColor = UIColor.lightGray.cgColor
                
                
        
        dateRangeView.layer.cornerRadius = view.frame.size.height * 0.01
        divisionView.layer.cornerRadius = view.frame.size.height * 0.01
                preDefinedView.layer.cornerRadius = view.frame.size.height * 0.01
      //  buttonStackView.layer.cornerRadius = view.frame.size.height * 0.01
        divisionButton1.layer.cornerRadius = view.frame.size.height * 0.009
        divisionButton2.layer.cornerRadius = view.frame.size.height * 0.009
        divisionButton3.layer.cornerRadius = view.frame.size.height * 0.009
        stackButton1.layer.cornerRadius = view.frame.size.height * 0.009
        stackButton2.layer.cornerRadius = view.frame.size.height * 0.009
        stackButton3.layer.cornerRadius = view.frame.size.height * 0.009
    }
    @IBAction func toggleButtonClicked(_ sender: UIButton) {
       
        dropDown.dataSource = ["Week Range","Pre-defined"]//4
            dropDown.anchorView = sender //5
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
              print(item)
                
                if(item == "Week Range"){
                    self?.preDefinedView.isHidden = true
                    self?.weekRangeView.isHidden = false
                    self!.setConstraintsForWeekRangeView()
                }
                else{
                    self?.preDefinedView.isHidden = false
                    self?.weekRangeView.isHidden = true
                  //  self?.reloadInputViews()
                   self?.setConstraintsForPreDefinedView()
                }
             
            }
    }
    
    func setConstraintsForPreDefinedView(){
        dateRangeViewNSLayoutConstraint?.isActive = false
        labelConstraint?.isActive = false
      //  dateRangeView.heightAnchor.con
     //   dateRangeView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.255978, constant: 50).isActive = true
      //  preDefinedView.heightAnchor.constraint(equalToConstant: 50).isActive = true
      //  comparisonYearLabel.topAnchor.constraint(equalTo: preDefinedView.bottomAnchor, constant: 10).isActive = true
    }
    func setConstraintsForWeekRangeView(){
        
     //  dateRangeViewNSLayoutConstraint = dateRangeView.heightAnchor.constraint(equalToConstant: dateRangeView.frame.size.height + divisionView.frame.size.height)
        dateRangeViewNSLayoutConstraint = dateRangeView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        labelConstraint = comparisonYearLabel.topAnchor.constraint(equalTo: weekRangeView.bottomAnchor, constant: 0)
        divisionView.topAnchor.constraint(equalTo: dateRangeView.bottomAnchor, constant: 30)
        dateRangeViewNSLayoutConstraint.isActive = true
        labelConstraint.isActive = true
        
       // dateRangeView.h
    }
    @IBAction func removeAllClicked(_ sender: UIButton) {
       
    }
    
  
    @IBAction func valueDropDownClicked(_ sender: UIButton) {
       
        valueDropDown.dataSource = ["YESTERDAY", "TODAY", "TOMORROW", "CURRENT WEEK", "LAST WEEK","YEAR TO DATE"]//4
        valueDropDown.anchorView = sender //5
        valueDropDown.width = filterLabel.frame.size.width + sender.frame.size.width
        valueDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        valueDropDown.show() //7
        valueDropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
           
            self!.filterLabel.text = item
   
        }
      
    }
    
    @IBAction func weekFromClicked(_ sender: UIButton) {
       
        weekFromDropDown.anchorView = sender //5
        weekFromDropDown.width = sender.frame.size.width
        weekFromDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        weekFromDropDown.show() //7
        weekFromDropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
            
            self!.weekFrom.setTitle(item, for: UIControl.State.normal)
            self?.setFromDate(week: item, year: self!.yearFrom.currentTitle!)
            /*
            let selectedWeek = Int(item)
            let selectedYear = Int(self!.yearFrom.currentTitle!)
            let firstDay = self!.getFirstDayOfWeek(weekNumber: selectedWeek!, yearNumber:selectedYear! )
            
          
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy/MM/dd"

            let myString = formatter.string(from: firstDay)
            self?.dateFrom.setTitle(myString,for: UIControl.State.normal)
            */
            self!.validateCalendarValues()
        }
    }
    
    @IBAction func yearFromClicked(_ sender: UIButton) {
        yearFromDropDown.dataSource = ["2013", "2014", "2015", "2016", "2017","2018","2019","2020","2021", "2022", "2023", "2024", "2025","2026","2027","2028"]//4
        yearFromDropDown.anchorView = sender //5
        yearFromDropDown.width = sender.frame.size.width
        yearFromDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        yearFromDropDown.show() //7
        yearFromDropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
           
            self!.yearFrom.setTitle(item, for: UIControl.State.normal)
            self!.setWeekFromDataSource(selectedWeek: item)
            self?.setFromDate(week: (self?.weekFrom.currentTitle)!, year: self!.yearFrom.currentTitle!)
            self!.validateCalendarValues()
          //  let weeksCount = self!.getWeeksInYear(in: Int(item)!)
                      
          //  self!.weekFromDropDown.dataSource = self!.getWeeksArray(in: weeksCount)
            
   
        }
    }
    
    @IBAction func dateFromClicked(_ sender: UIButton) {
      
    }
    
    @IBAction func weekToClicked(_ sender: UIButton) {
      
        weekToDropDown.anchorView = sender //5
        weekToDropDown.width = sender.frame.size.width
        weekToDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        weekToDropDown.show() //7
        weekToDropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
           self!.weekTo.setTitle(item, for: UIControl.State.normal)
           
            self?.setToDate(week: item, year: self!.yearTo.currentTitle!)
            self!.validateCalendarValuesForTo()
            /*
            let selectedWeek = Int(item)
            let selectedYear = Int(self!.yearTo.currentTitle!)
            let lastDay = self!.getLastDayOfWeek(weekNumber: selectedWeek!, yearNumber:selectedYear! )
            
          
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy/MM/dd"

            let myString = formatter.string(from: lastDay)
            self?.dateTo.setTitle(myString,for: UIControl.State.normal)
          */
   
        }
    }
    
    @IBAction func yearToClicked(_ sender: UIButton) {
        yearToDropDown.dataSource = ["2013", "2014", "2015", "2016", "2017","2018","2019","2020","2021", "2022", "2023", "2024", "2025","2026","2027","2028"]//4
        yearToDropDown.anchorView = sender //5
        yearToDropDown.width = sender.frame.size.width
        yearToDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        yearToDropDown.show() //7
        yearToDropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
            self!.yearTo.setTitle(item, for: UIControl.State.normal)
            self!.setWeekToDataSource(selectedWeek: item)
            self?.setToDate(week: (self?.weekTo.currentTitle)! , year: self!.yearTo.currentTitle!)
            self!.validateCalendarValuesForTo()
          //  let weeksCount = self!.getWeeksInYear(in: Int(item)!)
          // self!.weekToDropDown.dataSource = self!.getWeeksArray(in: weeksCount)
 
        }
    }
    
   
    @IBAction func dateToClicked(_ sender: UIButton) {
     
    }
    
   
    func setFromDate(week:String,year:String){
        
        let selectedWeek = Int(week)
        let selectedYear = Int(year)
        let firstDay = self.getFirstDayOfWeek(weekNumber: selectedWeek!, yearNumber:selectedYear! )
        
      
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy/MM/dd"

        let myString = formatter.string(from: firstDay)
        self.dateFrom.setTitle(myString,for: UIControl.State.normal)
    }
    
    func setToDate(week:String,year:String){
        
        let selectedWeek = Int(week)
        let selectedYear = Int(year)
        let lastDay = self.getLastDayOfWeek(weekNumber: selectedWeek!, yearNumber:selectedYear! )
        
      
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy/MM/dd"

        let myString = formatter.string(from: lastDay)
        self.dateTo.setTitle(myString,for: UIControl.State.normal)
    }
    
    func setWeekFromDataSource(selectedWeek:String){
        let weeksCount = self.getWeeksInYear(in: Int(selectedWeek)!)
       self.weekFromDropDown.dataSource = self.getWeeksArray(in: weeksCount)
    }
    
    func setWeekToDataSource(selectedWeek:String){
      let weeksCount = self.getWeeksInYear(in: Int(selectedWeek)!)
      self.weekToDropDown.dataSource = self.getWeeksArray(in: weeksCount)
    }
    
    func getFirstDayOfWeek(weekNumber:Int,yearNumber:Int) -> Date {
        
        let calendar = Calendar(identifier: .iso8601)
        let dayComponent = DateComponents(year: yearNumber, weekday: 2, weekOfYear: weekNumber)
        
        let date = calendar.date(from: dayComponent)!
        
        
        
        return date
    }
    
    func getLastDayOfWeek(weekNumber:Int,yearNumber:Int) -> Date {
        
        let calendar = Calendar(identifier: .iso8601)
        let dayComponent = DateComponents(year: yearNumber, weekday: 8, weekOfYear: weekNumber)
        
        let date = calendar.date(from: dayComponent)!
        
        
        
        return date
    }
    func validateCalendarValues(){
        let weekFromValue = self.weekFrom.currentTitle!
        let yearFromValue = self.yearFrom.currentTitle!
        let dateFromValue = self.dateFrom.currentTitle!
        
        let weekToDateValue = self.weekTo.currentTitle!
        let yearToDateValue = self.yearTo.currentTitle!
        let dateToValue = self.dateTo.currentTitle!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        
        let dateFromdata = dateFormatter.date(from: dateFromValue)
        let dateToData =  dateFormatter.date(from: dateToValue)
        
       
        if dateFromdata?.compare(dateToData!) == .orderedDescending {
           
            self.weekTo.setTitle(self.weekFrom.currentTitle, for: UIControl.State.normal)
            self.yearTo.setTitle(self.yearFrom.currentTitle, for: UIControl.State.normal)
            setWeekToDataSource(selectedWeek: self.yearFrom.currentTitle!)
            setToDate(week: self.weekFrom.currentTitle!, year: self.yearFrom.currentTitle!)
        }
   
    }
    
    func validateCalendarValuesForTo(){
        let weekFromValue = self.weekFrom.currentTitle!
        let yearFromValue = self.yearFrom.currentTitle!
        let dateFromValue = self.dateFrom.currentTitle!
        
        let weekToDateValue = self.weekTo.currentTitle!
        let yearToDateValue = self.yearTo.currentTitle!
        let dateToValue = self.dateTo.currentTitle!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        
        let dateFromdata = dateFormatter.date(from: dateFromValue)
        let dateToData =  dateFormatter.date(from: dateToValue)
        
       
        if dateToData?.compare(dateFromdata!) == .orderedAscending {
           
            self.weekFrom.setTitle(self.weekTo.currentTitle, for: UIControl.State.normal)
            self.yearFrom.setTitle(self.yearTo.currentTitle, for: UIControl.State.normal)
            
            setWeekFromDataSource(selectedWeek: self.yearTo.currentTitle!)
            setFromDate(week: self.weekTo.currentTitle!, year: self.yearTo.currentTitle!)
        }
    }
    func getWeeksArray(in year: Int)-> Array<String>{
        var weekArray = Array<String>()
        for n in 1...year {
            weekArray.append(String(n))
        }
        return weekArray
    }
    
    func getWeeksInYear(in year: Int) -> Int {
        let cal = Calendar(identifier: .iso8601)
        
        let date = DateComponents(calendar: cal, year: year, month: 2, day: 1).date!
        let weeksRange = cal.range(of: .weekOfYear, in: .yearForWeekOfYear, for: date)!
        return weeksRange.count
    }
    
    /*
   
    @IBAction func toggleButtonClicked(_ sender: UIButton) {
        
        dropDown.dataSource = ["Tomato soup", "Mini burgers", "Onion rings", "Baked potato", "Salad"]//4
            dropDown.anchorView = sender //5
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
                print("**************************************")
                print("**************************************")
                print("**************************************")
                print(item)
                print("**************************************")
                print("**************************************")
                print("**************************************")
                
            }
         
    }
   */
    @IBAction func didTapFilterButton(_ sender: Any) {
        dismiss(animated: true) {
            print("dismissing filter")
        }
    }
    var filterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(.darkGray, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    

    private func setupConstraints(){
       
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: self.view.topAnchor),
          //  filterButton.leadingAnchor.constraint(equalTo: adminImageView.trailingAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1),
            filterButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
        ])
    }
    private func setHeaderView(){
      
        var headerPart: MenuHeaderView  = {
            let view = MenuHeaderView(frame: CGRect.zero)
            view.backgroundColor = UIColor(named: "light_gray_color")
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()

        headerPart.descriptionButton.setTitle("Admin Name", for: .normal)
        headerPart.adminImageView.image = UIImage(named: "user_empty_state")
        
        headerPart.adminImageView.widthAnchor.constraint(equalTo: headerPart.widthAnchor, multiplier: 0.2).isActive = true
        
    
        headerPart.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true

        
        self.view.addSubview(headerPart);
     
    
    }
    func addRightBarButtonItems()
    {
        let btnRefresh = UIButton.init(type: .custom)
        btnRefresh.setImage(UIImage(named: "refreshimages"), for: .normal)
     
        let filterButton = UIButton.init(type: .custom)
        filterButton.setImage(UIImage(named: "filterPage"), for: .normal)
      //  filterButton.addTarget(self, action: #selector(ExecutiveViewController.didTapFilterButton), for: .touchUpInside)
        
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
    
}
