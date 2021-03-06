//
//  CreatePostTwoViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import ImagePicker
import Material

class CreatePostTwoViewController: UIViewController, UIImagePickerControllerDelegate  {

    var createPostView = CreatePostView()
    
    var images = [UIImage]() {
        didSet {
            createPostView.postImage.image = images.first
        }
    }
    
    var imagePickerController: ImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createPostView)
        createPostView.commentTV.delegate = self
        createPostView.commentTV.text = "Hype it up..."
        createPostView.commentTV.textColor = UIColor.lightGray
        createPostView.commentTV.selectedTextRange = createPostView.commentTV.textRange(from: createPostView.commentTV.beginningOfDocument, to: createPostView.commentTV.beginningOfDocument)
        createPostView.closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        createPostView.postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        createPostView.cameraButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        
        
        imagePickerController = ImagePickerController()
        //        postBody.borderColor = UIColor.gray
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
        //        imageView.clipsToBounds = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createPostView.commentTV.becomeFirstResponder()
    }
    
    @objc func closeButtonPressed() {
        //        Dismiss view
        dismiss(animated: true, completion: nil)
    }
    
    @objc func postButtonPressed() {
        guard !(createPostView.postTitle.text?.isEmpty)! else {
            showAlert(title: "Error", message: "Post title cannot be blank")
            return
        }
        //        add new post
        if let currentUserDisplayName = AuthUserService.getCurrentUser()?.displayName {
            DBService.manager.newPost(header: createPostView.postTitle.text!, body: createPostView.commentTV.text!, image: createPostView.postImage.image ?? nil, byUser: currentUserDisplayName)
        }
        
        let alertController = UIAlertController(title: "Success!", message: "post sucessful!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.resignFirstResponder()
            self.dismiss(animated: true, completion: {self.resignFirstResponder()})
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
        //        resign first reposnder
        createPostView.commentTV.resignFirstResponder()
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func cameraButtonPressed() {
        //        open up camera and photo gallery
        self.images = []
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
    
//    public static func storyboardInstance() -> CreatePostTwoViewController {
//        let storyboard = UIStoryboard(name: "CreatePost", bundle: nil)
//        let createPostVC = storyboard.instantiateViewController(withIdentifier: "CreatePostTwoViewController") as! CreatePostTwoViewController
//        return createPostVC
//    }
    
    //    @IBAction func openCamera(_ sender: UIBarButtonItem) {
    //        self.images = []
    //        present(imagePickerController, animated: true, completion: {
    //            self.imagePickerController.collapseGalleryView({
    //            })
    //        })
    //    }
    
    private let imagePickerViewController = UIImagePickerController()
}

extension CreatePostTwoViewController: ImagePickerDelegate{
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
        dismiss(animated: true, completion: nil)
        return
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.resetAssets()
        return
    }
}

extension CreatePostTwoViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        textView.snp.remakeConstraints { (make) in
            //            make.height.equalTo(textView.contentSize)
            make.top.equalTo(self.createPostView.postTitle.snp.bottom)
            make.leading.equalTo(self.createPostView.userImage.snp.trailing).offset(6)
            make.height.equalTo(textView.contentSize.height)
            make.trailing.equalTo(self.createPostView.postButton.snp.trailing)
        }
        self.createPostView.updateConstraints()
        self.createPostView.layoutIfNeeded()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
//        let currentText:String = textView.text
////        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
//
//        // If updated text view will be empty, add the placeholder
//        // and set the cursor to the beginning of the text view
//        if updatedText.isEmpty {
//
//            textView.text = "Hype it up..."
//            textView.textColor = UIColor.lightGray
//
//            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//
//        }
//
//            // Else if the text view's placeholder is showing and the
//            // length of the replacement string is greater than 0, clear
//            // the text view and set its color to black to prepare for
//            // the user's entry
//        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .darkGray
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's popping"
            textView.textColor = .lightGray
        }
    }
}

