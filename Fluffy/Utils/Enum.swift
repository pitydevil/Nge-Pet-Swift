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
    case getEtalaseById(id : String)
    case getAllEtalase
    case postConsultation(etalaseID: String, companyName : String, url1 : String, url2: String, shortDescription: String, problemDescription : String, marketingBudget : Double, userID : String)
    case getConsultation(userID : String)
    case getConsultationAgency(etalaseID : String)
    case rejectEtalaseConsultation(consultationID : String, feedback : String )
    case acceptEtalaseConsultation(consultationID : String)
    case rejectUserConsultation(consultationID : String)
    case getOfferByEtalaseId(etalaseID : String)
    case getTaskByOfferID(offerID : String)
    case getOfferByUserId(userID: String)
}

//MARK: - PET ENUMERATION DECLARATION
enum genderCase : String {
    case female = "female"
    case male   = "male"
}

enum petSizeCase : String {
    case kucingKecil  = "Kucing Kecil (Panjang 5 - 10 cm)"
    case kucingSedang = "Kucing Sedang (Panjang 10 - 15 cm)"
    case kucingBesar  = "Kucing Besar (Panjang 15 - 20 cm)"
    case anjingKecil  = "Anjing Kecil (Panjang 5 - 10 cm)"
    case anjingSedang = "Anjing Sedang (Panjang 10 - 15 cm)"
    case anjingBesar  = "Anjing Besar (Panjang 15 - 20 cm)"
}

enum petTypeCase : String {
    case kucing = "cat-icon"
    case anjing   = "dog-icon"
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
enum summaryGenerate : Error {
    case dataTidakAda(errorMessage: String), success(errorMessage: String)
}
