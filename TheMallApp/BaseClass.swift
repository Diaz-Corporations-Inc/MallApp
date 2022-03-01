//
//  BaseClass.swift
//  Amigo
//
//  Created by mac on 06/12/2021.
//

import UIKit
import CoreLocation
import Photos
import AVFoundation
import CoreImage
import MobileCoreServices


class BaseClass: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate
{
    
    var isEditedImage : Bool = false
    var completionHandler: ((UIImage,String)->Void)? = nil
    var completionHandlerVideo: ((UIImage,NSURL)->Void)? = nil
    var failureHandler: ((String)->Void)? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //storyboard instance
    func storyBoadName(name:String) ->UIStoryboard {
        return UIStoryboard(name:name,bundle:nil)
    }
    
    //return vc by name
    
    func isValidEmail(testStr:String) -> Bool {
        // ////print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
//    public func addTapGesture(){
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
//        tapGesture.numberOfTapsRequired = 1
//        tapGesture.numberOfTouchesRequired = 1
//        tapGesture.delegate = self
//        //view.addGestureRecognizer(tapGesture)
//    }
    
    @objc func tapGestureAction(){
        self.view.endEditing(true)
    }
    
    func passwordValidationAlphaNumeric(testStr:String) -> Bool {
        
        let emailRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!#$%&'()*+,-./:;<=>?@^_`{|}~\"])[A-Za-z\\d!#$%&'()*+,-./:;<=>?@^_`{|}~\"]{6,15}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPassword(input:String) -> Bool {
        //        ^                         Start anchor
        //        (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
        //        (?=.*[!@#$&*])            Ensure string has one special case letter.
        //        (?=.*[0-9].*[0-9])        Ensure string has two digits.
        //        (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
        //        .{8}                      Ensure string is of length 8.
        //        $                         End anchor.
        let passwordFormat = "^(?=.*[A-Z])(?=.*[.!@#$&*])(?=.*[0-9]).{8,20}$"
        //(example: Mukesh123.)
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: input)
    }
    
    
    //MARK: Validation Check For Phone Number
    func validatePhonNo(phoneNo: String)-> Bool
    {
        
        var hasChar: Bool
        
        if (phoneNo.count >= 5 && phoneNo.count <= 15 )
        {
            hasChar = true
        }
        else
        {
            hasChar = false
        }
        var hasNumb: Bool
        
        let badCharacters = CharacterSet.decimalDigits.inverted
        if phoneNo.rangeOfCharacter(from: badCharacters) == nil
        {
            hasNumb = true
        }
        else {
            hasNumb = false
        }
        
        if (!hasChar || !hasNumb )
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    // for open camera for photos
    
    func camera ()
    {
        if checkPermissionOfCamera() == false{
            return
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.allowsEditing = isEditedImage
            picker.delegate = self
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            //  picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            present(picker, animated: true, completion: nil)
        }
    }
    
    // for open camera for videos
    func cameraVideo ()
    {
        if checkPermissionOfCamera() == false{
            return
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            
            let picker = UIImagePickerController()
            picker.allowsEditing = isEditedImage
            picker.mediaTypes = [kUTTypeMovie as String]
            picker.videoMaximumDuration = 10.0
            picker.delegate = self
            picker.sourceType = .camera
            picker.cameraCaptureMode = .video
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    // for access of videos
    
    func videos ()
    {
        
        
        let picker = UIImagePickerController()
        picker.allowsEditing = isEditedImage
        picker.delegate = self
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.sourceType = .savedPhotosAlbum
        present(picker, animated: true, completion: nil)
    }
    // for access of photos
    
    func photos ()
    {
        let picker = UIImagePickerController()
        picker.allowsEditing = isEditedImage
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = [kUTTypeImage as String]
        present(picker, animated: true, completion: nil)
    }
    
    //CheckPermitionIf camera Permition Off
    func checkPermissionOfCamera() -> Bool
    {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .denied:
           // CommonMethodsClass.showAlertViewOnWindow(titleStr: "Keys.ErrorTitle.rawValue", messageStr: "This app does not have access to your camera", okBtnTitleStr: "OK")
            return false
        case .authorized: break
        case .restricted: break
        case .notDetermined:
            
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    print("Granted access to \(cameraMediaType)")
                } else {
                    
                    //  self.dismiss(animated:true, completion: nil)
                    
                }
            }
        }
        return true
    }
    
