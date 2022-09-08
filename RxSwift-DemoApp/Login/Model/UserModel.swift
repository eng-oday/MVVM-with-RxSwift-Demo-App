//
//  UserModel.swift
//  RxSwift-DemoApp
//
//  Created by Oday Dieg on 04/09/2022.
//

import Foundation

import Foundation

struct BaseModel<T:Codable>: Codable {
    let value : Bool?
    var data : T?
    var message : String?
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case data = "data"
        case message = "message"

    }
}



struct UserData : Codable {
    let token : String?
    let uid : Int?
    let user : User?
    let name : String?
    let mobile : String?
    let gender : String?
    let profile_image : String?
    let created_at : String?
    let pass_update : String?
    let pass_forgot : String?
    let updated_at : String?
    let dob : String?
    let city : String?
    let country : String?
    let lat : Double?
    let long : Double?
    let snap : String?
    let fb : String?
    let insta : String?
    let website : String?
    let avatar : String?
    let bitmoji : String?
    let delete_account : Bool?
    let expiration_date : String?
    let count_for_forgot_pass : Int?
    let time_for_forgot_pass : String?
    let isSocial : Bool?
    let country_code : String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case uid = "uid"
        case user = "user"
        case name = "name"
        case mobile = "mobile"
        case gender = "gender"
        case profile_image = "profile_image"
        case created_at = "created_at"
        case pass_update = "pass_update"
        case pass_forgot = "pass_forgot"
        case updated_at = "updated_at"
        case dob = "dob"
        case city = "city"
        case country = "country"
        case lat = "lat"
        case long = "long"
        case snap = "snap"
        case fb = "fb"
        case insta = "insta"
        case website = "website"
        case avatar = "avatar"
        case bitmoji = "bitmoji"
        case delete_account = "delete_account"
        case expiration_date = "expiration_date"
        case count_for_forgot_pass = "count_for_forgot_pass"
        case time_for_forgot_pass = "time_for_forgot_pass"
        case isSocial = "isSocial"
        case country_code = "country_code"
    }
    
}

struct User : Codable {
    let email : String?
    let username : String?
    let password : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case username = "username"
        case password = "password"
    }
}

