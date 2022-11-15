//
//  Enum.swift
//  Fluffy
//
//  Created by Mikhael Adiputra on 23/10/22.
//

import Foundation

//MARK: - NETWORKING ENUMERATION DECLARATION
enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
}

enum ApplicationEndpoint {
    case getOrderList(orderStatus : String)
    case getDetailOrderID(orderID : Int)
    case getNearest(longitude : Double, latitude : Double)
    case postOrder(order: [AddOrder])
    case getPetHotelDetail(petHotelID : Int)
    case getListMonitoring(MonitoringBody : MonitoringBody) 
    case getPetHotelPackage(petHotelID: Int, supportedPetName: String)
    case getSearchListPetHotel(exploreSearchBody : ExploreSearchBody)
}

enum genericHandlingError : Int {
    case objectNotFound  = 404
    case methodNotFound  = 405
    case tooManyRequest  = 429
    case success         = 200
    case unexpectedError = 500
}

//MARK: - PET ENUMERATION DECLARATION
enum genderCase : String {
    case female = "female"
    case male   = "male"
}

enum petSizeCase : String {
    case kecil  = "Kecil"
    case sedang = "Sedang"
    case besar  = "Besar"
}

enum petTypeCase : String {
    case kucing = "Kucing"
    case anjing = "Anjing"
}

enum petIconCase : String {
    case dog1 = "dog1"
    case dog2 = "dog2"
    case dog3 = "dog3"
    case dog4 = "dog4"
    case dog5 = "dog5"
    case dog6 = "dog6"
    case dog7 = "dog7"
    case dog8 = "dog8"
    case dog9 = "dog9"
}

enum addPetErrorCase  {
    case petIconTidakAda(errorTitle   : String = "Ikon Hewan Tidak Ada!", errorMessage : String = "Kamu Belum Memilih Ikon Pet Kamu")
    case petBreedTidakAda(errorTitle  : String = "Ras Hewan Tidak Ada!", errorMessage : String = "Kamu Belum Memilih Ras Hewan kamu!")
    case petGenderTidakAda(errorTitle : String = "Jenis Kelamin Hewan Tidak Ada!", errorMessage : String = "Kamu Belum Memilih Jenis Kelamin Hewan Kamu!")
    case petNameTidakAda(errorTitle : String = "Nama Hewan Tidak Ada!", errorMessage : String   = "Kamu Belum Mengisi Nama Hewan Kamu!")
    case petSizeTidakAda(errorTitle : String = "Ukuran Hewan Tidak Ada!", errorMessage : String = "Kamu Belum Memilih Ukuran Hewan Kamu")
    case petTypeTidakAda(errorTitle : String = "Tipe Hewan Tidak Ada!", errorMessage : String   = "Kamu Belum Memilih Tipe Hewan Kamu")
    case petAgeTidakAda(errorTitle : String = "Umur Hewan Tidak Ada!", errorMessage : String   = "Kamu Belum Mengisi Umur Hewan Kamu")
    case petAddGagal(errorTitle : String = "Gagal Menambah Data!", errorMessage : String   = "Telah terjadi kesalahan dalam menginput hewan peliharaan kamu, silahkan coba lagi nanti")
    case sukses(errorTitle : String = "Sukses!", errorMessage : String =  "Data Hewan Perliharaan Kamu Berhasil Ditambahkan!")
}

enum removePetErrorCase  {
    case gagalBuangPet(errorTitle   : String = "Gagal Menghapus Pet!", errorMessage : String = "Terjadi kegagalan dalam menghapus hewan peliharaan kamu, silahkan coba lagi nanti")
    case sukses(errorTitle : String = "Sukses!", errorMessage : String =  "Data Hewan Perliharaan Kamu Berhasil Dibuang!")
}

//MARK: - BOOKING ENUMERATION DECLARATION
enum bookingPesananCase : String {
    case aktif   = "aktif"
    case riwayat = "riwayat"
}

//MARK: -MONITORING ENUMERATION DECLARATION
enum monitoringCase  {
    case empty
    case terisi
}

enum stateSelectectionCase  {
    case full
    case kosong
    case parsial(jumlah : Int)
}
