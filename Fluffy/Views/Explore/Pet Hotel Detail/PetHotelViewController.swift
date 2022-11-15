//
//  PetHotelViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 24/10/22.
//

import UIKit
import RxSwift
import RxCocoa

@available(iOS 16.0, *)
class PetHotelViewController: UIViewController {

    //MARK: - OBJECT DECLARATION
    var petHotelDetailID          = BehaviorRelay<Int>(value: 0)
    private let petHotelViewModel = PetHotelViewModel()
    private var petHotelModel   = BehaviorRelay<PetHotelsDetail>(value: PetHotelsDetail(petHotelID: 0, petHotelName: "", petHotelDescription: "", petHotelLongitude: "", petHotelLatitude: "", petHotelAddress: "", petHotelKelurahan: "", petHotelKecamatan: "", petHotelKota: "", petHotelProvinsi: "", petHotelPos: "", petHotelStartPrice: "", supportedPet: [SupportedPet](), petHotelImage: [PetHotelImage](), fasilitas: [Fasilitas](), sopGeneral: [SopGeneral](), asuransi: [AsuransiDetail](), cancelSOP: [CancelSOP]()))
    
    private var supportedPetModelArray   = BehaviorRelay<[SupportedPet]>(value: [])
    private var petHotelImageModelArray   = BehaviorRelay<[PetHotelImage]>(value: [])
    private var fasilitasModelArray   = BehaviorRelay<[Fasilitas]>(value: [])
    private var sopGeneralModelArray   = BehaviorRelay<[SopGeneral]>(value: [])
    private var asuransiModelArray   = BehaviorRelay<[AsuransiDetail]>(value: [])
    private var cancelSOPModelArray   = BehaviorRelay<[CancelSOP]>(value: [])
    
