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
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rotatebtn: UIButton!
    @IBOutlet weak var corner1: UIButton!
    @IBOutlet weak var corner2: UIButton!
    @IBOutlet weak var corner3: UIButton!
    @IBOutlet weak var corner4: UIButton!
    lazy var panGesture = UIPanGestureRecognizer()
    lazy var panGesture1 = UIPanGestureRecognizer()
    lazy var panGesture2 = UIPanGestureRecognizer()
    var cornerflag=0
    //var prelocation = CGPoint(x: 0, y: 0)
    //var location = CGPoint(x: 0, y: 0)
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
       
        
        
        
    }
    func move(){
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(textbxgpview.draggedView1(_:)))
        txt1.isUserInteractionEnabled = true
        txt1.addGestureRecognizer(panGesture)
    }
    @IBAction func rotateact(_ sender: Any) {
        //var button = sender as? UIButton
        //button?.tag
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(textbxgpview.draggedView(_:)))
        rotatebtn.isUserInteractionEnabled = true
        rotatebtn.addGestureRecognizer(panGesture)
    }
    
    @IBAction func scaleact(_ sender: Any) {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(textbxgpview.draggedView2(_:)))
        let button = sender as? UIButton
        print(button?.tag)
        if button?.tag==1{
           corner1.isUserInteractionEnabled = true
           corner1.addGestureRecognizer(panGesture)
            cornerflag=1
        }
        else if button?.tag==2{
           corner2.isUserInteractionEnabled = true
           corner2.addGestureRecognizer(panGesture)
            cornerflag=2
        }
        else if button?.tag==3{
           corner3.isUserInteractionEnabled = true
           corner3.addGestureRecognizer(panGesture)
            cornerflag=3
        }
        else if button?.tag==4{
           corner4.isUserInteractionEnabled = true
           corner4.addGestureRecognizer(panGesture)
            cornerflag=4
        }
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
       
          let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
       
        heightConstraint.constant = newSize.height
//        var newFrame = textView.frame
//        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//        textView.frame = newFrame
        layoutIfNeeded()
    }
   
    
    
   
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.bringSubviewToFront(rotatebtn)
        let translation = sender.translation(in: self)
        let r=30.5+(txt1.frame.height/2)
        let angle=2*asin(sqrt((translation.x*translation.x)+(translation.y*translation.y))/(2*r))
        txtboxview.transform=CGAffineTransform(rotationAngle: angle)
        self.move()
    }
   
    @objc func draggedView1(_ sender:UIPanGestureRecognizer){
        self.bringSubviewToFront(txt1)
        let translation = sender.translation(in: self)
        txtboxview.center = CGPoint(x: txtboxview.center.x + translation.x, y: txtboxview.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
    }
    @objc func draggedView2(_ sender:UIPanGestureRecognizer){
        self.bringSubviewToFront(corner1)
        self.bringSubviewToFront(corner2)
        self.bringSubviewToFront(corner3)
        self.bringSubviewToFront(corner4)
        let translation = sender.translation(in: self)
        heightConstraint.constant -= translation.y
        widthConstraint.constant -= translation.x
        txtboxview.center = CGPoint(x: txtboxview.center.x + translation.x, y: txtboxview.center.y + translation.y)
        self.move()
        //let scale=CGPoint(x: widthConstraint.constant/translation.x, y: heightConstraint.constant/translation.y)
        //print(translation)
        //print(scale)
        //self.transform=CGAffineTransform(scaleX: scale.x, y: scale.y)
    }
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            prelocation = touch.location(in: self)
           
        }
        self.transform=CGAffineTransform(scaleX: 2, y: 2)
        print(prelocation)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            location = touch.location(in: self)
         
        }
        print(location)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
   
    }
   
    @IBAction func scaleaction(_ sender: Any, forEvent event: UIEvent) {
        let translation=CGPoint(x: location.x-prelocation.x,y: prelocation.y-location.y)
        let scale=CGPoint(x: widthConstraint.constant/translation.x, y: heightConstraint.constant/translation.y)
        txt1.transform=CGAffineTransform(scaleX: scale.x, y: scale.y)
    }*/
}
