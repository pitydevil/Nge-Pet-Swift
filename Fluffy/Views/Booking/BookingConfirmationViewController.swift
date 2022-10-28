//
//  BookingConfirmationViewController.swift
//  Fluffy
//
//  Created by Jessica Geofanie on 26/10/22.
//

import UIKit

class BookingConfirmationViewController: UIViewController {

    //MARK: Subviews
    private let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var navTitle:ReuseableLabel = ReuseableLabel(labelText: "Konfirmasi Pesanan", labelType: .titleH2, labelColor: .black)
    
    private lazy var petHoteView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var petHotelLabelView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var detailPesananView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var detailHargaView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var paymentInstructionView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var cancellationView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var informationView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var btmBar: ReusableTabBar = {
        let customBar = ReusableTabBar(btnText: "Pesan", showText: .notShow)
//        customBar.barBtn.addTarget(self, action: #selector(pilihPaket), for: .touchUpInside)
        customBar.translatesAutoresizingMaskIntoConstraints = false
        customBar.backgroundColor = UIColor(named: "primaryMain")
        customBar.barBtn.configuration?.baseBackgroundColor = UIColor(named: "white")
        customBar.barBtn.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
        return customBar
    }()
    
    private lazy var totalHarga:ReuseableLabel = ReuseableLabel(labelText: "Total Harga", labelType: .bodyP2, labelColor: .white)
    
    
    private lazy var price:ReuseableLabel = ReuseableLabel(labelText: "Rp60.000", labelType: .titleH2, labelColor: .white)
    
    private lazy var petHotelName:ReuseableLabel = ReuseableLabel(labelText: "Pet Hotel Name", labelType: .titleH2, labelColor: .black)
    
    private lazy var paymentInstruction:ReuseableLabel = ReuseableLabel(labelText: "Instruksi Pembayaran", labelType: .titleH2, labelColor: .black)
    
    private lazy var cancellationPolicy:ReuseableLabel = ReuseableLabel(labelText: "Kebijakan Pembatalan", labelType: .titleH2, labelColor: .black)
    
    private lazy var tanggalPemesanan:ReuseableLabel = ReuseableLabel(labelText: "Tanggal Pesanan", labelType: .titleH2, labelColor: .black)
    
    private lazy var detailHarga:ReuseableLabel = ReuseableLabel(labelText: "Detail Harga", labelType: .titleH2, labelColor: .black)
    
