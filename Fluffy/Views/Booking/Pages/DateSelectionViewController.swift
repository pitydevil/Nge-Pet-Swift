//
//  DateSelectionViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 28/10/22.
//

import UIKit

@available(iOS 16.0, *)
class DateSelectionViewController: UIViewController {

    //MARK: Subviews
    private lazy var btmBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Lanjut", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(doneEdit), for: .touchUpInside)
        customBar.translatesAutoresizingMaskIntoConstraints = false
        customBar.backgroundColor = UIColor(named: "primaryMain")
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "white")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
        return customBar
    }()
    
    private lazy var startFrom:ReuseableLabel = ReuseableLabel(labelText: "", labelType: .bodyP2, labelColor: .white)
    
    private lazy var perDay:ReuseableLabel = ReuseableLabel(labelText: "", labelType: .bodyP2, labelColor: .white)
    
    private lazy var price:ReuseableLabel = ReuseableLabel(labelText: "", labelType: .titleH2, labelColor: .white)
    
    private lazy var heading:ReuseableLabel = ReuseableLabel(labelText: "Check In", labelType: .titleH1, labelColor: .black)
    
    private lazy var calendarView:UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        
        calendarView.backgroundColor = UIColor(named: "white")
        calendarView.tintColor = UIColor(named: "primaryMain")
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        calendarView.layer.cornerRadius = 12
        let multiSelect = UICalendarSelectionMultiDate(delegate: self)
        calendarView.selectionBehavior = multiSelect

        
        calendarView.layer.borderColor = UIColor.lightGray.cgColor
        calendarView.layer.shadowOpacity = 0.1
        calendarView.layer.shadowOffset = CGSize.zero
        calendarView.layer.shadowRadius = 5

        return calendarView
    }()
    
    private lazy var datePicker:UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.calendar = .current
        datePicker.locale = .current
        datePicker.tintColor = UIColor(named: "primaryMain")
        datePicker.backgroundColor = UIColor(named: "white")
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = .now
        datePicker.maximumDate = .distantFuture
        
        datePicker.layer.borderColor = UIColor.lightGray.cgColor
        datePicker.layer.shadowOpacity = 0.1
        datePicker.layer.shadowOffset = CGSize.zero
        datePicker.layer.shadowRadius = 5
        return datePicker
    }()
    //MARK: Properties
    private lazy var checkInDate:String = "Check In Date"
    private lazy var checkOutDate:String = "Check Out Date"
    var selectedDates: Set<DateComponents> = [] {
        didSet {
            let formatDate = selectedDates.compactMap { components in
                Calendar.current
                    .date(from: components)?
                    .formatted(.dateTime.year().month().day()
                        .locale(Locale(identifier: "en_US")))
            }
                .formatted()
            
            print(formatDate)
        }
    }
    
    @objc func doneEdit() {
        let vc = BookingConfirmationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white")
        self.navigationItem.titleView = setTitle(title: "Pet Hotel Name", subtitle: "location")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupUI()
        
        view.addSubview(btmBar)
        btmBar.addSubview(startFrom)
        btmBar.addSubview(price)
        btmBar.addSubview(perDay)
        
        view.addSubview(heading)
        view.addSubview(calendarView)
//        view.addSubview(datePicker)
        
        setupConstraint()
    }

}

@available(iOS 16.0, *)
extension DateSelectionViewController{
    func setupUI(){
        if selectedDates.count==0{
            startFrom.text = "1 Hewan Dipilih"
        }
        else {
            startFrom.text = checkInDate + " - " + checkOutDate
        }
        price.text = "Rp70.000"
        perDay.text = "/hari"
    }
    
    func setupConstraint(){
        //MARK: tabbar constraint
        btmBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        btmBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        btmBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //MARK: start label constraint
        startFrom.topAnchor.constraint(equalTo: btmBar.topAnchor, constant: 20).isActive = true
        startFrom.leftAnchor.constraint(equalTo: btmBar.leftAnchor, constant: 24).isActive = true
        
        //MARK: price constraint
        price.topAnchor.constraint(equalTo: startFrom.bottomAnchor, constant: 0).isActive = true
        price.leftAnchor.constraint(equalTo: startFrom.leftAnchor).isActive = true
        
        //MARK: per day constraint
        perDay.leftAnchor.constraint(equalTo: price.rightAnchor).isActive = true
        perDay.topAnchor.constraint(equalTo: price.topAnchor).isActive = true
        perDay.bottomAnchor.constraint(equalTo: price.bottomAnchor).isActive = true
        
        //MARK: Heading Constraint
        heading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        heading.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        heading.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        //MARK: Calendar Constraint
        calendarView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 20).isActive = true
        calendarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        calendarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        //MARK: Date Picker Constraints
//        datePicker.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 20).isActive = true
//        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
//        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
}

@available(iOS 16.0, *)
extension DateSelectionViewController{
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRectMake(0, -2, 0, 0))

        titleLabel.backgroundColor = .clear
        titleLabel.textColor = UIColor(named: "black")
        titleLabel.font = UIFont(name: "Poppins-Bold", size: 16)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRectMake(0, 18, 0, 0))
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = UIColor(named: "black")
        subtitleLabel.font = UIFont(name: "Inter-Medium", size: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }

        return titleView
    }
    
}

@available(iOS 16.0, *)
extension DateSelectionViewController: UICalendarSelectionMultiDateDelegate, UICalendarViewDelegate {
    
    @objc func deleteSelectedDate() {
        selectedDates = []
//        isClicked = true
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        selectedDates.insert(dateComponents)
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: Date())
        let df = DateFormatter()
        var titleLbl = ""
        
        df.dateFormat = "dd MMM"
        titleLbl = df.string(from: (dateComponents.date)!)
  
        if(selectedDates.count==1){
            heading.text = "Check Out"
            checkInDate = titleLbl
        }
        else{
            checkOutDate = titleLbl
        }
        print(titleLbl)
        startFrom.text = checkInDate + " - " + checkOutDate
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        selectedDates.remove(dateComponents)
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        if(selectedDates.count == 2){
            return false
        }
        else{
            return true
        }
        
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}


//MARK: UICalendarSelectionSingleDateDelegate
//@available(iOS 16.0, *)
//extension DateSelectionViewController: UICalendarSelectionSingleDateDelegate {
//    @available(iOS 16.0, *)
//    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
//        let currentDate = Date()
//        let currentYear = Calendar.current.component(.year, from: Date())
//        let df = DateFormatter()
//        var titleLbl = ""
//
//        if dateComponents?.year == currentYear && dateComponents?.date != currentDate{
//            df.dateFormat = "dd MMM"
//            titleLbl = df.string(from: (dateComponents?.date)!)
//        }
//        else{
//            df.dateFormat = "dd MMM yy"
//            titleLbl = df.string(from: (dateComponents?.date)!)
//        }
//        df.dateFormat = "dd MMM"
//        let currDate = df.string(from: (currentDate))
//        if currDate == titleLbl{
//            titleLbl = "Hari Ini"
//        }
//        print(currDate)
//    }
//
//}
