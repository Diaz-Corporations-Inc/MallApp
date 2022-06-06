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
    var msg = ""
    var storeid = ""
    var data = [AnyObject]()
    var dataDict : NSDictionary!
    
    // MARK: - SignUp api function
    func signUp(model: signUpModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.signUp,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{ [self]
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
                        self.msg = respond.object(forKey: "error") as! String
                        print("errorrrrr",msg)
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
            msg = "Please check Internet connection"
            completionHandler(false)
        }
    }
    
    //MARK: - loginApi function
    
    func login(model: loginModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.login,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{ [self]
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
                        let name = data.object(forKey: "name") as! String
                        let token = response.response?.allHeaderFields["x-access-token"] as! String
                        UserDefaults.standard.set(name, forKey: "name")
                        UserDefaults.standard.setValue(token, forKey: "token")
                        UserDefaults.standard.setValue(id, forKey: "id")
                        completionHandler(true)
                    }else{
                        print("fail",respond)
                        self.msg = respond.object(forKey: "error") as! String
                        
                        print("errorrrrr",msg)
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
            self.msg = "Please check internet connection"
            completionHandler(false)
            
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
                        self.msg = respond.object(forKey: "error") as! String
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
            self.msg = "Please check internet connection"
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
                        self.msg = respond.object(forKey: "message") as! String
                        completionHandler(true)
                    }else{
                        print("Fail",respond)
                        self.msg = respond.object(forKey: "error") as! String
                       
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
            self.msg = "Please check internet connection"
            completionHandler(false)
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
                        self.msg = respond.object(forKey: "error") as! String
                        
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
            self.msg = "Please check internet connection"
            completionHandler(false)
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
                        self.msg = respond.object(forKey: "error") as! String
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
        }else{
            self.msg = "Please check internet connection"
            completionHandler(false)
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
    
    //MARK: - get profile
    
    //    func getProfile(completion: @escaping (Bool)->()){
    //        if ReachabilityNetwork.isConnectedToNetwork(){
    //        let userId = UserDefaults.standard.value(forKey: "id") as! String
    //        AF.request(Api.getProfile+userId,method: .get,encoding: JSONEncoding.default).responseJSON {[self]
    //            response in
    //            switch(response.result){
    //
    //            case .success(let json):do{
    //                let success = response.response?.statusCode
    //                let respond = json as! NSDictionary
    //                if success == 200{
    //                    print("success",respond)
    //                    msg = respond.object(forKey: "message") as! String
    //                    completion(true)
    //                }else{
    //                    msg = respond.object(forKey: "error") as! String
    //                    completion(false)
    //                }
    //            }
    //
    //            case .failure(let error): do{
    //                print("error",error)
    //                completion(false)
    //            }
    //
    //            }
    //        }
    //        }else{
    //            msg = "Please check Internet connection"
    //            completion(false)
    //        }
    //    }
///
//MARK: - UPLOAD STORE LOGO
    
    func uploadStoreImage(image: UIImage,type:String,
                         progressCompletion: @escaping (_ percent: Float) -> Void,
                         completion: @escaping (_ result: Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        let randomno = Int.random(in: 1000...100000)
        let imgFileName = "image\(randomno).jpg"
        AF.upload(
            multipartFormData: { multipartFormData in
                //
                multipartFormData.append(imageData,
                                         withName: "file",
                                         fileName: imgFileName,
                                         mimeType: "image/jpeg")
            },
            to: Api.storeImage+storeid+"/\(type)", usingThreshold: UInt64.init(), method: .put)
            .uploadProgress { progress in
                progressCompletion(Float(progress.fractionCompleted))
            }
            .response { response in
                debugPrint(response)
            }
    }
    //MARK: - create store api
    func createStore(model: createStoreModel,completion: @escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.createStore,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    if response.response?.statusCode == 200{
                        msg = respond.object(forKey: "message") as! String
                        print("response is ",respond)
                        let dataRes = respond.object(forKey: "data") as! NSDictionary
                        storeid = dataRes.object(forKey: "_id") as! String
                        completion(true)
                    }else{
                        msg = respond.object(forKey: "error") as! String
                        print(respond,"sbvjsdbvjh",msg)
                        completion(false)
                        
                    }
                }
                    catch{
                        print("error",error.localizedDescription)
                        completion(false)
                        
                    }
                    
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                    
                }
                    
                }
            }
        }else{
            msg = "Please check Internet connection"
            completion(false)
        }
    }
    
    //MARK: - UPDATE store api
    func updateStore(model: createStoreModel,storeId: String,completion: @escaping (Bool)-> ()){
        
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let head : HTTPHeaders = ["x-access-token":token]
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.updateStore+storeId,method: .put,parameters: model,encoder: JSONParameterEncoder.default,headers:  head).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    if response.response?.statusCode == 200{
                        let dataRes = respond.object(forKey: "data") as! NSDictionary
                        storeid = dataRes.object(forKey: "_id") as! String
//                        msg = respond.object(forKey: "message") as! String
                        print("response is ",respond)
                      
                        completion(true)
                    }else{
                        msg = respond.object(forKey: "error") as! String
                        print(respond,"sbvjsdbvjh",msg)
                        completion(false)
                        
                    }
                }
                    catch{
                        print("error",error.localizedDescription)
                        completion(false)
                        
                    }
                    
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                    
                }
                    
                }
            }
        }else{
            msg = "Please check Internet connection"
            completion(false)
        }
    }
    

    // MARK: - FavouriteApi
    func favUnFav(model: favouriteModel,completion: @escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            
            AF.request(Api.favUnfav,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    if response.response?.statusCode == 200{
//                        msg = respond.object(forKey: "message") as! String
                        print("response is ",respond)
                        completion(true)
                    }else{
                        msg = respond.object(forKey: "error") as! String
                        completion(false)
                        
                    }
                }
                    catch{
                        print("error",error.localizedDescription)
                        completion(false)
                        
                    }
                    
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                    
                }
                    
                }
            }
        }else{
            msg = "Please check Internet connection"
            completion(false)
        }
    }
    
    //MARK: - GET FAV API
    //    func getFav(completion: @escaping (Bool)->()){
    //        if ReachabilityNetwork.isConnectedToNetwork(){
    //
    //        let id = UserDefaults.standard.object(forKey: "id") as! String
    //        AF.request(Api.getFav+id,method: .get,encoding: JSONEncoding.default).responseJSON {[self]
    //            response in
    //            switch(response.result){
    //
    //            case .success(let json): do{
    //                let success = response.response?.statusCode
    //                let respond = json as! NSDictionary
    //                if success == 200{
    //                    print(respond)
    //                    print(msg)
    //                    completion(true)
    //                }else{
    //                    msg = respond.object(forKey: "error") as! String
    //                    completion(false)
    //                }
    //            }
    //
    //            case .failure(let error): do{
    //                print("error",error)
    //                completion(false)
    //            }
    //
    //            }
    //        }
    //        }else{
    //            msg = "Please check Internet connection"
    //            completion(false)
    //        }
    //    }
    
    //
    
    //MARK: - MY STORE
    func myStore(id: String,completionHandler: @escaping (Bool)->()) {
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers : HTTPHeaders = ["x-access-token":token]
            AF.request(Api.myStore+id,method: .get,encoding: JSONEncoding.default,headers:headers).responseJSON{ [self]
                response in
                switch(response.result){
                    
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond,"success")
                        data = respond.object(forKey: "data") as! [AnyObject]
                        completionHandler(true)
                    }else{
                        print(respond,"fail")
                        msg = respond.object(forKey: "error") as! String
                        completionHandler(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completionHandler(false)
                    
                }
                }
            }
        }else{
            msg = "Please cheeck internet connection"
            completionHandler(false)
        }
    }
    
    
    //MARK: - STORELIST
    
    func storeList(completionHandler: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.storeList,method: .get,encoding: JSONEncoding.default).responseJSON{ [self]
                response in
                switch(response.result){
                    
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond,"success")
                        data = respond.object(forKey: "data") as! [AnyObject]
                        completionHandler(true)
                    }else{
                        print(respond,"fail")
                        msg = respond.object(forKey: "error") as! String
                        completionHandler(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completionHandler(false)
                    
                }
                }
            }
        }else{
            msg = "Please cheeck internet connection"
            completionHandler(false)
        }
    }
     
    // MARK: - STORE LIST WITH TOKEN
     
     func storeListWithTOken(completionHandler: @escaping (Bool)->()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             let token  = UserDefaults.standard.value(forKey: "token") as! String
             let head : HTTPHeaders = ["x-access-token": token]
             AF.request(Api.storeList,method: .get,headers: head).responseJSON{ [self]
                 response in
                 switch(response.result){
                     
                 case .success(let json):do{
                     let success = response.response?.statusCode
                     let respond = json as! NSDictionary
                     if success == 200{
                         print(respond,"success")
                         data = respond.object(forKey: "data") as! [AnyObject]
                         completionHandler(true)
                     }else{
                         print(respond,"fail")
                         msg = respond.object(forKey: "error") as! String
                         completionHandler(false)
                     }
                 }
                 case .failure(let error):do{
                     print("error",error)
                     completionHandler(false)
                     
                 }
                 }
             }
         }else{
             msg = "Please cheeck internet connection"
             completionHandler(false)
         }
     }
    //MARK: - STORE BY ID
    func storeById(storeid: String,completionHandler: @escaping (NSDictionary?,Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            AF.request(Api.storeById+storeid,method: .get,encoding: JSONEncoding.default).responseJSON{ [self]
                response in
                switch(response.result){
                    
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond,"success")
                        dataDict = respond.object(forKey: "data") as! NSDictionary
                        completionHandler(dataDict,true)
                    }else{
                        print(respond,"fail")
                        msg = respond.object(forKey: "error") as! String
                        completionHandler(nil,false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completionHandler(nil,false)
                    
                }
                }
            }
        }else{
            msg = "Please cheeck internet connection"
            completionHandler(nil,false)
        }
    }
 //MARK: - GETPRODUCT
    func getAllProduct(completionHandler: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            AF.request(Api.getProduct,method: .get,encoding: JSONEncoding.default).responseJSON{ [self]
                response in
                switch(response.result){
                    
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond,"success")
                        data = respond.object(forKey: "data") as! [AnyObject]
                        completionHandler(true)
                    }else{
                        print(respond,"fail")
                        msg = respond.object(forKey: "error") as! String
                        completionHandler(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completionHandler(false)
                    
                }
                }
            }
        }else{
            msg = "Please cheeck internet connection"
            completionHandler(false)
        }
    }