    private lazy var hewanPeliharaanDanPaket:ReuseableLabel = ReuseableLabel(labelText: "Hewan Peliharaan dan Paket", labelType: .titleH2, labelColor: .black)
    
    
    private lazy var lokasi:ReuseableLabel = ReuseableLabel(labelText: "Bekasi, Jawa Barat", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var detailTanggal:ReuseableLabel = ReuseableLabel(labelText: "Sep 25 - 26", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var detailCancellation:ReuseableLabel = ReuseableLabel(labelText: "Tidak ada pengembalian uang untuk pesanan ini.", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var detailPaymentInstruction:ReuseableLabel = ReuseableLabel(labelText: "Bawa hewan peliharaan kamu ke Pet Hotel dan berikan Order Id yang dapat kamu lihat pada halaman Booking kepada pihak Pet Hotel.", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var detailInstruction:ReuseableLabel = ReuseableLabel(labelText: "Pesanan kamu tidak akan dikonfirmasi sampai pihak Pet Hotel menerima permintaan kamu dalam 24 jam.", labelType: .bodyP2, labelColor: .grey1)
    
    private lazy var persetujuan:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "Dengan memilih tombol Pesan di bawah, Saya setuju dengan Peraturan dan Kebijakan serta Asuransi dan Jaminan yang diberikan oleh Pet Hotel. Saya setuju untuk membayar total biaya yang ditentukan jika Pet Hotel menerima permintaan reservasi saya.", labelType: .bodyP2, labelColor: .grey1)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var total:ReuseableLabel = ReuseableLabel(labelText: "Total", labelType: .titleH3, labelColor: .black)
    
    private lazy var totalHargaDetail:ReuseableLabel = {
        let label = ReuseableLabel(labelText: "", labelType: .bodyP2, labelColor: .grey1)
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var petHotelImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var icon:UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "fluent_text-bullet-list-square-clock-20-filled")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var editPesanan: ReusableButton = {
        let barBtnLewati = ReusableButton(titleBtn: "Edit", styleBtn: .light)
        barBtnLewati.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
//        barBtnLewati.addTarget(self, action: #selector(skipModal), for: .touchUpInside)
        return barBtnLewati
    }()
    
    private lazy var editHewanPeliharaanDanPaket: ReusableButton = {
        let barBtnLewati = ReusableButton(titleBtn: "Edit", styleBtn: .light)
        barBtnLewati.configuration?.baseForegroundColor = UIColor(named: "primaryMain")
//        barBtnLewati.addTarget(self, action: #selector(skipModal), for: .touchUpInside)
        return barBtnLewati
    }()
    
    private lazy var detailHargaTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(HargaTableViewCell.self, forCellReuseIdentifier: HargaTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        tableView.invalidateIntrinsicContentSize()
        return tableView
    }()
    
    private lazy var detailPaketTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(paketTableViewCell.self, forCellReuseIdentifier: paketTableViewCell.cellId)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "white")
        tableView.invalidateIntrinsicContentSize()
        return tableView
    }()
    
    //MARK: properties
    private var numPackage = 1
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white")
        self.navigationItem.titleView = navTitle
        //MARK: Call To Setup Label, image, table, etc
        setupUI()
        
        //MARK: add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        petHoteView.addSubview(petHotelImage)
        petHotelLabelView.addSubview(petHotelName)
        petHotelLabelView.addSubview(lokasi)
        petHoteView.addSubview(petHotelLabelView)
        stackView.addArrangedSubview(petHoteView)
        
        detailPesananView.addSubview(tanggalPemesanan)
        detailPesananView.addSubview(detailTanggal)
        detailPesananView.addSubview(editPesanan)
        detailPesananView.addSubview(editHewanPeliharaanDanPaket)
        detailPesananView.addSubview(hewanPeliharaanDanPaket)
        detailPesananView.addSubview(detailPaketTableView)
        stackView.addArrangedSubview(detailPesananView)
        
        detailHargaView.addSubview(detailHarga)
        detailHargaView.addSubview(detailHargaTableView)
        detailHargaView.addSubview(total)
        detailHargaView.addSubview(totalHargaDetail)
        stackView.addArrangedSubview(detailHargaView)
        
        paymentInstructionView.addSubview(paymentInstruction)
        paymentInstruction.addSubview(detailPaymentInstruction)
        stackView.addArrangedSubview(paymentInstructionView)
        
        cancellationView.addSubview(cancellationPolicy)
        cancellationView.addSubview(detailCancellation)
        stackView.addArrangedSubview(cancellationView)
        
        informationView.addSubview(icon)
        informationView.addSubview(detailInstruction)
        stackView.addArrangedSubview(informationView)
        
        stackView.addArrangedSubview(persetujuan)
        view.addSubview(btmBar)
        stackView.addVerticalSeparators(color: UIColor(named: "grey2") ?? .systemGray2)
        
        btmBar.addSubview(totalHarga)
        btmBar.addSubview(price)
        
        setupConstraint()
    }
    
}

extension BookingConfirmationViewController{
    func setupUI(){
        numPackage = 2
        petHotelImage.image = UIImage(named: "slide1")
        totalHargaDetail.text = "Rp 70.000"
    }
}


extension BookingConfirmationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numPackage
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == detailHargaTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: HargaTableViewCell.cellId) as! HargaTableViewCell
            cell.backgroundColor = .clear
            cell.configureView(detailHargaString: "Rp 70.000 x 1 hari", description: "Rp 70.000")
            return cell
        }
        if tableView == detailPaketTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: paketTableViewCell.cellId) as! paketTableViewCell
            cell.backgroundColor = .clear
            cell.configureView(detailPaketString: "Chiron - Plus (2 catatan khusus)")
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 18
    }

}

extension BookingConfirmationViewController{
    func setupConstraint(){
        //MARK: Scroll View Constraints
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: btmBar.topAnchor).isActive = true
        
        //MARK: COntent view constraint
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        //MARK: stackview constraintw
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        //MARK: tabbar constraint
        btmBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        btmBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        btmBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //MARK: total harga consstraint
        totalHarga.topAnchor.constraint(equalTo: btmBar.topAnchor, constant: 20).isActive = true
        totalHarga.leftAnchor.constraint(equalTo: btmBar.leftAnchor, constant: 24).isActive = true
        totalHarga.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        //MARK: price constraint
        price.topAnchor.constraint(equalTo: totalHarga.bottomAnchor).isActive = true
        price.leftAnchor.constraint(equalTo: totalHarga.leftAnchor).isActive = true
        price.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
        //MARK: Pet HOtel Information VIew Constraint
        petHoteView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        petHoteView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        petHoteView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        petHoteView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        
        //MARK: detail PEsanan view constraint
        detailPesananView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        detailPesananView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        detailPesananView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        
        //MARK: detail harga view constraint
        detailHargaView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        detailHargaView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        detailHargaView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        //MARK: payment instruction view constraint
        paymentInstructionView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        paymentInstructionView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        paymentInstructionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        
        //MARK:
        cancellationView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        cancellationView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        cancellationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        //MARK:
        informationView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        informationView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        informationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        //MARK:
        persetujuan.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        persetujuan.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        persetujuan.heightAnchor.constraint(greaterThanOrEqualToConstant: 86).isActive = true
        