    //MARK: - OBSERVER OBJECT DECLARATION
    private var petHotelDetailIDObservable : Observable<Int> {
        return petHotelDetailID.asObservable()
    }
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: Subviews
    private let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(named: "white")
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var carouselCollectionView: UICollectionView = {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: view.frame.size.width, height: view.frame.size.width)
        carouselLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        carouselLayout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.cellId)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var petTypeCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(PetTypeCollectionViewCell.self, forCellWithReuseIdentifier: PetTypeCollectionViewCell.cellId)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor(named: "grey2")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "white")
        pageControl.allowsContinuousInteraction = false
        return pageControl
    }()
    
    let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var roundedCorner:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "white")
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var exploreRect:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var petHotelInformation:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var petHotelName:ReuseableLabel = ReuseableLabel(labelText: "Pet Hotel Name", labelType: .titleH1, labelColor: .black)
    
    private lazy var locIcon: UIImageView = {
        let ImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        ImageView.image = UIImage(named: "mapIcon")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    private lazy var detailLocIcon: UIImageView = {
        let ImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        ImageView.image = UIImage(named: "mapIcon")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    private lazy var locationLabel:ReuseableLabel = ReuseableLabel(labelText: "Location", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var descriptionLabel:UILabel = {
        let label =  ReuseableLabel(labelText: "Penitipan Kucing di Katze Nesia Cat House merupakan layanan penitipan kucing terbaik. Mempunyai pengalaman sejak tahun 2015 dan menjadi tempat penitipan kucing terpercaya dan terekomendasi.", labelType: .bodyP2, labelColor: .grey1)
        label.textAlignment = .justified
        label.numberOfLines = 5
        return label
    }()
    
    private lazy var placeholderShortcut:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var petType:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var faciltyView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var locationView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var rulesView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var asuransiView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var cancelationView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var petTypeLabel:ReuseableLabel = ReuseableLabel(labelText: "Jenis Hewan", labelType: .titleH1, labelColor: .black)
    
    private lazy var fasilitasLabel:ReuseableLabel = ReuseableLabel(labelText: "Fasilitas yang Ditawarkan", labelType: .titleH1, labelColor: .black)
    
    private lazy var lokasi:ReuseableLabel = ReuseableLabel(labelText: "Lokasi", labelType: .titleH1, labelColor: .black)
    
    private lazy var peraturan:ReuseableLabel = ReuseableLabel(labelText: "Peraturan dan Kebijakan", labelType: .titleH1, labelColor: .black)
    
    private lazy var asuransi:ReuseableLabel = ReuseableLabel(labelText: "Asuransi dan Jaminan", labelType: .titleH1, labelColor: .black)
    
    private lazy var cancellation:ReuseableLabel = ReuseableLabel(labelText: "Kebijakan Pembatalan", labelType: .titleH1, labelColor: .black)
    
    private lazy var cancellationDescription:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Tidak ada pengembalian uang untuk reservasi ini. Tinjau kebijakan pembatalan lengkap Pet Hotel yang berlaku bahkan jika Anda membatalkan karena penyakit atau masalah tertentu.", labelType: .bodyP1, labelColor: .grey1)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var detailedLocation:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Jalan Ampera 102.D ruko no 4, Kelurahan Duren Jaya, Kecamatan Bekasi Timur, Kecamatan Rawalumbu, Kota Bekasi, Jawa Barat 17111", labelType: .bodyP1, labelColor: .grey1)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var seeAllFacilityButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Lihat Semua Fasilitas", styleBtn: .longOutline)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var seeLocationButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Lihat Peta Lokasi", styleBtn: .longOutline)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var seeRulesButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Lihat Semua Peraturan", styleBtn: .longOutline)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var seeAssuranceButton:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Lihat Semua Asuransi", styleBtn: .longOutline)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var facilityTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(FasilitasTableViewCell.self, forCellReuseIdentifier: FasilitasTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        return tableView
    }()
    
    private lazy var rulesTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(PetHotelDetailTableViewCell.self, forCellReuseIdentifier: PetHotelDetailTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        return tableView
    }()
    
    private lazy var assuranceTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(PetHotelDetailTableViewCell.self, forCellReuseIdentifier: PetHotelDetailTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        return tableView
    }()
    
    private lazy var btmBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Pilih Paket", showText: .notShow)
        
        customBar.translatesAutoresizingMaskIntoConstraints = false
        customBar.backgroundColor = UIColor(named: "primaryMain")
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "white")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
        return customBar
    }()
    
    private lazy var startFrom:ReuseableLabel = ReuseableLabel(labelText: "Mulai dari", labelType: .bodyP2, labelColor: .white)
    
    private lazy var perDay:ReuseableLabel = ReuseableLabel(labelText: "/hari", labelType: .bodyP2, labelColor: .white)
    
    private lazy var price:ReuseableLabel = ReuseableLabel(labelText: "Rp60.000", labelType: .titleH2, labelColor: .white)
    
    private lazy var btn1:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Hewan", styleBtn: .disabled)
        btn.configuration?.cornerStyle = .capsule
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.attributedTitle = AttributedString("Hewan", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 109).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    

    private lazy var btn2:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Fasilitas", styleBtn: .disabled)
        btn.configuration?.cornerStyle = .capsule
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.attributedTitle = AttributedString("Fasilitas", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 109).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    private lazy var btn3:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Lokasi", styleBtn: .disabled)
        btn.configuration?.cornerStyle = .capsule
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.attributedTitle = AttributedString("Lokasi", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 109).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    private lazy var btn4:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Peraturan", styleBtn: .disabled)
        btn.configuration?.cornerStyle = .capsule
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.attributedTitle = AttributedString("Peraturan", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 109).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    private lazy var btn5:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Asuransi", styleBtn: .disabled)
        btn.configuration?.cornerStyle = .capsule
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.attributedTitle = AttributedString("Asuransi", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 109).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    private lazy var btn6:ReusableButton = {
        let btn = ReusableButton(titleBtn: "Pembatalan", styleBtn: .disabled)
        btn.configuration?.cornerStyle = .capsule
        btn.configuration?.baseForegroundColor = UIColor(named: "grey1")
        btn.configuration?.baseBackgroundColor = UIColor(named: "grey3")
        btn.configuration?.attributedTitle = AttributedString("Pembatalan", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 12)!]))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 109).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.titleView = setTitle(title: "Pet Hotel Name", subtitle: "location")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryMain")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.addSubview(scrollView)
        view.addSubview(btmBar)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        btmBar.addSubview(startFrom)
        btmBar.addSubview(price)
        btmBar.addSubview(perDay)
        
        contentView.addSubview(exploreRect)
        contentView.addSubview(roundedCorner)
        
        exploreRect.addSubview(carouselCollectionView)
        exploreRect.addSubview(pageControl)

        petHotelInformation.addSubview(petHotelName)
        petHotelInformation.addSubview(locIcon)
        petHotelInformation.addSubview(locationLabel)
        petHotelInformation.addSubview(descriptionLabel)
        
        petType.addSubview(petTypeLabel)
        petType.addSubview(petTypeCollectionView)
        faciltyView.addSubview(fasilitasLabel)
        faciltyView.addSubview(facilityTableView)
        faciltyView.addSubview(seeAllFacilityButton)
        locationView.addSubview(lokasi)
        locationView.addSubview(detailLocIcon)
        locationView.addSubview(detailedLocation)
        locationView.addSubview(seeLocationButton)
        rulesView.addSubview(peraturan)
        rulesView.addSubview(rulesTableView)
        rulesView.addSubview(seeRulesButton)
        asuransiView.addSubview(asuransi)
        asuransiView.addSubview(assuranceTableView)
        asuransiView.addSubview(seeAssuranceButton)
        cancelationView.addSubview(cancellation)
        cancelationView.addSubview(cancellationDescription)
        
        stackView.addArrangedSubview(petHotelInformation)
        stackView.addArrangedSubview(petType)
        stackView.addArrangedSubview(faciltyView)
        stackView.addArrangedSubview(locationView)
        stackView.addArrangedSubview(rulesView)
        stackView.addArrangedSubview(asuransiView)
        stackView.addArrangedSubview(cancelationView)
        contentView.addSubview(stackView)
        
        stackView.addVerticalSeparators(color: UIColor(named: "grey2") ?? .systemGray2)
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelDetailIDObservable.subscribe(onNext: { [self] (value) in
            Task {
                petHotelViewModel.petHotelID.accept(value)
                await petHotelViewModel.fetchPetHotelDetail()
            }
        },onError: { error in
            self.present(errorAlert(), animated: true)
        }).disposed(by: bags)
    }
    
    //MARK: Initializers
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
        petHotelViewModel.genericHandlingErrorObserver.skip(1).subscribe(onNext: { [self] (value) in
            switch value {
            case .objectNotFound:
                self.present(genericAlert(titleAlert: "Pet Hotel Tidak Ada!", messageAlert: "Booking Order tidak ada, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true) {
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            case .success:
                print("Sukses Console 200")
            default:
                self.present(genericAlert(titleAlert: "Terjadi Gangguan server!", messageAlert: "Terjadi kesalahan dalam melakukan pencarian booking, silahkan coba lagi nanti.", buttonText: "Ok"), animated: true) {
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
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
        petHotelViewModel.petHotelModelArrayObserver.subscribe(onNext: { [self] (value) in
            DispatchQueue.main.async { [self] in
                navigationItem.titleView = setTitle(title: value.petHotelName, subtitle: "\(value.petHotelAddress),\(value.petHotelProvinsi)")
                petHotelName.text     = value.petHotelName
                descriptionLabel.text = value.petHotelDescription
                detailedLocation.text = "\(value.petHotelAddress), \(value.petHotelKelurahan), \(value.petHotelKecamatan), \(value.petHotelKota), \(value.petHotelProvinsi) \(value.petHotelPos)"
                locationLabel.text    = "\(value.petHotelKota), \(value.petHotelProvinsi)"
                price.text            = "Rp.\(value.petHotelStartPrice)"
                var cancelSop = String()
                for sop in value.cancelSOP {
                    cancelSop += "\(sop.cancelSopsDescription)\n\n"
                }
                cancellationDescription.text = cancelSop
                
                // Array Initialization
                supportedPetModelArray.accept(value.supportedPet)
                petHotelImageModelArray.accept(value.petHotelImage)
                fasilitasModelArray.accept(value.fasilitas)
                sopGeneralModelArray.accept(value.sopGeneral)
                asuransiModelArray.accept(value.asuransi)
                cancelSOPModelArray.accept(value.cancelSOP)
                petHotelModel.accept(value)
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
        supportedPetModelArray.bind(to: petTypeCollectionView.rx.items(cellIdentifier:  PetTypeCollectionViewCell.cellId, cellType: PetTypeCollectionViewCell.self)) { row, model, cell in
            cell.configure(model, model.supportedPetTypes)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        petHotelImageModelArray.bind(to: carouselCollectionView.rx.items(cellIdentifier:  CarouselCollectionViewCell.cellId, cellType: CarouselCollectionViewCell.self)) { row, model, cell in
            cell.configure(model)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        fasilitasModelArray.bind(to: facilityTableView.rx.items(cellIdentifier:  FasilitasTableViewCell.cellId, cellType: FasilitasTableViewCell.self)) { row, model, cell in
            cell.configure(model)
            cell.backgroundColor = .clear
        }.disposed(by: bags)
        
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        asuransiModelArray.bind(to: assuranceTableView.rx.items(cellIdentifier:  PetHotelDetailTableViewCell.cellId, cellType: PetHotelDetailTableViewCell.self)) { row, model, cell in
            cell.configureView(tabelType: "asuransi", description: model.asuransiDescription)
            cell.backgroundColor = .clear
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        sopGeneralModelArray.bind(to: rulesTableView.rx.items(cellIdentifier:  PetHotelDetailTableViewCell.cellId, cellType: PetHotelDetailTableViewCell.self)) { row, model, cell in
            cell.configureView(tabelType: "rules", description: model.sopGeneralsDescription)
            cell.backgroundColor = .clear
        }.disposed(by: bags)
       
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        seeAllFacilityButton.rx.tap.bind { [self] in
            let vc = FasilitasViewController()
            vc.fasilitasModelArray.accept(fasilitasModelArray.value)
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        }.disposed(by: bags)
            
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        seeRulesButton.rx.tap.bind { [self] in
            let vc = RulesViewController()
            vc.sopGeneralModelArray.accept(sopGeneralModelArray.value)
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        seeAssuranceButton.rx.tap.bind { [self] in
            let vc = AsuransiViewController()
            vc.asuransiModelArray.accept(asuransiModelArray.value)
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        seeLocationButton.rx.tap.bind { [self] in
            petHotelViewModel.locationObject.accept(Location(longitude: Double(petHotelModel.value.petHotelLongitude)!, latitude: Double(petHotelModel.value.petHotelLatitude)!))
            petHotelViewModel.openGoogleMap()
        }.disposed(by: bags)
        
        //MARK: - Observer for Pet Type Value
        /// Returns boolean true or false
        /// from the given components.
        /// - Parameters:
        ///     - allowedCharacter: character subset that's allowed to use on the textfield
        ///     - text: set of character/string that would like  to be checked.
        btmBar.barBtn.rx.tap.bind {
            let vc = SelectBookingDetailsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bags)
    }
}

//MARK: Setups
@available(iOS 16.0, *)
extension PetHotelViewController{
    func setupViews(){
        //MARK: Scroll View Constraints
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: btmBar.topAnchor).isActive = true
        
        //MARK: COntent view constraint
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        //MARK: Carousel Collection View Constraint
        carouselCollectionView.leftAnchor.constraint(equalTo: exploreRect.leftAnchor).isActive = true
        carouselCollectionView.rightAnchor.constraint(equalTo: exploreRect.rightAnchor).isActive = true
        carouselCollectionView.bottomAnchor.constraint(equalTo: exploreRect.bottomAnchor).isActive = true
        carouselCollectionView.topAnchor.constraint(equalTo: exploreRect.topAnchor).isActive = true
        carouselCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        //MARK: Page COntrol Constraint
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: -48).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: exploreRect.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
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
    
        //MARK: placeholder carousel view constraints
        exploreRect.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        exploreRect.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        exploreRect.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        exploreRect.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        exploreRect.heightAnchor.constraint(equalTo: exploreRect.widthAnchor).isActive = true
        
        //MARK: rounded corner constraints
        roundedCorner.bottomAnchor.constraint(equalTo: exploreRect.bottomAnchor).isActive = true
        roundedCorner.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        roundedCorner.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        roundedCorner.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //MARK: stackview constraintw
        stackView.topAnchor.constraint(equalTo: roundedCorner.topAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        //MARK: pet hotel information constraint
        petHotelInformation.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        petHotelInformation.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        petHotelInformation.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        petHotelInformation.heightAnchor.constraint(greaterThanOrEqualToConstant: 175).isActive = true
        
        //MARK: pet hotel name constraint
        petHotelName.topAnchor.constraint(equalTo: petHotelInformation.topAnchor).isActive = true
        petHotelName.leftAnchor.constraint(equalTo: petHotelInformation.leftAnchor).isActive = true
        petHotelName.rightAnchor.constraint(equalTo: petHotelInformation.rightAnchor).isActive = true
        petHotelName.heightAnchor.constraint(equalToConstant: 36).isActive = true

        //MARK: loc icon constraint
        locIcon.leftAnchor.constraint(equalTo: petHotelInformation.leftAnchor).isActive = true
        locIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        locIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        locIcon.topAnchor.constraint(equalTo: petHotelName.bottomAnchor, constant: 20).isActive = true
        
        //MARK: loc label constraint
        locationLabel.topAnchor.constraint(equalTo: locIcon.topAnchor).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: locIcon.rightAnchor, constant: 12).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: petHotelInformation.rightAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //MARK: desc label constrainr
        descriptionLabel.topAnchor.constraint(equalTo: locIcon.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: petHotelInformation.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: petHotelInformation.rightAnchor).isActive = true
    
        //MARK: pet type view constrainr
        petType.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        petType.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        petType.heightAnchor.constraint(greaterThanOrEqualToConstant: 148).isActive = true

        //MARK: pet type label constraint
        petTypeLabel.topAnchor.constraint(equalTo: petType.topAnchor).isActive = true
        petTypeLabel.leftAnchor.constraint(equalTo: petType.leftAnchor).isActive = true
        petTypeLabel.rightAnchor.constraint(equalTo: petType.rightAnchor).isActive = true
        
        //MARK: pet tyoe collection view constraint
        petTypeCollectionView.topAnchor.constraint(equalTo: petTypeLabel.bottomAnchor, constant: 20).isActive = true
        petTypeCollectionView.leftAnchor.constraint(equalTo: petType.leftAnchor).isActive = true
        petTypeCollectionView.rightAnchor.constraint(equalTo: petType.rightAnchor).isActive = true
        petTypeCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        petTypeCollectionView.bottomAnchor.constraint(equalTo: petType.bottomAnchor, constant: -20).isActive = true
        
        //MARK: facilty view constraint
        faciltyView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        faciltyView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        faciltyView.heightAnchor.constraint(greaterThanOrEqualToConstant: 307).isActive = true

        //MARK: facility label constraint
        fasilitasLabel.topAnchor.constraint(equalTo: faciltyView.topAnchor).isActive = true
        fasilitasLabel.leftAnchor.constraint(equalTo: faciltyView.leftAnchor).isActive = true
        fasilitasLabel.rightAnchor.constraint(equalTo: faciltyView.rightAnchor).isActive = true
        
        //MARK: facility button constraint
        seeAllFacilityButton.bottomAnchor.constraint(equalTo: faciltyView.bottomAnchor).isActive = true
        seeAllFacilityButton.leftAnchor.constraint(equalTo: faciltyView.leftAnchor).isActive = true
        seeAllFacilityButton.rightAnchor.constraint(equalTo: faciltyView.rightAnchor).isActive = true
        seeAllFacilityButton.topAnchor.constraint(equalTo: facilityTableView.bottomAnchor, constant: 20).isActive = true
        
        //MARK: facility table view const
        facilityTableView.leftAnchor.constraint(equalTo: faciltyView.leftAnchor).isActive = true
        facilityTableView.rightAnchor.constraint(equalTo: faciltyView.rightAnchor).isActive = true
        facilityTableView.topAnchor.constraint(equalTo: fasilitasLabel.bottomAnchor, constant: 20).isActive = true
        facilityTableView.bottomAnchor.constraint(equalTo: seeAllFacilityButton.topAnchor, constant: -20).isActive = true
        facilityTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 205).isActive = true
        
        //MARK: location view const
        locationView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        locationView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        locationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        
        //MARK: loc label const
        lokasi.topAnchor.constraint(equalTo: locationView.topAnchor).isActive = true
        lokasi.leftAnchor.constraint(equalTo: locationView.leftAnchor).isActive = true
        lokasi.rightAnchor.constraint(equalTo: locationView.rightAnchor).isActive = true
        
        //MARK: detail loc icon const
        detailLocIcon.topAnchor.constraint(equalTo: lokasi.bottomAnchor, constant: 20).isActive = true
        detailLocIcon.leftAnchor.constraint(equalTo: locationView.leftAnchor).isActive = true
        detailLocIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        detailLocIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //MARK: loc desc const
        detailedLocation.leftAnchor.constraint(equalTo: detailLocIcon.rightAnchor, constant: 12).isActive = true
        detailedLocation.topAnchor.constraint(equalTo: detailLocIcon.topAnchor).isActive = true
        detailedLocation.rightAnchor.constraint(equalTo: locationView.rightAnchor).isActive = true
        
        //MARK: loc btn const
        seeLocationButton.bottomAnchor.constraint(equalTo: locationView.bottomAnchor).isActive = true
        seeLocationButton.leftAnchor.constraint(equalTo: locationView.leftAnchor).isActive = true
        seeLocationButton.rightAnchor.constraint(equalTo: locationView.rightAnchor).isActive = true
        
        //MARK: rules view const
        rulesView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        rulesView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        rulesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 276).isActive = true

        //MARK: rules btn const
        seeRulesButton.bottomAnchor.constraint(equalTo: rulesView.bottomAnchor).isActive = true
        seeRulesButton.leftAnchor.constraint(equalTo: rulesView.leftAnchor).isActive = true
        seeRulesButton.rightAnchor.constraint(equalTo: rulesView.rightAnchor).isActive = true
        seeRulesButton.topAnchor.constraint(equalTo: rulesTableView.bottomAnchor, constant: 4).isActive = true
        
        //MARK: rules label const
        peraturan.topAnchor.constraint(equalTo: rulesView.topAnchor).isActive = true
        peraturan.leftAnchor.constraint(equalTo: rulesView.leftAnchor).isActive = true
        peraturan.rightAnchor.constraint(equalTo: rulesView.rightAnchor).isActive = true
        
        //MARK: rules table view const
        rulesTableView.leftAnchor.constraint(equalTo: rulesView.leftAnchor).isActive = true
        rulesTableView.rightAnchor.constraint(equalTo: rulesView.rightAnchor).isActive = true
        rulesTableView.topAnchor.constraint(equalTo: peraturan.bottomAnchor, constant: 20).isActive = true
        rulesTableView.bottomAnchor.constraint(equalTo: seeRulesButton.topAnchor, constant: -4).isActive = true
        rulesTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 152).isActive = true
        
        //MARK: asurrance view const
        asuransiView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        asuransiView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        asuransiView.heightAnchor.constraint(greaterThanOrEqualToConstant: 276).isActive = true
        
        //MARK: assurance label constraint
        asuransi.topAnchor.constraint(equalTo: asuransiView.topAnchor).isActive = true
        asuransi.leftAnchor.constraint(equalTo: asuransiView.leftAnchor).isActive = true
        asuransi.rightAnchor.constraint(equalTo: asuransiView.rightAnchor).isActive = true
        
        //MARK: assurance button constraint
        seeAssuranceButton.bottomAnchor.constraint(equalTo: asuransiView.bottomAnchor).isActive = true
        seeAssuranceButton.leftAnchor.constraint(equalTo: asuransiView.leftAnchor).isActive = true
        seeAssuranceButton.rightAnchor.constraint(equalTo: asuransiView.rightAnchor).isActive = true
        seeAssuranceButton.topAnchor.constraint(equalTo: assuranceTableView.bottomAnchor, constant: 4).isActive = true
        
        //MARK: asurance table view constriant
        assuranceTableView.leftAnchor.constraint(equalTo: asuransiView.leftAnchor).isActive = true
        assuranceTableView.rightAnchor.constraint(equalTo: asuransiView.rightAnchor).isActive = true
        assuranceTableView.topAnchor.constraint(equalTo: asuransi.bottomAnchor, constant: 20).isActive = true
        assuranceTableView.bottomAnchor.constraint(equalTo: seeAssuranceButton.topAnchor, constant: -4).isActive = true
        
        //MARK: cancellation view constraint
        cancelationView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        cancelationView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        cancelationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        
        //MARK: cancellation desc const
        cancellationDescription.leftAnchor.constraint(equalTo: cancelationView.leftAnchor).isActive = true
        cancellationDescription.rightAnchor.constraint(equalTo: cancelationView.rightAnchor).isActive = true
        cancellationDescription.topAnchor.constraint(equalTo: cancellation.bottomAnchor, constant: 20).isActive = true
    }
}

// MARK: - UICollectionView Delegate
@available(iOS 16.0, *)
extension PetHotelViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = petHotelViewModel.getCurrentPage(carouselCollectionView, currentPage)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = petHotelViewModel.getCurrentPage(carouselCollectionView, currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = petHotelViewModel.getCurrentPage(carouselCollectionView, currentPage)
    }
}

//MARK: UI STAck View add Separator
extension UIStackView {
    func addVerticalSeparators(color : UIColor) {
        let separatorsToAdd = self.arrangedSubviews.count - 1
        var insertAt = 1
        for _ in 1...separatorsToAdd {
            let separator = createSeparator(color: color)
            insertArrangedSubview(separator, at: insertAt)
            insertAt += 2
            separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
            separator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        }
    }
    
    private func createSeparator(color : UIColor) -> UIView {
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = color
        return separator
    }
}

//MARK: Navigation Title
@available(iOS 16.0, *)
extension PetHotelViewController{
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
    
    func makeTransparentNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
