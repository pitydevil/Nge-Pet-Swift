//
//  DateSelectionViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 28/10/22.
//

import UIKit

@available(iOS 16.0, *)
class DateSelectionViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(named: "white")
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var scrollContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "white")
        return view
    }()

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
    
    private lazy var headingSecond: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Check Out", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
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
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)

        
        calendarView.layer.borderColor = UIColor.lightGray.cgColor
        calendarView.layer.shadowOpacity = 0.1
        calendarView.layer.shadowOffset = CGSize.zero
        calendarView.layer.shadowRadius = 5

        return calendarView
    }()
    
    private lazy var bgDatePicker: UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor(named: "white")
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.layer.borderColor = UIColor.lightGray.cgColor
        bg.layer.shadowOpacity = 0.1
        bg.layer.shadowOffset = CGSize.zero
        bg.layer.shadowRadius = 5
        bg.layer.cornerRadius = 12
        return bg
    }()
    
    private lazy var calendarViewSecond: UIDatePicker = {
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
        
        datePicker.isUserInteractionEnabled = false
        datePicker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        return datePicker
    }()
    
    //MARK: Properties
    private lazy var checkInDate:String = "Check In Date"
    private lazy var checkOutDate:String = "Check Out Date"
    
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        scrollContainer.addSubview(heading)
        scrollContainer.addSubview(calendarView)
        scrollContainer.addSubview(headingSecond)
        scrollContainer.addSubview(bgDatePicker)
        bgDatePicker.addSubview(calendarViewSecond)
        
        setupConstraint()
    }

}

@available(iOS 16.0, *)
extension DateSelectionViewController{
    func setupUI(){
        if checkInDate == "Check In Date" {
            startFrom.text = "1 Hewan Dipilih"
        }
        else {
            startFrom.text = checkInDate + " - " + checkOutDate
        }
        price.text = "Rp70.000"
        perDay.text = "/hari"
    }
    
    func setupConstraint(){
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
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
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: btmBar.topAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollContainer.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
            scrollContainer.heightAnchor.constraint(equalToConstant: 950),
            
            heading.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 20),
            heading.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            heading.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -222),
            
            calendarView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 20),
            calendarView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            calendarView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            calendarView.heightAnchor.constraint(equalToConstant: 380),
            
            headingSecond.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 32),
            headingSecond.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            headingSecond.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -222),
            
            bgDatePicker.topAnchor.constraint(equalTo: headingSecond.bottomAnchor, constant: 20),
            bgDatePicker.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            bgDatePicker.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            bgDatePicker.heightAnchor.constraint(equalToConstant: 380),
            bgDatePicker.widthAnchor.constraint(equalToConstant: 342),
            
            calendarViewSecond.topAnchor.constraint(equalTo: bgDatePicker.topAnchor, constant: 0),
            calendarViewSecond.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            calendarViewSecond.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            calendarViewSecond.heightAnchor.constraint(equalToConstant: 380),
        ])
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
extension DateSelectionViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yy"
        checkInDate = df.string(from: (dateComponents?.date)!)
        var newDates = dateComponents
        newDates?.day! += 1
        calendarViewSecond.minimumDate = newDates?.date
        calendarViewSecond.isUserInteractionEnabled = true
        checkOutDate = df.string(from: calendarViewSecond.date)
        startFrom.text = (checkInDate + " - " + checkOutDate)
        print(checkInDate + " - " + checkOutDate)
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    @objc func valueChanged(_ sender: UIDatePicker) {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yy"
        checkOutDate = df.string(from: (sender.date))
        startFrom.text = (checkInDate + " - " + checkOutDate)
        print(checkInDate + " - " + checkOutDate)
    }
}