        //MARK: Pet Hotel Image Constraint
        petHotelImage.translatesAutoresizingMaskIntoConstraints = false
        petHotelImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        petHotelImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        petHotelImage.leftAnchor.constraint(equalTo: petHoteView.leftAnchor).isActive = true
        petHotelImage.topAnchor.constraint(equalTo: petHoteView.topAnchor).isActive = true
        petHotelImage.bottomAnchor.constraint(equalTo: petHoteView.bottomAnchor).isActive = true
        petHotelImage.backgroundColor = .systemBlue
        
        //MARK: Pet Hotel Label Constraint
        petHotelLabelView.leftAnchor.constraint(equalTo: petHotelImage.rightAnchor, constant: 16).isActive = true
        petHotelLabelView.rightAnchor.constraint(equalTo: petHoteView.rightAnchor).isActive = true
        petHotelLabelView.centerYAnchor.constraint(equalTo: petHoteView.centerYAnchor).isActive = true
        petHotelLabelView.heightAnchor.constraint(greaterThanOrEqualToConstant:50).isActive = true
        
        //MARK: Pet Hotel Name Constraint
        petHotelName.leftAnchor.constraint(equalTo: petHotelLabelView.leftAnchor).isActive = true
        petHotelName.rightAnchor.constraint(equalTo: petHotelLabelView.rightAnchor).isActive = true
        petHotelName.topAnchor.constraint(equalTo: petHotelLabelView.topAnchor).isActive = true
        
        //MARK: Lokasi constraint
        lokasi.topAnchor.constraint(equalTo: petHotelName.bottomAnchor, constant: 8).isActive = true
        lokasi.leftAnchor.constraint(equalTo: petHotelLabelView.leftAnchor).isActive = true
        lokasi.rightAnchor.constraint(equalTo: petHotelLabelView.rightAnchor).isActive = true
        
        //MARK: payment instruction view constraint
        paymentInstruction.leftAnchor.constraint(equalTo: paymentInstructionView.leftAnchor).isActive = true
        paymentInstruction.topAnchor.constraint(equalTo: paymentInstructionView.topAnchor).isActive = true
        paymentInstruction.rightAnchor.constraint(equalTo: paymentInstructionView.rightAnchor).isActive = true
        
        //MARK: detail Payment instruction constraint
        detailPaymentInstruction.leftAnchor.constraint(equalTo: paymentInstruction.leftAnchor).isActive = true
        detailPaymentInstruction.rightAnchor.constraint(equalTo: paymentInstruction.rightAnchor).isActive = true
        detailPaymentInstruction.topAnchor.constraint(equalTo: paymentInstruction.bottomAnchor, constant: 8).isActive = true
        detailPaymentInstruction.bottomAnchor.constraint(equalTo: paymentInstructionView.bottomAnchor).isActive = true
        
        //MARK: cancellation policy constraint
        cancellationPolicy.leftAnchor.constraint(equalTo: cancellationView.leftAnchor).isActive = true
        cancellationPolicy.topAnchor.constraint(equalTo: cancellationView.topAnchor).isActive = true
        cancellationPolicy.rightAnchor.constraint(equalTo: cancellationView.rightAnchor).isActive = true
        
        //MARK: detail cancellation constraint
        detailCancellation.leftAnchor.constraint(equalTo: cancellationPolicy.leftAnchor).isActive = true
        detailCancellation.rightAnchor.constraint(equalTo: cancellationPolicy.rightAnchor).isActive = true
        detailCancellation.topAnchor.constraint(equalTo: cancellationPolicy.bottomAnchor, constant: 8).isActive = true
        detailCancellation.bottomAnchor.constraint(equalTo: cancellationView.bottomAnchor).isActive = true
        
        //MARK: icon constraint
        icon.topAnchor.constraint(equalTo: informationView.topAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: informationView.leftAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //MARK: detail instruction constraint
        detailInstruction.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16).isActive = true
        detailInstruction.rightAnchor.constraint(equalTo: informationView.rightAnchor).isActive = true
        detailInstruction.topAnchor.constraint(equalTo: informationView.topAnchor).isActive = true
        detailInstruction.bottomAnchor.constraint(equalTo: informationView.bottomAnchor).isActive = true
        
