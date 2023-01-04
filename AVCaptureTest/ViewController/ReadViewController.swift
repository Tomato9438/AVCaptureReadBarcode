//
//  ReadViewController.swift
//  AVCaptureTest
//
//  Created by JimmyHarrington on 2019/06/16.
//  Copyright © 2019 JimmyHarrington. All rights reserved.
//

import UIKit
import AVFoundation

class ReadViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    // MARK: - Variables
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    // MARK: - IBAction
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        /*
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let controller = storyboard.instantiateViewController(withIdentifier: "HomeView") as! UINavigationController
         let homeView = controller.topViewController as! HomeViewController
         */
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* setup */
        setup()
        
        /* preparing scan */
        prepareScan()
    }
    
    func prepareScan() {
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            scanFailed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //metadataOutput.metadataObjectTypes = [.qr] // QR only
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .code128] // QR + barcode
        } else {
            scanFailed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    
    func scanFailed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            print("code: \(stringValue)")
			/*
            let codeArray = Application.readData1(path: appFile)
            var codeStrings = [String]()
            for i in 0..<codeArray.count {
                let dict = codeArray[i]
                let code = dict["barcode"]!
                codeStrings.append(code)
            }
            if !codeStrings.contains(stringValue) {
                //AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                AudioServicesPlaySystemSound(1111)
                qrDetected(code: stringValue)
            }
            */
            captureSession.startRunning()
        }
        //dismiss(animated: true)
    }
    
    
    func qrDetected(code: String) {
        let uuid = UUID().uuidString
        Application.insertData1(path: appFile, barcode: code, uuid: uuid)
    }
}

