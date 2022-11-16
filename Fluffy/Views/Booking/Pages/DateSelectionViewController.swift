//
//  DateSelectionViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 28/10/22.
//

import UIKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
class DateSelectionViewController: UIViewController {
    
    //MARK: - OBJECT DECLARATION
    var orderAddObject = BehaviorRelay<OrderAdd>(value: OrderAdd(orderDateCheckIn: "", orderDateCheckOu: "", orderTotalPrice: 0, userID: userID, petHotelId: 0, orderDetails: [OrderDetailBodyFinal]()))
    
    var orderDetailObject = BehaviorRelay<[OrderDetailBody]>(value: [])
    
    var petHotelModel   = BehaviorRelay<PetHotelsDetail>(value: PetHotelsDetail(petHotelID: 0, petHotelName: "", petHotelDescription: "", petHotelLongitude: "", petHotelLatitude: "", petHotelAddress: "", petHotelKelurahan: "", petHotelKecamatan: "", petHotelKota: "", petHotelProvinsi: "", petHotelPos: "", petHotelStartPrice: "", supportedPet: [SupportedPet](), petHotelImage: [PetHotelImage](), fasilitas: [Fasilitas](), sopGeneral: [SopGeneral](), asuransi: [AsuransiDetail](), cancelSOP: [CancelSOP]()))
   
    var dateTrigger  = BehaviorRelay<Bool>(value: false)
    var checkInObject  = BehaviorRelay<String>(value: String())
    var checkOutObject = BehaviorRelay<String>(value: String())
    
    //MARK: OBJECT OBSERVER DECLARATION
    var checkInObjectObserver : Observable<String> {
        return checkInObject.asObservable()
    }
    var checkOutObjectObserver : Observable<String> {
        return checkOutObject.asObservable()
    }
    var orderAddObjectObserver : Observable<OrderAdd> {
        return orderAddObject.asObservable()
    }
    var petHotelModelObservable : Observable<PetHotelsDetail> {
        return petHotelModel.asObservable()
    }
    
    //MARK: SUBVIEWS
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
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
        navigationItem.titleView = setTitle(title: "Pet Hotel Name", subtitle: "location")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        perDay.text = "/hari"
        
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
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        setupUI()
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelModelObservable.subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                navigationItem.titleView = setTitle(title: value.petHotelName, subtitle: "\(value.petHotelAddress),\(value.petHotelProvinsi)")
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        orderAddObjectObserver.subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                price.text = "Rp.\(value.orderTotalPrice)"
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        checkInObjectObserver.subscribe(onNext: { [self] (value) in
            startFrom.text = (value + " - " + checkOutObject.value)
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        checkOutObjectObserver.subscribe(onNext: { [self] (value) in
            startFrom.text = (checkInObject.value + " - " + value)
            btmBar.barBtn.isEnabled = value.isEmpty ? false : true
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        btmBar.barBtn.rx.tap.bind { [self] in
            if dateTrigger.value {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: BookingConfirmationViewController.self) {
                        let vc = controller as! BookingConfirmationViewController
                        var orderAdd = orderAddObject.value
                        orderAdd.orderDateCheckIn = checkInObject.value
                        orderAdd.orderDateCheckOu = checkOutObject.value
                        orderAddObject.accept(orderAdd)
                        vc.orderAddObject.accept(orderAdd)
                        vc.petHotelModel.accept(petHotelModel.value)
                        vc.orderDetailObject.accept(orderDetailObject.value)
                        self.navigationController!.popToViewController(vc, animated: true)
                        break
                    }
                }
            }else {
                let vc = BookingConfirmationViewController()
                var orderAdd = orderAddObject.value
                orderAdd.orderDateCheckIn = checkInObject.value
                orderAdd.orderDateCheckOu = checkOutObject.value
                orderAddObject.accept(orderAdd)
                vc.orderAddObject.accept(orderAdd)
                vc.petHotelModel.accept(petHotelModel.value)
                vc.orderDetailObject.accept(orderDetailObject.value)
                navigationController?.pushViewController(vc, animated: true)
            }
        }.disposed(by: bags)
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
        checkInObject.accept(changeDateIntoYYYYMMDD(dateComponents?.date ?? Date()))
        
        var newDates = dateComponents
        newDates?.day! += 1
        calendarViewSecond.minimumDate = newDates?.date
        calendarViewSecond.isUserInteractionEnabled = true
        checkOutObject.accept(changeDateIntoYYYYMMDD(calendarViewSecond.date))
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    @objc func valueChanged(_ sender: UIDatePicker) {
        checkOutObject.accept(changeDateIntoYYYYMMDD(sender.date))
    }
}