        //MARK: tanggl pemesanan constraint
        tanggalPemesanan.topAnchor.constraint(equalTo: detailPesananView.topAnchor).isActive = true
        tanggalPemesanan.leftAnchor.constraint(equalTo: detailPesananView.leftAnchor)
        .isActive = true
        tanggalPemesanan.rightAnchor.constraint(equalTo: editPesanan.rightAnchor, constant: -20).isActive = true
        
        //MARK: detail tanggal constraint
        detailTanggal.topAnchor.constraint(equalTo: tanggalPemesanan.bottomAnchor, constant: 8).isActive = true
        detailTanggal.leftAnchor.constraint(equalTo: detailPesananView.leftAnchor).isActive = true
        detailTanggal.rightAnchor.constraint(equalTo: detailPesananView.rightAnchor).isActive = true
        
        //MARK: hewan peliharaan dan paket constraint
        hewanPeliharaanDanPaket.topAnchor.constraint(equalTo: detailTanggal.bottomAnchor, constant: 20).isActive = true
        hewanPeliharaanDanPaket.leftAnchor.constraint(equalTo: detailPesananView.leftAnchor)
        .isActive = true
        hewanPeliharaanDanPaket.rightAnchor.constraint(equalTo: detailPesananView.rightAnchor).isActive = true
        hewanPeliharaanDanPaket.rightAnchor.constraint(equalTo: detailPesananView.leftAnchor, constant: -20).isActive = true
        
        //MARK: edit pesanan constraint
        editPesanan.rightAnchor.constraint(equalTo: detailPesananView.rightAnchor).isActive = true
        editPesanan.topAnchor.constraint(equalTo: detailPesananView.topAnchor).isActive = true
        editPesanan.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        //MARK: edit paket constraint
        editHewanPeliharaanDanPaket.rightAnchor.constraint(equalTo: detailPesananView.rightAnchor).isActive = true
        editHewanPeliharaanDanPaket.topAnchor.constraint(equalTo: hewanPeliharaanDanPaket.topAnchor).isActive = true
        editHewanPeliharaanDanPaket.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        //MARK: detail harga constraint
        detailHarga.leftAnchor.constraint(equalTo: detailHargaView.leftAnchor).isActive = true
        detailHarga.topAnchor.constraint(equalTo: detailHargaView.topAnchor).isActive = true
        detailHarga.rightAnchor.constraint(equalTo: detailHargaView.rightAnchor).isActive = true
        
        //MARK: detail harga table view constraint
        detailHargaTableView.topAnchor.constraint(equalTo: detailHarga.bottomAnchor, constant: 8).isActive = true
        detailHargaTableView.leftAnchor.constraint(equalTo: detailHargaView.leftAnchor).isActive = true
        detailHargaTableView.rightAnchor.constraint(equalTo: detailHargaView.rightAnchor).isActive = true
        detailHargaTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(numPackage*18)).isActive = true
        
        //MARK: total constraint
        total.topAnchor.constraint(equalTo: detailHargaTableView.bottomAnchor).isActive = true
        total.leftAnchor.constraint(equalTo: detailHargaView.leftAnchor).isActive = true
        total.rightAnchor.constraint(greaterThanOrEqualTo: totalHargaDetail.leftAnchor, constant: -20).isActive = true
        total.widthAnchor.constraint(equalToConstant: 245).isActive = true
        total.bottomAnchor.constraint(equalTo: detailHargaView.bottomAnchor).isActive = true
        
        //MARK: total harga detail constraint
        totalHargaDetail.topAnchor.constraint(equalTo: total.topAnchor).isActive = true
        totalHargaDetail.rightAnchor.constraint(equalTo: detailHargaView.rightAnchor).isActive = true
        totalHargaDetail.bottomAnchor.constraint(equalTo: detailHargaView.bottomAnchor).isActive = true
        
        //MARK: detail paket table view constraint
        detailPaketTableView.topAnchor.constraint(equalTo: hewanPeliharaanDanPaket.bottomAnchor, constant: 8).isActive = true
        detailPaketTableView.bottomAnchor.constraint(equalTo: detailPesananView.bottomAnchor).isActive = true
        detailPaketTableView.leftAnchor.constraint(equalTo: detailPesananView.leftAnchor).isActive = true
        detailPaketTableView.rightAnchor.constraint(equalTo: detailPesananView.rightAnchor).isActive = true
        detailPaketTableView.heightAnchor.constraint(equalToConstant: CGFloat(numPackage*18)).isActive = true
    }
}
