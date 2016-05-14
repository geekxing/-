//
//  MyLogTableViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/6.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

protocol MyLogTableViewControllerDelegate: class {
    func sendLogViewController(controller: MyLogTableViewController, didFinishSendingContext context: [AnyObject]?)
}

class MyLogTableViewController: UITableViewController {
    
    var image: UIImage?
    weak var delegate: MyLogTableViewControllerDelegate?
    
    @IBOutlet weak var dtField: UITextField!
    @IBOutlet weak var Done: UIBarButtonItem!
    
    //MARK: - UIAction methods
    @IBAction func done(sender: AnyObject) {
        delegate?.sendLogViewController(self, didFinishSendingContext: nil)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addPhoto(sender: AnyObject) {
        pickPhoto()
    }
    //MARK: - Life Cycle methods
    override func viewWillAppear(animated: Bool) {
        dtField.becomeFirstResponder()
        navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.delegate = self
        gestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(gestureRecognizer)
        tableView.contentInset = UIEdgeInsetsMake(-32, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableViewDelegate methods
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let selectedView = UIView()
            selectedView.backgroundColor = UIColor.whiteColor()
            cell.selectedBackgroundView = selectedView
        } else {
            cell.selectionStyle = .Default
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: - Private methods
    private func showImage(image: UIImage) {
        
    }
    
    func hideKeyboard(gestureRecognizer: UITapGestureRecognizer) {
        let point = gestureRecognizer.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        if indexPath?.section == 0 && indexPath?.row == 0 {
            return
        }
        dtField.resignFirstResponder()
    }

}

//MARK: - TextFieldDelegate methods
extension MyLogTableViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText = self.dtField.text!
        let newText = (oldText as NSString).stringByReplacingCharactersInRange(range, withString: string) as NSString
        Done.enabled = newText.length > 0
        return true
    }
}
//MARK: - UIImagePickerControllerDelegate methods
extension MyLogTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        let imagePicker = MyImagePickerViewController()
        let mediaTypeArr = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)!
        imagePicker.view.tintColor = view.tintColor
        imagePicker.sourceType = .Camera
        imagePicker.mediaTypes = mediaTypeArr as [String]
        imagePicker.delegate = self
        imagePicker.videoMaximumDuration = 10
        imagePicker.videoQuality = UIImagePickerControllerQualityType.TypeMedium
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = MyImagePickerViewController()
        imagePicker.view.tintColor = view.tintColor
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if let image = image {
            showImage(image)
        }
        
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pickPhoto() {
        if true || UIImagePickerController.isSourceTypeAvailable(.Camera) {
//            let mediaTypeArr = UIImagePickerController.availableMediaTypesForSourceType(.Camera)!
//            if mediaTypeArr.contains(kUTTypeImage as String) && mediaTypeArr.contains(kUTTypeMovie as String) {
                showPhotoMenu()
            //}
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        let takePhotoAction = UIAlertAction(title: "拍照", style: .Default) { _ in self.takePhotoWithCamera()}
        alert.addAction(takePhotoAction)
        let chooseFromLibararyAction = UIAlertAction(title: "从相册中选择", style: .Default) { _ in self.choosePhotoFromLibrary()}
        alert.addAction(chooseFromLibararyAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension MyLogTableViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
