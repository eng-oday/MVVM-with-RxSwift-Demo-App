//
//  ApiManager.swift
//  RxSwift-DemoApp
//
//  Created by Oday Dieg on 04/09/2022.
//

import Foundation
import UIKit
import Alamofire

class ApiManager : UIViewController {

    var lang : String = "ar"
    static let instance = ApiManager()



    //MARK: - Default Request
    func getPosts<T : Decodable>(methodType: HTTPMethod = .post , parameters:[String:AnyObject]?, url : String , Completion : @escaping (T? ,String?)->Void){


        var headers: HTTPHeaders? = nil


        headers = [
            "Content-Type": "application/json"
        ]


        let net             = NetworkReachabilityManager()
        net?.startListening()
        // internet connection is on
        net?.listener =
        { status in

            if  net?.isReachable ?? false
            {
                let encodedLink         = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let encodedURL          = NSURL(string: encodedLink!)! as URL

                Alamofire.request(
                    encodedURL,
                    method: methodType,
                    parameters: parameters,
                    encoding: JSONEncoding.default,
                    headers: headers).responseJSON
                {
                    response in

                    debugPrint("---------->" , url ,response.response?.statusCode , response.response , response.result.isSuccess , response.result , encodedURL)

                    // response get success
                    if response.result.isSuccess {
                        print("this is response debug description ------------------\(response.debugDescription)")

                        let dict = response.result.value! as! [String:Any]
                        print(dict)

                        if dict["value"] as? Bool == true || dict["value"] as? Int == 1  {

                            guard let data = response.data else {
                                return
                            }
                            print(data)
                            do {
                                let Posts = try JSONDecoder().decode(T.self, from: data)
                                print(Posts)
                                Completion(Posts, nil)

                            }catch let error {
                                Completion(nil , error.localizedDescription)
                                print("----------->>>>>>>>>>>>>>>" ,error , "----------->>>>>>>>>>>>>>>>>>")
                            }
                        }

                            else{
                                if response.response?.statusCode  == 401 {
                                    return
                                }
                                if let dictError = dict["message"] as? String {
                                    Completion(nil , dictError)
                                }
                        }
                    }else {
                            //response get failed
                            print(response.response?.statusCode)
                            Completion(nil,"anError")
                        }

                }
            }

            // no internet Connection
            else {
                Completion(nil,"noNet")
            }

        }

    }
}