    //action sheet for take photo
    
    func openCameraAndPhotos (isEditImage:Bool , getImage:@escaping (UIImage,String) -> (),failure : @escaping (String) -> ()) {
        
        completionHandler=getImage
        failureHandler = failure
        isEditedImage = isEditImage
        let alert = UIAlertController(title: "Please Select", message: "", preferredStyle:UIScreen.main.bounds.size.width <= 450.0 ? UIAlertController.Style.actionSheet : UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { action in
            self.camera()
        }))
        alert.addAction(UIAlertAction(title: "Photos", style: UIAlertAction.Style.default, handler: { action in
            self.photos()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            self.failureHandler!("userCancelled")
        }))
        
       // alert.view.tintColor = UIColor.AppColorGreen
        self.present(alert, animated: true, completion: nil)
    }
    

    
    //action sheet for take video
    
    func openCameraAndVideos (getVideo:@escaping (UIImage,NSURL) -> (),failure : @escaping (String) -> ()) {
        
        completionHandlerVideo = getVideo
        failureHandler = failure
        //isEditedImage = isEditVideo
        let alert = UIAlertController(title: "Please Select", message: "", preferredStyle:UIScreen.main.bounds.size.width <= 450.0 ? UIAlertController.Style.actionSheet : UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { action in
            self.cameraVideo()
        }))
        alert.addAction(UIAlertAction(title: "Videos", style: UIAlertAction.Style.default, handler: { action in
            self.videos()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            self.failureHandler!("userCancelled")
        }))
       // alert.view.tintColor = UIColor.AppColorGreen
        self.present(alert, animated: true, completion: nil)
    }
    
    

    // image picker delegates

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        /////
        
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        // Handle a movie capture
        if mediaType == kUTTypeMovie {
            
            
            guard let image = self.thumbnailForVideoAtURL(url:info[UIImagePickerController.InfoKey.mediaURL] as! NSURL)else { return }
            
            
            completionHandlerVideo!(image,info[UIImagePickerController.InfoKey.mediaURL] as! NSURL)
            
        }
        
        /////
        if(isEditedImage==true){
            if let image = info[.editedImage]{
                let chosenImage = image as! UIImage //2
                completionHandler!(chosenImage,"assert.JPG")
            }
            
        }
        else{
            if let image = info[.originalImage]{
                let chosenImage = image as! UIImage //2
                completionHandler!(chosenImage,"\(Date().timeIntervalSince1970).jpeg")
            }
        }
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func thumbnailForVideoAtURL(url: NSURL) -> UIImage? {
        
        let asset = AVAsset(url: url as URL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform = true
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("error")
            return nil
        }
    }
    
    func timeSince(from: Date, numericDates: Bool) -> String {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let now = NSDate()
        let earliest = now.earlierDate(from as Date)
        let latest = earliest == now as Date ? from : now as Date
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        var result = ""
        
        if components.year! >= 2 {
            result = "\(components.year!) years ago"
        } else if components.year! >= 1 {
            if numericDates == true {
                result = "1 year ago"
            } else {
                result = "Last year"
            }
        } else if components.month! >= 2 {
            result = "\(components.month!) months ago"
        } else if components.month! >= 1 {
            if numericDates == true {
                result = "1 month ago"
            } else {
                result = "Last month"
            }
        }
            //else if components.weekOfYear! >= 2 {
//            result = "\(components.weekOfYear!) weeks ago"
//        } else if components.weekOfYear! >= 1 {
//            if numericDates == true {
//                result = "1 week ago"
//            } else {
//                result = "Last week"
//            }
//        }
        else if components.day! >= 2 {
            result = "\(components.day!) days ago"
        } else if components.day! >= 1 {
            if numericDates == true {
                result = "1 day ago"
            } else {
                result = "Yesterday"
            }
        } else if components.hour! >= 2 {
            result = "\(components.hour!) hours ago"
        } else if components.hour! >= 1 {
            if numericDates == true {
                result = "1 hour ago"
            } else {
                result = "An hour ago"
            }
        } else if components.minute! >= 2 {
            result = "\(components.minute!) min ago"
        } else if components.minute! >= 1 {
            if numericDates == true {
                result = "1 min ago"
            } else {
                result = "A min ago"
            }
        } else if components.second! >= 3 {
            //            result = "\(components.second!) sec ago"
            result = "Just now"
        } else {
            result = "Just now"
        }
        
        return result
    }
    
    func PDFWithScrollView(scrollview: UIScrollView) -> NSData {
        
        /**
         *  Step 1: The first thing we need is the default origin and size of our pages.
         *          Since bounds always start at (0, 0) and the scroll view's bounds give us
         *          the correct size for the visible area, we can just use that.
         *
         *          In the United States, a standard printed page is 8.5 inches by 11 inches,
         *          but when generating a PDF it's simpler to keep the page size matching the
         *          visible area of the scroll view. We can let our printer software (such
         *          as the Preview app on OS X or the Printer app on iOS) do the scaling.
         *
         *          If we wanted to scale ourselves, we could multiply each of those
         *          numbers by 72, to get the number of points for each dimension.
         *          We would have to change how we generated the the pages below, so
         *          for simplicity, we're going to stick to one page per screenful of content.
         */
        
        let pageDimensions = scrollview.bounds
        
        /**
         *  Step 2: Now we need to know how many pages we will need to fit our content.
         *          To get this, we divide our scroll views dimensions by the size
         *          of each page, in either direction.
         *          We also need to round up, so that the pages don't get clipped.
         */
        
        let pageSize = pageDimensions.size
        let totalSize = scrollview.contentSize
        
        let numberOfPagesThatFitHorizontally = Int(ceil(totalSize.width / pageSize.width))
        let numberOfPagesThatFitVertically = Int(ceil(totalSize.height / pageSize.height))
        
        /**
         *  Step 3: Set up a Core Graphics PDF context.
         *
         *          First we create a backing store for the PDF data, then
         *          pass it and the page dimensions to Core Graphics.
         *
         *          We could pass in some document information here, which mostly cover PDF metadata,
         *          including author name, creator name (our software) and a password to
         *          require when viewing the PDF file.
         *
         *          Also note that we can use UIGraphicsBeginPDFContextToFile() instead,
         *          which writes the PDF to a specified path. I haven't played with it, so
         *          I don't know if the data is written all at once, or as each page is closed.
         */
        
        let outputData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(outputData, pageDimensions, nil)
        
        /**
         *  Step 4: Remember some state for later.
         *          Then we need to clear the content insets, so that our
         *          core graphics layer and our content offset match up.
         *          We don't need to reset the content offset, because that
         *          happens implicitly, in the loop below.
         */
        
        let savedContentOffset = scrollview.contentOffset
        let savedContentInset = scrollview.contentInset
        
        scrollview.contentInset = UIEdgeInsets.zero
        
        /**
         *  Step 6: Now we loop through the pages and generate the data for each page.
         */
        
        if let context = UIGraphicsGetCurrentContext()
        {
            for indexHorizontal in 0 ..< numberOfPagesThatFitHorizontally
            {
                for indexVertical in 0 ..< numberOfPagesThatFitVertically
                {
                    
                    /**
                     *  Step 6a: Start a new page.
                     *
                     *          This automatically closes the previous page.
                     *          There's a similar method UIGraphicsBeginPDFPageWithInfo,
                     *          which allows you to configure the rectangle of the page and
                     *          other metadata.
                     */
                    
                    UIGraphicsBeginPDFPage()
                    
                    /**
                     *  Step 6b:The trick here is to move the visible portion of the
                     *          scroll view *and* adjust the core graphics context
                     *          appropriately.
                     *
                     *          Consider that the viewport of the core graphics context
                     *          is attached to the top of the scroll view's content view
                     *          and we need to push it in the opposite direction as we scroll.
                     *          Further, anything not inside of the visible area of the scroll
                     *          view is clipped, so scrolling will move the core graphics viewport
                     *          out of the rendered area, producing empty pages.
                     *
                     *          To counter this, we scroll the next screenful into view, and adjust
                     *          the core graphics context. Note that core graphics uses a coordinate
                     *          system which has the y coordinate decreasing as we go from top to bottom.
                     *          This is the opposite of UIKit (although it matches AppKit on OS X.)
                     */
                    
                    let offsetHorizontal = CGFloat(indexHorizontal) * pageSize.width
                    let offsetVertical = CGFloat(indexVertical) * pageSize.height
                    
                    scrollview.contentOffset = CGPoint(x: offsetHorizontal, y: offsetVertical)
                    
                    context.translateBy(x: -offsetHorizontal, y: -offsetVertical) // NOTE: Negative offsets
                    
                    /**
                     *  Step 6c: Now we are ready to render the page.
                     *
                     *  There are faster ways to snapshot a view, but this
                     *  is the most straightforward way to render a layer
                     *  into a context.
                     */
                    
                    scrollview.layer.render(in: context)
                }
            }
        }
        
        /**
         *  Step 7: End the document context.
         */
        
        UIGraphicsEndPDFContext()
        
        /**
         *  Step 8: Restore the scroll view.
         */
        
        scrollview.contentInset = savedContentInset
        scrollview.contentOffset = savedContentOffset
        
        /**
         *  Step 9: Return the data.
         *          You can write it to a file, or display it the user,
         *          or even pass it to iOS for sharing.
         */
        
        return outputData
    }
    
    func printPDFWithScrollView(scrollview: UIScrollView){
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = .general
        printInfo.jobName = "print Job"
        printController.printInfo = printInfo
        let pdf = PDFWithScrollView(scrollview: scrollview)
        printController.printingItem = pdf
        
        printController.present(animated: true, completionHandler: nil)
    }

    
    func passwordChek(testStr:String) -> Bool {
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        if testStr.rangeOfCharacter(from: characterset.inverted) != nil {
            return true
        }
        else
        {
            return false
        }
    }
    
    func showSettingsAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message:message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        })
        self.present(alert, animated: true, completion: nil)
    }
    
