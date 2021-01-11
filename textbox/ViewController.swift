//
//  ViewController.swift
//  textbox
//
//  Created by Sherlin Tessy P on 06/01/21.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var canvas: UIView!
    //pangesture1 declaration
    let txtboxgp = textbxgpview(frame: CGRect(x: 100, y: 150, width: 190, height: 120))
    
    //let txt1 =  UITextView(frame: CGRect(x: 100, y: 150, width: 110, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //txt1 3 lines
        //pangesture1 3 lines
        txtboxgp.translatesAutoresizingMaskIntoConstraints = false
    }
   
    @IBAction func onclickaddttext(_ sender: Any) {
      
        //6 txt1 lines
        canvas.addSubview(txtboxgp)
    }
    
    // func textView
    //func textViewDidChange
    
   
}

