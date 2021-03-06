//
//  UsersVC.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    private var _imageData: Data?
    private var _videoUrl: URL?
    
    var imageData: Data? {
        set{
            _imageData = newValue
        }get{
           return _imageData
        }
    }
    var videoUrl: URL? {
        set{
            _videoUrl = newValue
        }get {
            return _videoUrl
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            //print(snapshot)
            if let users = snapshot.value as? Dictionary<String, Any> {
                for (key, value) in users {
                    //print(key)
                    if let dict = value as? Dictionary<String, Any>{
                        if let profile = dict["profile"] as? Dictionary<String, Any>{
                            if let first  = profile["firstName"] as? String{
                                //print(first)
                                let uid = key
                                let user = User(uid: uid, firstName: first)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            print(self.users)
        }
    }


    @IBAction func sendTapped(_ sender: Any) {
        
        if let url = videoUrl{
            let vidName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.vidStorRef.child(vidName)
            
            _ = ref.putFile(url, metadata: nil, completion: { (meta, error) in
                
                if error != nil{
                    print("\(error.debugDescription)")
                }else{
                    let downloadURL = meta?.downloadURL()
                    DataService.instance.sendMediaClap(uid: FIRAuth.auth()!.currentUser!.uid, recipients: self.selectedUsers, mediaUrl: downloadURL!, text: "Video")
                }
            })
        }else{
            if let imgData = _imageData{
                let ref = DataService.instance.imgStorRef.child("\(NSUUID().uuidString).jpg")
                _ = ref.put(imgData, metadata: nil, completion: { (meta, error) in
                    
                    if error != nil {
                        print("Error uploading image \(error.debugDescription)")
                    }else{
                        let downloadURL = meta?.downloadURL()
                        DataService.instance.sendMediaClap(uid: FIRAuth.auth()!.currentUser!.uid, recipients: self.selectedUsers, mediaUrl: downloadURL!, text: "Picture")
                    }
                })
            }
        }
        self.dismiss(animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckMark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckMark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }

}
