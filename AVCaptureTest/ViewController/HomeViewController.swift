//
//  HomeViewController.swift
//  AVCaptureTest
//
//  Created by JimmyHarrington on 2019/06/12.
//  Copyright © 2019 JimmyHarrington. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var myView: UIView!
	@IBOutlet weak var imageView: UIImageView!
	
	
    // MARK: - IBAction
    @IBAction func scanTapped(_ sender: UIButton) {
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ReadView") as! UINavigationController
        let view = controller.topViewController as! ReadViewController
        self.navigationController?.pushViewController(view, animated: true)
        */
        guard let presentedController = self.storyboard?.instantiateViewController(withIdentifier: "ReadView") else { return }
        presentedController.modalTransitionStyle = .coverVertical
        self.present(presentedController, animated: true, completion: nil)
    }
	
	@IBAction func createTapped(_ sender: UIButton) {
		let text = "hello stack overflow"
		if let image = generateBarCode(text: text) {
			imageView.image = image
		}
	}
    
    @IBAction func removeTapped(_ sender: UIButton) {
        for sub in myView.subviews {
            if sub.accessibilityIdentifier == "badge" {
                sub.removeFromSuperview()
            }
        }
        barCodeArray.removeAll()
    }
    
	
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myView.backgroundColor = UIColor.clear
        /*
        let rect = CGRect(x: 64.0, y: 64.0, width: 64.0, height: 64.0)
        let circleView = BadgeView(frame: rect, fillColor: UIColor.red, number: 6)
        circleView.accessibilityIdentifier = "badge"
        myView.addSubview(circleView)
        */
        
        /* setup */
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let codeArray = Application.readData1(path: appFile)
        var array = [String]()
        for i in 0..<codeArray.count {
            let dict = codeArray[i]
            let barcode = dict["barcode"]!
            array.append(barcode)
        }
        makeBadge(array: array)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "HomeViewControllerAddBadge"), object: nil)
    }
    
	
    // MARK: - Notifications
    var barCodeArray = [String]()
    func makeBadge(array: [String]) {
        /* removing existing one */
        for sub in myView.subviews {
            if sub.accessibilityIdentifier == "badge" {
                sub.removeFromSuperview()
            }
        }
        
        if array.count > 0 {
            for code in array {
                if !barCodeArray.contains(code){
                    barCodeArray.append(code)
                }
            }
            let rect = CGRect(x: 64.0, y: 64.0, width: 64.0, height: 64.0)
            let circleView = BadgeView(frame: rect, fillColor: UIColor.red, number: barCodeArray.count)
            circleView.accessibilityIdentifier = "badge"
            myView.addSubview(circleView)
        }
    }
	
	
	// MARK: - Functions
	func generateQR(text: String) -> UIImage? {
		let data = text.data(using: String.Encoding.utf8)
		if let filter = CIFilter(name: "CIQRCodeGenerator") {
			filter.setValue(data, forKey: "inputMessage")
			filter.setValue("M", forKey: "inputCorrectionLevel")
			let transform = CGAffineTransform(scaleX: 200, y: 200)
			if let output = filter.outputImage?.transformed(by: transform) {
				return UIImage(ciImage: output)
			}
		}
		return nil
	}
	
	func generateBarCode(text: String) -> UIImage? {
		let data = text.data(using: String.Encoding.utf8)
		if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
			filter.setValue(data, forKey: "inputMessage")
			let transform = CGAffineTransform(scaleX: 200, y: 200)
			if let output = filter.outputImage?.transformed(by: transform) {
				return UIImage(ciImage: output)
			}
		}
		return nil
	}
}