//MARK: -
    func getProductById(productId: String,completionHandler: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print(Api.getProductById+productId)
            AF.request(Api.getProductById+productId,method: .get,encoding: JSONEncoding.default).responseJSON{ [self]
                response in
                switch(response.result){
                    
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond,"success")
                        dataDict = respond.object(forKey: "data") as! NSDictionary
                        completionHandler(true)
                    }else{
                        print(respond,"fail")
                        msg = respond.object(forKey: "error") as! String
                        completionHandler(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completionHandler(false)
                    
                }
                }
            }
        }else{
            msg = "Please cheeck internet connection"
            completionHandler(false)
        }
    }
//MARK: -
    func addToCart(_ params:[String:Any],completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.addToCart, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { [self]response in
                switch(response.result){
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond,"success")
                        dataDict = respond.object(forKey: "data") as! NSDictionary
                        msg = respond.object(forKey: "message") as! String
                        completion(true)
                        
                    }else{
                        print(respond,"fail")
                        msg = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                }
                }
            }
        }else{
            msg = "Please cheeck internet connection"
            completion(false)
        }
    }
//MARK: - Get cart api
    func getCart(id: String,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
        
        AF.request(Api.getCart+"?userId="+id, method: .get).responseJSON {[self] response in
            switch(response.result){
            case .success(let json):do{
                let success = response.response?.statusCode
                let respond = json as! NSDictionary
                if success == 200{
                    print(respond)
                  data = respond.object(forKey: "data") as! [AnyObject]
                    completion(true)
                }else{
                    msg = respond.object(forKey: "error") as! String
                    completion(false)
                }
            }
            case .failure(let error):do{
                print("error",error)
                completion(false)
            }
            }
        }
    }
    }
    
