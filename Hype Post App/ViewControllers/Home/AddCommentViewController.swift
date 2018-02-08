//
//  AddCommentViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit

class AddCommentViewController: UIViewController {
    
    
    public var posts = [Post]()

    var tableViewCell = AddCommentTableViewCell()
    let tView = AddCommentTableView()
    var textfieldView = TextfieldView()
    
    var addComments = ["hellojhkfzsdmkfdzjs.bzjhlzkf,nzsbjfgkjvhzdhfjskdzgkzdfbgmnxdfghjxbjzkdghx,", "world", "hello", "world"]
    
    var keyboardHeight: CGFloat = 0
    
    @objc func dismissKeyboard() {
        self.tableViewCell.commentTF.resignFirstResponder()
    }
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tView.tableView.delegate = self
        tView.tableView.dataSource = self
        textfieldView.textfield.delegate = self
        view.backgroundColor = Color.grey.lighten5
        view.addSubview(tView)
        view.addSubview(textfieldView)
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        textfieldView.snp.makeConstraints { (make) in
            make.top.equalTo(tView.snp.bottom)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(textfieldView.textfield.snp.top)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if keyboardHeight == 0 {
                keyboardHeight = keyboardSize.height
            }
            self.textfieldView.textfield.snp.remakeConstraints({ (make) in
                make.leading.equalTo(view.snp.leading)
                make.trailing.equalTo(view.snp.trailing)
                make.height.equalTo(60)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset( -keyboardHeight - 8.0)
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.textfieldView.textfield.snp.remakeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(60)
        }
    }
}




extension AddCommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
            let post = posts[indexPath.row]
            cell.configureCell(post: post)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! AddCommentTableViewCell
        let addComment = self.addComments[indexPath.row - 1]
        cell.commentTF.text = addComment
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
        
    }
}

extension AddCommentViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
