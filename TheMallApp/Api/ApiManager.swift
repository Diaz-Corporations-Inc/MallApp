//
//  ApiManager.swift
//  TheMallApp
//
//  Created by mac on 23/02/2022.
//
import Foundation
import UIKit
import Alamofire

class ApiManager: UIViewController {

   static let shared = ApiManager()
 
    
 // MARK: - SignUp api function
    func signUp(model: signUpModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.login,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                
                case .success(let data):do{
                    let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                    print("response",json)
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("success",respond)
                        completionHandler(true)
                    }else{
                        print("fail",respond)
                        let error = respond.object(forKey: "error") as! String
                        print("errorrrrr",error)
                        self.alert(message: error)
                        completionHandler(false)
                    }
                }
                    
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
                    
                }
            }
        }else{
            self.alert(message: "Please check internet connection",title: "Connection error!")
            completionHandler(false)
        }
    }

//MARK: - loginApi function
    
    func login(model: loginModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.login,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                
                case .success(let data):do{
                    let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                    print("response",json)
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("success",respond)
                        let data = respond.object(forKey: "data") as! NSDictionary
                        let id = data.object(forKey: "id") as! String
                        let token = response.response?.allHeaderFields["x-access-token"] as! String
                        print("token",token)
                        UserDefaults.standard.setValue(token, forKey: "token")
                        UserDefaults.standard.setValue(id, forKey: "id")
                        completionHandler(true)
                    }else{
                        print("fail",respond)
                        let error = respond.object(forKey: "error") as! String
                        print("errorrrrr",error)
                        self.alert(message: error)
                        completionHandler(false)
                    }
                }
                    
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
                    
                }
            }
        }else{
            completionHandler(false)
            self.alert(message: "Please check internet connection",title: "Connection error!")
        }
    }
  
    //MARK: - forgotPassword function 
    func forgotPassword(email: forgotPassword,completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            AF.request(Api.forgot,method: .post,parameters: email,encoder: JSONParameterEncoder.default).response{
            response in
                switch (response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("Success",respond)
                        let data = respond.object(forKey: "data") as! NSDictionary
                        let token = data.object(forKey: "token") as! String
                        UserDefaults.standard.setValue(token, forKey: "token")
                        completionHandler(true)
                    }else{
                        print("Fail",respond)
                        let error = respond.object(forKey: "error") as! String
                        print("errorrrrr",error)
                        self.alert(message: error)
                        completionHandler(false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
                case .failure(let error): do{
                   
                    print("Error",error.localizedDescription)
                    completionHandler(false)
                }
                }
            }
        }else{
            self.alert(message: "Please check internet connection",title: "Connection error!")
            completionHandler(false)
        }
    }
    
//MARK: - otpApi function
    
    func otpVerify(otp: String, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let para : [String:Any] = ["otp":otp]
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let header : HTTPHeaders = ["x-access-token": token]
            print("para",para)
            AF.request(Api.otp,method: .post,parameters: para,encoding: JSONEncoding.default,headers: header).responseJSON{
                response in
                switch(response.result){
                case .success(let json): do{
//                    let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("Success==",respond)
                        completionHandler(true)
                    }else{
                        print("Fail",respond)
                        let error = respond.object(forKey: "error") as! String
                        print("errorrrrr",error)
                        self.alert(message: error)
                        completionHandler(false)
                    }
                }
                case .failure(let error): do{
                    print("error",error.localizedDescription)
                    completionHandler(false)
                }
                }
            }
        }else{
            self.alert(message: "Please check internet connection",title: "Connection error!")
        }
    }
 
 //MARK: - resetPassword api function
    
    func resetPassword(password: String, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let header : HTTPHeaders = ["x-access-token": token]
            let para : [String:Any] = ["newPassword": password]
            AF.request(Api.reset,method: .post,parameters: para,encoding: JSONEncoding.default,headers: header).responseJSON{
                response in
                switch(response.result){
                case .success(let json): do{
//                    let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("Success==",respond)
                        completionHandler(true)
                    }else{
                        print("Fail",respond)
                        let error = respond.object(forKey: "error") as! String
                        print("errorrrrr",error)
                        self.alert(message: error)
                        completionHandler(false)
                    }
                }
                case .failure(let error): do{
                    print("error",error.localizedDescription)
                    completionHandler(false)
                }
                }
            }
        }else{
            self.alert(message: "Please check internet connection",title: "Connection error!")
        }
    }
    
//MARK: - changePasswordApi
    
    func changePass(model: changePassModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let id = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let header : HTTPHeaders = ["x-access-token":token]
            AF.request(Api.changePass+id,method: .put,parameters: model,encoder: JSONParameterEncoder.default,headers: header).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    if response.response?.statusCode == 200{
                        print("respond",respond)
                        completionHandler(true)
                    }else{
                        print("Failure",respond)
                        completionHandler(false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
                case .failure(let error): do{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
                }
            }
        }
    }
    
//MARK: - imageProfile upload
    func upload(image: UIImage,
                      progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ result: Bool) -> Void) {
              guard let imageData = image.jpegData(compressionQuality: 0.5) else {
              print("Could not get JPEG representation of UIImage")
              return
            }
            let randomno = Int.random(in: 1000...100000)
            let imgFileName = "image\(randomno).jpg"
            let userId = UserDefaults.standard.value(forKey: "id") as! String
            AF.upload(
              multipartFormData: { multipartFormData in
//
                multipartFormData.append(imageData,
                                         withName: "file",
                                         fileName: imgFileName,
                                         mimeType: "image/jpeg")
              },
                to: Api.profileImage+userId, usingThreshold: UInt64.init(), method: .put)
              .uploadProgress { progress in
                   progressCompletion(Float(progress.fractionCompleted))
              }
              .response { response in
                  debugPrint(response)
              }
          }
}


extension UIViewController {
    
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
    
 // showAlertWithOneAction
 func showAlertWithOneAction(alertTitle:String, message: String, action1Title:String, completion1: ((UIAlertAction) -> Void)? = nil){
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: action1Title, style: .default, handler: completion1))
            self.present(alert, animated: true, completion: nil)
        }
    
//showAlertWithTwoActions
    func showAlertWithTwoActions(alertTitle:String, message: String, action1Title:String, action1Style: UIAlertAction.Style ,action2Title: String ,completion1: ((UIAlertAction) -> Void)? = nil,completion2 :((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action1Title, style: action1Style, handler: completion1))
        alert.addAction(UIAlertAction(title: action2Title, style: .default, handler: completion2))
        self.present(alert, animated: true, completion: nil)
    }
}
