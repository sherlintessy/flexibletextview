//
//  textbxgpview.swift
//  textbox
//
//  Created by Sherlin Tessy P on 10/01/21.
//

import UIKit

class textbxgpview: UIView ,UITextViewDelegate{

    @IBOutlet var txtboxview: UIView!
    @IBOutlet weak var txt1: UITextView!
    @IBOutlet weak var rotatebtn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    var panGesture = UIPanGestureRecognizer()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("textbxgp", owner: self, options: nil)
        addSubview(txtboxview)
        txtboxview.frame=self.bounds
        txtboxview.autoresizingMask=[.flexibleHeight,.flexibleWidth]
        //set1
        self.txt1.delegate = self
        txt1.text = "Enter text"
        txt1.textColor = UIColor.lightGray
        //set2
        txt1.font = UIFont.systemFont(ofSize: 15)
        txt1.layer.borderWidth=1
        txt1.layer.borderColor=UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        txt1.autocorrectionType = UITextAutocorrectionType.no
        txt1.keyboardType = UIKeyboardType.default
        txt1.returnKeyType = UIReturnKeyType.done
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        rotatebtn.isUserInteractionEnabled = true
        rotatebtn.addGestureRecognizer(panGesture)
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Enter text"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    func textViewDidChange(_ textView: UITextView) {
          let fixedWidth = textView.frame.size.width
          //textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
          let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
          //var newFrame = textView.frame
          //newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
          //textView.frame = newFrame
        heightConstraint.constant = newSize.height
        layoutIfNeeded()
    }
   
    @IBAction func touch(_ sender: Any) {
        print("")
    }
    
    @IBAction func rotateaction(_ sender: Any) {
        /*//if let button = sender as? UIButton {
                // get the touch inside the button
            //let touch = (event.touches(for: button)?.first() ?? as UITouch
                // println the touch location
            //print(touch.location(in: button))
         }*/
            txtboxview.transform=CGAffineTransform(rotationAngle:90)
            
    }
    /*@objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.bringSubviewToFront(rotatebtn)
        let translation = sender.translation(in: self)
        let r=30.5+(txt1.frame.height/2)
        let angle=2*asin(sqrt((translation.x*translation.x)+(translation.y*translation.y))/(2*r))
        txtboxview.transform=CGAffineTransform(rotationAngle: angle)
       // txtboxview.center = CGPoint(x: txtboxgp.center.x + translation.x, y: txtboxgp.center.y + translation.y)
        //sender.setTranslation(CGPoint.zero, in: self.view)
    }*/

    
}