// MARK: - get store products
    func getStoreProducts(storeId: String,completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print(Api.myStoreProducts+storeId)
            AF.request(Api.myStoreProducts+storeId,method: .get).responseJSON { [self]
                response in
                switch(response.result){
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                      data = respond.object(forKey: "data") as! [AnyObject]
                        completion(true)
                    }else{
                        msg = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                }
                }
            }
        }else{
            self.msg = "Please check Internet connection"
            completion(false)
        }
    }
//MARK: - ADD PRODUCTS
    func addProduct(model: AddProductModel,completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let header: HTTPHeaders = ["x-access-token":token]
            AF.request(Api.addProduct,method: .post,parameters: model,encoder: JSONParameterEncoder.default,headers: header).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data):do{
                    let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                    print("response",json)
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("success",respond)
                        self.dataDict = respond.object(forKey: "data") as! NSDictionary
                        completion(true)
                    }else{
                        print("fail",respond)
                        self.msg = respond.object(forKey: "error") as! String
                        print("errorrrrr",msg)
                        completion(false)
                    }
                }
                    
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                    
                }
            }
       }else{
            msg = "Please cheeck internet connection"
            completion(false)
        }
    }
    
//MARK: - update products
     func updateProducts(productId:String,model:AddProductModel,completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head: HTTPHeaders = ["x-access-token": token]
            print(Api.updateProduct+productId,token)
            AF.request(Api.updateProduct+productId,method: .put,parameters: model,encoder: JSONParameterEncoder.default,headers: head).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print("response",json)
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("success",respond)
                        self.dataDict = respond.object(forKey: "data") as! NSDictionary
                        completion(true)
                    }else{
                        print("fail",respond)
                        self.msg = respond.object(forKey: "error") as! String
                        print("errorrrrr",msg)
                        completion(false)
                    }
                }catch{
                    print(error.localizedDescription)
                }
                    
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                    
                }
            }
       }else{
            msg = "Please cheeck internet connection"
            completion(false)
        }
    }
