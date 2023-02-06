//
//  RequestServices.swift
//  Gotaps
//
//  Created by Asif Nazir on 29/04/2022.
//

import Foundation
import UIKit
import Alamofire
import CoreMedia
//import Imaginary

class RequestServices: NSObject {
    
    static let shared = RequestServices()
    
    //MARK: - Make POST Request For JSON encoded Body
    let manager = AF
    func makePostRequest(urlSuffix:String, body:[String:Any], completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(Constants.APP_BASE_URL)\(urlSuffix)")
        print("URL: ", url!)
        print("Body Params", body)
        
        var headers: HTTPHeaders = [:]
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            headers["Authorization"] = "Bearer " + token!
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        } else {
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        }
        print("Headers:", headers)
        
        manager.request(url!, method: .post, parameters: body, encoding: URLEncoding.default ,headers: headers).validate(statusCode: 200..<400).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
            case .success(_):
                completionHandler(response.data, nil)
            case .failure(let error):
                completionHandler(response.data, error)
                print("failure")
            }
        }
    }
    
    func makePostRequestWithJsonEncoding(urlSuffix:String, body:[String:Any], completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(Constants.APP_BASE_URL)\(urlSuffix)")
        print("URL: ", url!)
        print("Body Params", body)
        
        var headers: HTTPHeaders = [:]
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            headers["Authorization"] = "Bearer " + token!
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        } else {
            
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        }
        
        manager.request(url!, method: .post, parameters: body, encoding: JSONEncoding.default ,headers: headers).validate(statusCode: 200..<400).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
            case .success(_):
                completionHandler(response.data, nil)
            case .failure(let error):
                completionHandler(response.data, error)
                print("failure")
            }
        }
    }
    
    //MARK: - Post with Multiparts
    public func multipart(_ endUrl: String, profileImage: UIImage?, profileName: String, coverImage: UIImage?, coverName: String, withparams parameters: [String:Any], completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
            
        let url = "\(Constants.APP_BASE_URL)\(endUrl)"
            
        var headers: HTTPHeaders = [:]
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            headers["Authorization"] = "Bearer " + token!
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        } else {
            
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        }
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer \(userDefaultsKeys.ACCESS_TOKEN)"
//            ]
//
//            print("URL: ", url)
//            print("Headers: ", headers)
//            print("Parameters: ", parameters)
            
            manager.upload(multipartFormData: { multiPart in
                for p in parameters {
                    multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
                }
                if let imageProfile = profileImage?.jpegData(compressionQuality: 0.5){
                    multiPart.append(imageProfile, withName: profileName, fileName: "\(Date().timeIntervalSinceNow)image.jpg", mimeType: "image/jpg")
                }
                if let imageCover = coverImage?.jpegData(compressionQuality: 0.5){
                    multiPart.append(imageCover, withName: coverName, fileName: "\(Date().timeIntervalSinceNow)image.jpg", mimeType: "image/jpg")
                }
                
                
//                if file != nil {
//                    if let videoUrl = file{
//                        do {
//                            let videoData = try Data(contentsOf: videoUrl)
//                            print(videoUrl)
//                            print(videoData)
//                            multiPart.append(videoData, withName: withName, fileName: "\(Date().timeIntervalSinceNow)video.mp4", mimeType: "video/mp4")
//                        } catch let error {
//                            print(error)
//                        }
//                    }
//                }
                
            }, to: url, method: .post, headers: headers).validate(statusCode: 200..<400).responseJSON { response in
                
                debugPrint(response)
                switch response.result {
                case .success(_):
                    completionHandler(response.data, nil)
                case .failure(let error):
                    completionHandler(response.data, error)
                    print("failure")
                }
            }