//    func showAlertWithOneAction(alertTitle:String, message: String, action1Title:String, completion1: ((UIAlertAction) -> Void)? = nil){
//        
//        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: action1Title, style: .default, handler: completion1))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    func showAlertWithTwoActions(alertTitle:String, message: String, action1Title:String, action1Style: UIAlertAction.Style ,action2Title: String ,completion1: ((UIAlertAction) -> Void)? = nil,completion2 :((UIAlertAction) -> Void)? = nil){
//        
//        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: action1Title, style: action1Style, handler: completion1))
//        alert.addAction(UIAlertAction(title: action2Title, style: .default, handler: completion2))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func getNoofDaysInCurrentMonth() -> Int {
        let calendar = Calendar.current
        let date = Date()
        
        // Calculate start and end of the current year (or month with `.month`):
        let interval = calendar.dateInterval(of: .month, for: date)!
        
        // Compute difference in days:
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        return days
    }
    
    func getCurrentDateInString() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func addShadowToView(_ view: UIView){
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 2.0
        view.layer.masksToBounds = false
    }
    
    func getCurrentDateInDate() -> Date {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        let dateInDate = dateFormatter.date(from: dateString)
        return dateInDate!
    }
    
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    //Image to base64 String
    func convertImageToString(image: UIImage) -> String {
        if let imageData = image.pngData(){
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        }
        return ""
    }
    
    //String base 64 to Image
    func stringToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    func addRightPaddingToTxtfield(_ textField : UITextField){
        textField.rightViewMode = .always
        let imageView = UIImageView(image: UIImage(named: "downArrow"))
        imageView.frame = CGRect(x: 0, y: 0, width: (imageView.image?.size.width)! + 20.0, height: (imageView.image?.size.height)!)
        imageView.contentMode = .center
        textField.rightView = imageView
    }
    
    func addRightArrow(_ textField : UITextField){
        textField.rightViewMode = .always
        let imageView = UIImageView(image: UIImage(named: "rightArrow"))
        imageView.frame = CGRect(x: 0, y: 0, width: (imageView.image?.size.width)! + 20.0, height: (imageView.image?.size.height)! - 50.0)
        imageView.contentMode = .center
        textField.rightView = imageView
    }
    
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }

    
}
