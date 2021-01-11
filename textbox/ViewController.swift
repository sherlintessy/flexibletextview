//
//  ViewController.swift
//  textbox
//
//  Created by Sherlin Tessy P on 06/01/21.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var canvas: UIView!
    var panGesture = UIPanGestureRecognizer()
    let txtboxgp = textbxgpview(frame: CGRect(x: 100, y: 150, width: 190, height: 120))
    
    //let txt1 =  UITextView(frame: CGRect(x: 100, y: 150, width: 110, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //txt1 3 lines
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        txtboxgp.isUserInteractionEnabled = true
        txtboxgp.addGestureRecognizer(panGesture)
        
    }
   
    @IBAction func onclickaddttext(_ sender: Any) {
      
        //6 txt1 lines
        canvas.addSubview(txtboxgp)
    }
    
    // func textView
    //func textViewDidChange
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(txtboxgp)
        let translation = sender.translation(in: self.view)
        txtboxgp.center = CGPoint(x: txtboxgp.center.x + translation.x, y: txtboxgp.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

}