//        responseDecodable {  [weak self] (response: DataResponse<T, AFError>) in
//                guard let weakSelf = self else { return }
//                guard let response = weakSelf.handleResponse(response) as? T else {
//                    completion(nil)
//                    return
//                }
//
//                completion(response)
//            }
        }
    
   
    
    //MARK: - Make Put Request
    func makePutRequest(urlSuffix:String, body:[String:Any], completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(Constants.APP_BASE_URL)\(urlSuffix)")
        print("URL: ", url!)
        print("Body Params", body)
        
        var headers: HTTPHeaders = [:]
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            headers["Authorization"] = "Bearer " + token!
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        } else {
            
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        }
        print("Headers:", headers)
        
        manager.request(url!, method: .put, parameters: body, encoding: URLEncoding.default ,headers: headers).validate(statusCode: 200..<400).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
            case .success(_):
                completionHandler(response.data, nil)
            case .failure(let error):
                completionHandler(response.data, error)
                print("failure")
            }
        }
    }
    
    func makePutRequestWithJSONEncoding(urlSuffix:String, body:[String:Any], completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(Constants.APP_BASE_URL)\(urlSuffix)")
        print("URL: ", url!)
        print("Body Params", body)
        
        var headers: HTTPHeaders = [:]
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            headers["Authorization"] = "Bearer " + token!
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        } else {
            
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        }
        print("Headers:", headers)
        
        manager.request(url!, method: .put, parameters: body, encoding: JSONEncoding.default ,headers: headers).validate(statusCode: 200..<400).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
            case .success(_):
                completionHandler(response.data, nil)
            case .failure(let error):
                completionHandler(response.data, error)
                print("failure")
            }
        }
    }
    
    //MARK: - Make GET Request For JSON encoded Body
    func makeGetRequest(urlSuffix:String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(Constants.APP_BASE_URL)\(urlSuffix)")
        print("URL: ", url!)
        
        var headers: HTTPHeaders = [:]
        
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            headers["Authorization"] = "Bearer " + token!
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        } else {
            
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        }
        
        manager.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default ,headers: headers).validate(statusCode: 200..<400).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
            case .success(_):
                completionHandler(response.data, nil)
            case .failure(let error):
                completionHandler(response.data, error)
                print("failure")
            }
        }
    }
    
    //MARK: - Make DELETE Request For JSON encoded Body
    func makeDeleteRequest(urlSuffix:String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(Constants.APP_BASE_URL)\(urlSuffix)")
        print("URL: ", url!)
        
        var headers: HTTPHeaders = [:]
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            headers["Authorization"] = "Bearer " + token!
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        } else {
            
            headers["Accept"] = "application/json"
            headers["Device-Type"] = "ios"
            headers["Device-id"] = UIDevice.current.identifierForVendor?.uuidString
        }
        
        manager.request(url!, method: .delete, parameters: nil, encoding: JSONEncoding.default ,headers: headers).validate(statusCode: 200..<500).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
            case .success(_):
                completionHandler(response.data, nil)
            case .failure(let error):
                completionHandler(response.data, error)
                print("failure")
            }
        }
    }
    
    //MARK: - For POST API
    func postDataWithBody(body: [String : Any], endUrl: String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        makePostRequest(urlSuffix: endUrl, body: body, completionHandler: completionHandler)
    }
    
    //MARK: - For POST API
    func postDataWithBodyWithJson(body: [String : Any], endUrl: String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        makePostRequestWithJsonEncoding(urlSuffix: endUrl, body: body, completionHandler: completionHandler)
    }
    
    //MARK: - For GET API
    func getData( endUrl: String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        makeGetRequest(urlSuffix: endUrl, completionHandler: completionHandler)
    }
    
    //MARK: - For PUT API
    func putDataWithBody(body: [String : Any], endUrl: String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        makePutRequest(urlSuffix: endUrl, body: body, completionHandler: completionHandler)
    }
    
    //MARK: - For PUT API
    func putDataWithBodyWithJSON(body: [String : Any], endUrl: String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        makePutRequestWithJSONEncoding(urlSuffix: endUrl, body: body, completionHandler: completionHandler)
    }

    
    //MARK: - For Delete API
    func deleteData( endUrl: String, completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        makeDeleteRequest(urlSuffix: endUrl, completionHandler: completionHandler)
    }
    
}
