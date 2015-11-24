//
//  ViewController.swift
//  QrCodeGen
//
//  Created by Ivo Silva on 23/11/15.
//  Copyright © 2015 Ivo Silva. All rights reserved.
//

import UIKit


class ViewController: UIViewController {    
    
    @IBOutlet weak var image_holder: UIImageView!
    let names = ["ivo", "tiago", "diogo", "tino", "daniel", "lebre"]
    var i=0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func generateQR() {
        
        /// CIQRCodeGenerator generates 27x27px images per default
        let DefaultQRCodeSize = CGSize(width: 27, height: 27)
        
        /// Data contained in the generated QRCode
        var data: NSData
        
        data = "cunaxa".dataUsingEncoding(NSUTF8StringEncoding)!
        
        /// Foreground color of the output
        /// Defaults to black
        let color = CIColor(red: 0, green: 0, blue: 0)
        
        /// Background color of the output
        /// Defaults to white
        let backgroundColor = CIColor(red: 0.5, green: 1, blue: 1)
        
        
        
        
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        
        qrFilter!.setDefaults()
        qrFilter!.setValue(data, forKey: "inputMessage")
        qrFilter!.setValue("H", forKey: "inputCorrectionLevel")
        
        let colorFilter = CIFilter(name: "CIFalseColor")
        
        colorFilter!.setDefaults()
        colorFilter!.setValue(qrFilter!.outputImage, forKey: "inputImage")
        colorFilter!.setValue(color, forKey: "inputColor0")
        colorFilter!.setValue(backgroundColor, forKey: "inputColor1")
        
        let transformedImage = createNonInterpolatedUIImageFromCIImage(colorFilter!.outputImage!, withScale: 8.0)

        image_holder.image = transformedImage
        
    }
    
    func createNonInterpolatedUIImageFromCIImage(image: CIImage, withScale scale: CGFloat) -> UIImage {
        var cgImage: CGImageRef = CIContext(options: nil).createCGImage(image, fromRect: image.extent)
        UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width * scale, image.extent.size.width * scale))
        var context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.None)
        CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage)
        var scaledImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }

}

