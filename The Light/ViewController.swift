//
//  ViewController.swift
//  The Light
//
//  Created by Igor Loginov on 07.12.2020.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var lightColor = 0
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        toggleTorch(on: true)
        
        
    }
    
    
    fileprivate func updateUI() {
        
        switch lightColor {
        case 0:
            view.backgroundColor = .red
        case 1:
            view.backgroundColor = .green
        case 2:
            view.backgroundColor = .yellow
            
        default:
            print("Error")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lightColor = lightColor < 2 ? lightColor + 1 : 0
        updateUI()
        toggleTorch(on: true)
        
    }
    
    //     вкл фонарика на реальном устройстве
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video)
        else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
            
        } else {
            print("Torch is not available")
        }
    }
    
}
