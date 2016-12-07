//
//  ViewController.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/6/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate{

    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var camBtn: UIButton!
    
    
    override func viewDidLoad() {
        delegate = self
        _previewView = previewView
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
//        guard FIRAuth.auth()?.currentUser != nil else {
           performSegue(withIdentifier: "ShowLoginVC", sender: nil)
//            return
//        }
    }

    @IBAction func cameraChangeTapped(_ sender: Any) {
        changeCamera()
        
    }
    @IBAction func recBtnTapped(_ sender: Any) {
        toggleMovieRecording()
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        camBtn.isEnabled = enable
        print("Cam ui enabled? \(enable)")
    }
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
        print("Record ui enabled? \(enable)")
    }
    func recordingHasStarted() {
        print("Recording Started")
    }
    func canStartRecording() {
        print("Recording can start")
        
    }
}   

