//
//  ModalCheckInOutViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 21/10/22.
//

import UIKit
import RxCocoa
import RxSwift

@available(iOS 16.0, *)
class ModalCheckInOutViewController: UIViewController, UICalendarViewDelegate {
    
    //MARK: OBJECT DECLARATION
    private var checkInDateObject  = BehaviorRelay<String>(value:String())
    private var checkOutDateObject = BehaviorRelay<String>(value:String())
    private var checkFinalObject = BehaviorRelay<CheckIn>(value:CheckIn(checkInDate: "", checkOutDate: ""))
    
    var checkInObjectObserver: Observable<String> {
        return checkInDateObject.asObservable()
    }
    
    var checkFinalObjectObserver: Observable<CheckIn> {
        return checkFinalObject.asObservable()
    }
    
    //MARK: - SUBVIEWS
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
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
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Check In", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var headlineSecond: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Check Out", labelType: .titleH1, labelColor: .black)
        return headline
    }()
    
    private lazy var calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        
        calendarView.backgroundColor = UIColor(named: "white")
        calendarView.tintColor = UIColor(named: "primaryMain")
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        calendarView.layer.cornerRadius = 12
        
        
        calendarView.layer.borderColor = UIColor.lightGray.cgColor
        calendarView.layer.shadowOpacity = 0.1
        calendarView.layer.shadowOffset = CGSize.zero
        calendarView.layer.shadowRadius = 5
        
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)

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
    public var passingDate: ((String?) -> Void)?
        
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
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Lanjut", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(checkinSelected), for: .touchUpInside)
        customBar.barBtn.isEnabled = false
        return customBar
    }()
    
    private lazy var barBtnLewati: ReusableButton = {
        let barBtnLewati = ReusableButton(titleBtn: "Batal", styleBtn: .light)
        barBtnLewati.addTarget(self, action: #selector(skipModal), for: .touchUpInside)
        return barBtnLewati
    }()

    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")

        //MARK: - Add Subview
        view.addSubview(indicator)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        scrollContainer.addSubview(headline)
        scrollContainer.addSubview(calendarView)
        scrollContainer.addSubview(headlineSecond)
        scrollContainer.addSubview(bgDatePicker)
        bgDatePicker.addSubview(calendarViewSecond)
        
        view.addSubview(customBar)
        view.addSubview(barBtnLewati)
        
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        //MARK: - Setup Layout Pet
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            scrollView.topAnchor.constraint(equalTo: indicator.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customBar.topAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollContainer.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
            scrollContainer.heightAnchor.constraint(equalToConstant: 950),
            
            headline.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 0),
            headline.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -222),
            
            calendarView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 20),
            calendarView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            calendarView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            calendarView.heightAnchor.constraint(equalToConstant: 380),
            
            headlineSecond.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 32),
            headlineSecond.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            headlineSecond.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -222),
            
            bgDatePicker.topAnchor.constraint(equalTo: headlineSecond.bottomAnchor, constant: 20),
            bgDatePicker.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            bgDatePicker.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            bgDatePicker.heightAnchor.constraint(equalToConstant: 380),
            bgDatePicker.widthAnchor.constraint(equalToConstant: 342),
            
            calendarViewSecond.topAnchor.constraint(equalTo: bgDatePicker.topAnchor, constant: 0),
            calendarViewSecond.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 24),
            calendarViewSecond.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -24),
            calendarViewSecond.heightAnchor.constraint(equalToConstant: 380),
            
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            barBtnLewati.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            barBtnLewati.centerYAnchor.constraint(equalTo: customBar.barBtn.centerYAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        //MARK: - Bind Journal List with Table View
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        checkInObjectObserver.skip(1).subscribe(onNext: { [self] (value) in
            customBar.barBtn.isEnabled = true
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
    }
    
    //MARK: - Button Target
    @objc func checkinSelected() {
        checkFinalObject.accept(CheckIn(checkInDate: checkInDateObject.value, checkOutDate: checkOutDateObject.value))
        dismiss(animated: true)
    }
    
    @objc func skipModal() {
        dismiss(animated: true)
    }
}

@available(iOS 16.0, *)
extension ModalCheckInOutViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        var newDates = dateComponents
        newDates?.day! += 1
        calendarViewSecond.minimumDate = newDates?.date
        calendarViewSecond.isUserInteractionEnabled = true
        checkInDateObject.accept(changeDateIntoYYYYMMDD((dateComponents?.date)!))
        checkOutDateObject.accept(changeDateIntoYYYYMMDD((calendarViewSecond.date)))
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    @objc func valueChanged(_ sender: UIDatePicker) {
        checkOutDateObject.accept(changeDateIntoYYYYMMDD(sender.date))
    }
}
