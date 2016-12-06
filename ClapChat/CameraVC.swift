//
//  ViewController.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/6/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController {

    @IBOutlet weak var previewView: AAPLPreviewView!
    
    
    override func viewDidLoad() {
        _previewView = previewView
        super.viewDidLoad()
        
    }

    @IBAction func cameraChangeTapped(_ sender: Any) {
        changeCamera()
        
    }
    
    @IBAction func snapBtnTapped(_ sender: Any) {
        toggleMovieRecording()
    }
    
}