//MARK: - productImageUpload
    func uploadProductImages(image: [UIImage],type: String,productId: String,
                      progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ result: Bool) -> Void) {
//              guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//              print("Could not get JPEG representation of UIImage")
//              return
//            }
            let randomno = Int.random(in: 1000...100000)
           let imgFileName = "image\(randomno).jpg"
        
            AF.upload(
              multipartFormData: { multipartFormData in
                for i in 0...image.count-1{
                    multipartFormData.append(image[i].jpegData(compressionQuality: 0.5)!,
                                             withName: "files[]",
                                             fileName: imgFileName,
                                             mimeType: "image/jpeg")
                              }
               },
              to:  Api.addProductImages+productId+"/\(type)", usingThreshold: UInt64.init(), method: .put)
              .uploadProgress { progress in
                   progressCompletion(Float(progress.fractionCompleted))
              }
              .response { response in
                  debugPrint(response)
              }
          }
    
//MARK: - deleteCart
    func deleteCart(id: String,completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let header: HTTPHeaders = ["x-access-token":token]
            print(Api.deleteCart+id)
            AF.request(Api.deleteCart+id,method: .delete,headers: header).responseJSON{ [self]
                response in
                switch(response.result){
                    
                case .success(let json):do{
                    
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print("success",respond)
                        completion(true)
                    }else{
                        print("fail",respond)
                        self.msg = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }
                    
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                    
                }
            }
       }else{
            msg = "Please cheeck internet connection"
            completion(false)
        }
    }
    ///
