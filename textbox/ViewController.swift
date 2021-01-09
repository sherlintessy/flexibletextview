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
    let txtboxgp = UIView(frame: CGRect(x: 100, y: 150, width: 120, height: 50))
    
    let txt1 =  UITextView(frame: CGRect(x: 100, y: 150, width: 110, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.txt1.delegate = self
        txt1.text = "Enter text"
        txt1.textColor = UIColor.lightGray
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        txt1.isUserInteractionEnabled = true
        txt1.addGestureRecognizer(panGesture)
        
    }
   
    @IBAction func onclickaddttext(_ sender: Any) {
      
       //Saju
        txt1.font = UIFont.systemFont(ofSize: 15)
        txt1.layer.borderWidth=1
        txt1.layer.borderColor=UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        txt1.autocorrectionType = UITextAutocorrectionType.no
        txt1.keyboardType = UIKeyboardType.default
        txt1.returnKeyType = UIReturnKeyType.done
        canvas.addSubview(txt1)
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
          textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
          let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
          var newFrame = textView.frame
          newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
          textView.frame = newFrame
    }
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(txt1)
        let translation = sender.translation(in: self.view)
        txt1.center = CGPoint(x: txt1.center.x + translation.x, y: txt1.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

}

