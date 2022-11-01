//
//  ModalCheckInOutViewController.swift
//  Fluffy
//
//  Created by Zacky Ilahi Azmi on 21/10/22.
//

import UIKit

@available(iOS 16.0, *)
class ModalCheckInOutViewController: UIViewController, UICalendarViewDelegate {
    
    var dateCount: Int = 0
    var isClicked = false
    
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        indicator.image = UIImage(systemName: "minus", withConfiguration: config)
        indicator.tintColor = UIColor(named: "grey2")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var headline: ReuseableLabel = {
        let headline = ReuseableLabel(labelText: "Check In", labelType: .titleH1, labelColor: .black)
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
        calendarView.selectionBehavior = UICalendarSelectionMultiDate(delegate: self)

        return calendarView
    }()
    
    private lazy var customBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Lanjut", showText: .notShow)
        customBar.barBtn.addTarget(self, action: #selector(checkinSelected), for: .touchUpInside)
        customBar.barBtn.isEnabled = false
        return customBar
    }()
    
    private lazy var barBtnLewati: ReusableButton = {
        let barBtnLewati = ReusableButton(titleBtn: "Lewati", styleBtn: .light)
        barBtnLewati.addTarget(self, action: #selector(skipModal), for: .touchUpInside)
        return barBtnLewati
    }()
    
    private lazy var barBtnHapusPilihan: ReusableButton = {
        let barBtnHapusPilihan = ReusableButton(titleBtn: "Hapus Pilihan", styleBtn: .light)
        barBtnHapusPilihan.addTarget(self, action: #selector(deleteSelectedDate), for: .touchUpInside)
        return barBtnHapusPilihan
    }()
    
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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "white")

        //MARK: - Add Subview
        view.addSubview(indicator)
        view.addSubview(headline)
        view.addSubview(calendarView)
        view.addSubview(customBar)
        btnExtensionLewati()
        
        //MARK: - Setup Layout Pet
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            headline.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -222),
            
            calendarView.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 20),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        //MARK: - For Hapus Pilihan
        if isClicked == true {
            //Restore UICalendarView to Empty Selected
        }
    }
    
    //MARK: - Button Target
    @objc func checkinSelected() {
        headline.text = "Check Out"
        if dateCount == 1 {
            customBar.barBtn.isEnabled = false
            barBtnHapusPilihan.removeFromSuperview()
            btnExtensionLewati()
        } else if dateCount == 2 {
            dismiss(animated: true)
        }
    }
    
    @objc func skipModal() {
        dismiss(animated: true)
    }
    
    private func btnExtensionLewati() {
        view.addSubview(barBtnLewati)
        NSLayoutConstraint.activate([
            barBtnLewati.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            barBtnLewati.centerYAnchor.constraint(equalTo: customBar.barBtn.centerYAnchor),
        ])
    }
    
    private func btnExtensionHapusPilihan() {
        view.addSubview(barBtnHapusPilihan)
        NSLayoutConstraint.activate([
            barBtnHapusPilihan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            barBtnHapusPilihan.centerYAnchor.constraint(equalTo: customBar.barBtn.centerYAnchor),
        ])
    }

}

@available(iOS 16.0, *)
extension ModalCheckInOutViewController: UICalendarSelectionMultiDateDelegate, UICalendarViewDelegate {
    
    @objc func deleteSelectedDate() {
        selectedDates = []
        isClicked = true
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        selectedDates.insert(dateComponents)
        customBar.barBtn.isEnabled = true
        barBtnLewati.removeFromSuperview()
        btnExtensionHapusPilihan()
        dateCount += 1
        
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        selectedDates.remove(dateComponents)
        customBar.barBtn.isEnabled = false
        barBtnHapusPilihan.removeFromSuperview()
        btnExtensionLewati()
        dateCount -= 1
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