// MARK: - addReview
    
    func addReview(model: ReviewModel,completion: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head: HTTPHeaders = ["x-access-token": token]
            AF.request(Api.ratingReview,method: .post,parameters:model,encoder: JSONParameterEncoder.default,headers: head).response{
                response in
                switch(response.result){
                case .success(let data): do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        let status = response.response?.statusCode
                        let respond = json as! NSDictionary
                        if status == 200{
                            print(respond)
                            self.dataDict = respond
                            completion(true)
                        }else{
                            self.msg = respond.object(forKey: "error") as! String
                            completion(false)
                        }
                }catch{
                    print(error.localizedDescription)
                    completion(false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                    
                }
           
            }
        }else{
            self.msg = "Please check internet connection"
            completion(false)
        }
   
        
    }
    
//MARK: - ADD ADDRESS
    func addAddress(model: AddAddressModel,completion: @escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head : HTTPHeaders = ["x-access-token": token]
            AF.request(Api.addAddress,method: .post,parameters: model,encoder: JSONParameterEncoder.default,headers: head).response{ [self]
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        print(respond)
                        msg = respond.object(forKey: "message") as! String
                        completion(true)
                    }else{
                        msg = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                }
            }
        }else{
            msg = "Please check internet connection"
            completion(false)
        }
    }
    ///
//MARK: - update address api
    func updateAddress(model: AddAddressModel,AddressId: String,completion: @escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head : HTTPHeaders = ["x-access-token": token]
            AF.request(Api.updateAddress+AddressId,method: .put,parameters: model,encoder: JSONParameterEncoder.default,headers: head).response{ [self]
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        print(respond)
                        
                        completion(true)
                    }else{
                        msg = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                }
            }
        }else{
            msg = "Please check internet connection"
            completion(false)
        }
    }
///
//MARK: - GET ADDRESS
    func getAddress(completion: @escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let id  = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head : HTTPHeaders = ["x-access-token": token]
            AF.request(Api.getAddress+id,method: .get,headers: head).response{ [self]
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        print(respond)
                        self.data = respond.object(forKey: "data") as! [AnyObject]
                        completion(true)
                    }else{
                        print(respond)
                        msg = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                }
            }
        }else{
            msg = "Please check internet connection"
            completion(false)
        }
    }
///
//MARK: - get categories
    func getCategories(completion:@escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(Api.getCategories,method: .get).responseJSON { [self] response in
            switch(response.result){
            case .success(let json): do{
                let success = response.response?.statusCode
                let respond = json as! NSDictionary
                if success == 200{
                    print(respond)
                    self.data = respond.object(forKey: "data") as! [AnyObject]
                    completion(true)
                }else{
                    print(respond)
                    msg = respond.object(forKey: "error") as! String
                    completion(false)
                }
            }
            case .failure(let error):do{
                print(error)
                completion(false)
            }
            
            }
        }
        }else{
            msg = "Please check internet connnection"
            completion(false)
        }
    }
    ///
// MARK: - ADDRESS BY ADDRESS ID
    func addressById(addressId: String,completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head : HTTPHeaders = ["x-access-token":token]
            print(Api.addressById+addressId)
            AF.request(Api.addressById+addressId,method: .get,headers: head).responseJSON { [self]
                response in
                switch(response.result){
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        dataDict = respond.object(forKey: "data") as! NSDictionary
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                }
                }
            }
        }else{
            self.msg = "Please check Internet connection"
            completion(false)
        }
    }
    
