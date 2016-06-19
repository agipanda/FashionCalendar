//
//  SaveViewController.swift
//  FashionCalendar
//
//  Created by erijae on 2016/06/19.
//  Copyright © 2016年 erijae. All rights reserved.
//

import UIKit

class SaveViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    // test
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var photoSelectButton: UIButton!
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var label : UILabel!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var weatherTextField: UITextField!
    @IBOutlet var commentTextField: UITextField!
    
    var year: Int!
    var month: Int!
    var day: Int!
    
    let saveDefault = NSUserDefaults.standardUserDefaults()
    var dateDictionary: [String: AnyObject] = [:]
    
    @IBAction func photoSelectButtonTouchDown(sender: AnyObject){
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            UIAlertView(title: "警告", message: "Photoライブラリにアクセスできません", delegate: nil, cancelButtonTitle: "OK").show()
        } else {
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated:true, completion:nil)
        }
        
        func imagePickerController(picker: UIImagePickerController!, didfinishPikingMediaWithInfo info: NSDictionary!){
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            pictureImageView.image = image
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func button() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savebutton() {
        //        let image:UIImage! = mainImageView.image
        //
        //        if image != nil {
        //            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingwithError:contextInfo:", nil)
        //        }
        //        else{
        //            label.text = "image Failed !"
        //
        //        }]
        
        if pictureImageView!.image == nil {
            let picture_alert = UIAlertView()
            picture_alert.title = "Not enough information"
            picture_alert.message = "Please select the picture!"
            picture_alert.addButtonWithTitle("OK")
            picture_alert.show();
            
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            
            self.presentViewController(imagePickerController, animated: true, completion: nil)
            
        }else{
            let photoData: NSData = UIImagePNGRepresentation(pictureImageView!.image!)!
            
            let date_formatter: NSDateFormatter = NSDateFormatter()
            date_formatter.locale = NSLocale(localeIdentifier: "ja")
            date_formatter.dateFormat = "yyyy/MM/dd"
            let change_date: NSDate = date_formatter.dateFromString("\(year)/\(month)/\(day)")!
            
            dateDictionary = ["photo": photoData,"place": placeTextField!.text!,"weather": weatherTextField!.text!,"comment": commentTextField!.text!, "date":change_date]
            
            if let dict = saveDefault.objectForKey("save") {
                var date = dict as! [Dictionary<String, AnyObject>]
                date.append(dateDictionary)
                saveDefault.setObject(dict, forKey: "save")
                saveDefault.synchronize()
            }else {
                var dict : [Dictionary<String, AnyObject>] = []
                dict.append(dateDictionary)
                saveDefault.setObject(dict, forKey: "save")
                saveDefault.synchronize()
            }
            
            
            
            
            
            print("Saved!")
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        guard let data : [Dictionary<String, AnyObject>] = saveDefault.objectForKey("save") as? [Dictionary<String, AnyObject>] else {return}
        //        print(data["photo"])
        
        
        let photo: UIImage? = UIImage(data: data[0]["photo"] as! NSData)
        //  let imageView = UIImageView(image: photo)
        pictureImageView.image = photo
        
        
    }
    
    @IBOutlet var fashionimage: UIImageView!
    
    //    @IBAction func selectBackground(){
    //        let imagePickerController: UIImagePickerController = UIImagePickerController()
    //
    //        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    //        imagePickerController.delegate = self
    //        imagePickerController.allowsEditing = true
    //
    //        self.presentViewController(imagePickerController, animated: true, completion: nil)
    //    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        fashionimage!.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}