// MARK: - SEARCH STORE
    func searchStore(storename: String,completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head : HTTPHeaders = ["x-access-token":token]
            print(Api.search+storename)
            AF.request(Api.search+storename,method: .get,headers: head).responseJSON { [self]
                response in
                switch(response.result){
                case .success(let json):do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        data = respond.object(forKey: "data") as! [AnyObject]
                        completion(true)
                    }else{
                        self.msg = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                }
                }
            }
        }else{
            self.msg = "Please check Internet connection"
            completion(false)
        }
    }
///
// MARK: - STORE BY CATEGORY ID
     func storeByCategory(categoryId: String,completion: @escaping (Bool)->()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             AF.request(Api.storeByCtegory+categoryId,method: .get).responseJSON{
                 response in
                 switch(response.result){
                 case .success(let json):do{
                     let status = response.response?.statusCode
                     let respond = json as! NSDictionary
                     if status == 200{
                         print(respond)
                         self.data = respond.object(forKey: "data") as! [AnyObject]
                         completion(true)
                     }else{
                         self.msg = respond.object(forKey: "error") as! String
                         completion(false)
                     }
                 }
                 case .failure(let error): do{
                     print("error",error)
                     completion(false)
                     
                 }
                 }
             }
         }else{
             self.msg = "Please check internet connection"
             completion(false)
         }
     }
//MARK: - GET SIMILAR PRODUCTS
     func getSimilarProucts(categoryid: String,completion: @escaping (Bool) ->()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             print(Api.similarProducts+categoryid)
         AF.request(Api.similarProducts+"?categoryId="+categoryid,method: .get).responseJSON{
             response in
             switch(response.result){

             case .success(let json):do{
                 let status = response.response?.statusCode
                 let respond = json as! NSDictionary
                 if status == 200{
                     print(respond)
                     self.data = respond.object(forKey: "data") as! [AnyObject]
                     completion(true)
                 }else{
                     self.msg = respond.object(forKey: "error") as! String
                     completion(false)
                 }
             }
                 
             case .failure(let error):do{
                 print("print",error)
                 completion(false)
             }
             }
         }
     }else{
         self.msg = "Please check network connection"
         completion(false)
     }
     }
///
//MARK: - Get deals of the day
     func getSimilarProucts(completion: @escaping (Bool) ->()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             print(Api.dealsOfTheday)
             AF.request(Api.dealsOfTheday,method: .get).responseJSON{
             response in
             switch(response.result){

             case .success(let json):do{
                 let status = response.response?.statusCode
                 let respond = json as! NSDictionary
                 if status == 200{
                     print(respond)
                     self.data = respond.object(forKey: "data") as! [AnyObject]
                     completion(true)
                 }else{
                     self.msg = respond.object(forKey: "error") as! String
                     completion(false)
                 }
             }
                 
             case .failure(let error):do{
                 print("print",error)
                 completion(false)
             }
             }
         }
     }else{
         self.msg = "Please check network connection"
         completion(false)
     }
     }
     ///
//MARK: - GET RECENT BROWSED
     func getRecent(completion: @escaping (Bool)-> ()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             
             AF.request(Api.getAddress,method: .get).response{ [self]
                 response in
                 switch(response.result){
                 case .success(let data): do{
                     let json = try JSONSerialization.jsonObject(with: data!, options: [])
                     let status = response.response?.statusCode
                     let respond = json as! NSDictionary
                     if status == 200{
                         print(respond)
                         self.data = respond.object(forKey: "data") as! [AnyObject]
                         completion(true)
                     }else{
                         print(respond)
                         msg = respond.object(forKey: "error") as! String
                         completion(false)
                     }
                 }catch{
                     print(error.localizedDescription)
                     completion(false)
                 }
                 case .failure(let error):do{
                     print(error.localizedDescription)
                     completion(false)
                 }
                 }
             }
         }else{
             msg = "Please check internet connection"
             completion(false)
         }
     }
     
//MARK: - PLACE ORDER
     func placeOrder(userId: String,AddressId: String,amount: String,cart: [NSDictionary],completion: @escaping (Bool)-> ()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             
             let para: [String:Any] = [
                "userId": userId,
                  "addressId": AddressId,
                  "totalAmount": amount,
                  "cart": cart
             ]
          
             AF.request(Api.placeOrder,method: .post,parameters: para,encoding: JSONEncoding.default).responseJSON{ [self]
                 response in
                 switch(response.result){
                 case .success(let json): do{
                     let status = response.response?.statusCode
                     let respond = json as! NSDictionary
                     print(respond)
                     if status == 200{
                         completion(true)
                     }else{
                         msg = respond.object(forKey: "error") as! String
                         completion(false)
                     }
                 }
                 case .failure(let error):do{
                     print(error.localizedDescription)
                     completion(false)
                 }
                 }
             }
         }else{
             msg = "Please check internet connection"
             completion(false)
         }
     }
     
//MARK: - GET ORDERS
     func getOrders(completion: @escaping (Bool)->()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             let id = UserDefaults.standard.value(forKey: "id") as! String
             
             print(Api.getOrder+id)
             AF.request(Api.getOrder+id,method: .get).responseJSON { [self]
                 response in
                 switch(response.result){
                 case .success(let json):do{
                     let success = response.response?.statusCode
                     let respond = json as! NSDictionary
                     if success == 200{
                         print(respond)
                         data = respond.object(forKey: "data") as! [AnyObject]
                         completion(true)
                     }else{
                         self.msg = respond.object(forKey: "error") as! String
                         completion(false)
                     }
                 }
                 case .failure(let error):do{
                     print("error",error)
                     completion(false)
                 }
                 }
             }
         }else{
             self.msg = "Please check Internet connection"
             completion(false)
         }
     }
    //MARK: - DEALS OF THE DAY
     func dealsOfTheDay(completion: @escaping (Bool)->()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             
             print(Api.dealsOfTheday)
             AF.request(Api.dealsOfTheday,method: .get).responseJSON { [self]
                 
                 response in
                 switch(response.result){
                 case .success(let json):do{
                     let success = response.response?.statusCode
                     let respond = json as! NSDictionary
                     if success == 200{
                         print(respond)
                         data = respond.object(forKey: "data") as! [AnyObject]
                         completion(true)
                     }else{
                         self.msg = respond.object(forKey: "error") as! String
                         completion(false)
                     }
                 }
                 case .failure(let error):do{
                     print("error",error)
                     completion(false)
                 }
                 }
             }
         }else{
             self.msg = "Please check Internet connection"
             completion(false)
         }
     }
//MARK: - PaymentApi
     func createTransaction(model: PaymentModel,completion: @escaping (Bool)->()){
         if ReachabilityNetwork.isConnectedToNetwork(){
             let token = UserDefaults.standard.value(forKey: "token") as! String
             let head : HTTPHeaders = ["x-access-token":token]
             print(Api.createTransaction)
             AF.request(Api.createTransaction,method: .post,parameters: model,encoder: JSONParameterEncoder.default,headers: head).response{
                 response in
                 switch(response.result){
                 case .success(let data): do{
                     let json = try JSONSerialization.jsonObject(with: data!, options: [])
                     let respond = json as! NSDictionary
                     if response.response?.statusCode == 200{
                         print(respond)
                         completion(true)
                     }else{
                         print(respond)
                         self.msg = respond.object(forKey: "error") as! String
                         completion(false)
                     }
                 }catch{
                     print(error.localizedDescription)
                     completion(false)
                 }
                 case .failure(let error): do{
                     print(error.localizedDescription)
                     completion(false)
                 }
                 }
             }
         }else{
             self.msg = "Please check internet connection and try again"
             completion(false)
         }
     }
}

///
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
