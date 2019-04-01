//
//  ViewController.swift
//  CustomHMSegmentToolSwift
//
//  Created by stegowl on 05/02/18.
//  Copyright © 2018 stegowl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var myView: UIView!
    
    var segmentedControl = HMSegmentedControl()
    var scrollView: UIScrollView?
    var indexOfSegment = 0
    var arrSegment = NSMutableArray()

    @IBOutlet weak var switchCheck: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        arrSegment = ["January","February","March","April","May","June","July","August","September","October","November","December"]

        self.addSegmentedControl()
        self.addGesture()
    }
    
    func addSegmentedControl() -> Void {
        segmentedControl = HMSegmentedControl(frame: CGRect(x: CGFloat(0), y: CGFloat(20), width: CGFloat(self.view.frame.width), height: CGFloat(50)))
        segmentedControl.sectionTitles = arrSegment as! [String]
        segmentedControl.selectedSegmentIndex = indexOfSegment
        segmentedControl.backgroundColor = UIColor.black
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.yellow]
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.selectionIndicatorColor = UIColor.white
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.tag = 3
        segmentedControl.addTarget(self, action: #selector(self.segmentedControlChangedValue), for: .valueChanged)
        view.addSubview(segmentedControl)
    }
    
    func addGesture() -> Void {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if self.indexOfSegment > 0 {
                    self.indexOfSegment = self.indexOfSegment - 1
                    segmentedControl.setSelectedSegmentIndex(UInt(self.indexOfSegment), animated: true)
                    self.transition(3, controller: myView)
                }
                
                break
                
            case UISwipeGestureRecognizerDirection.left:
                if self.indexOfSegment < arrSegment.count - 1 {
                    self.indexOfSegment = self.indexOfSegment + 1
                    segmentedControl.setSelectedSegmentIndex(UInt(self.indexOfSegment), animated: true)
                    self.transition(2, controller: myView)
                }
                
                break
                
            default:
                break
            }
        }
    }
    
    func transition(_ index: Int, controller: UIView) {
        let tr = CATransition.init()
        tr.duration = 0.5
        tr.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        tr.type = kCATransitionPush
        tr.delegate = self as? CAAnimationDelegate
        switch index {
        case 0:
            tr.subtype = kCATransitionFromBottom
        case 1:
            tr.subtype = kCATransitionFromTop
        case 2:
            tr.subtype = kCATransitionFromRight
        case 3:
            tr.subtype = kCATransitionFromLeft
        default:
            break
        }
        
        controller.layer.add(tr, forKey: nil)
    }

    @IBAction func switchCheckClicked(_ sender: UISwitch) {
        self.checkValidation()
    }
    
    func checkValidation()-> Void{
 
        if switchCheck.isOn {
            segmentedControl.isTouchEnabled = true
        }
        else{
            segmentedControl.isTouchEnabled = false
        }
    }
    func segmentedControlChangedValue(_ segmentedControls: HMSegmentedControl) {
        let selectedSegment = Int(segmentedControls.selectedSegmentIndex)
        indexOfSegment = selectedSegment
        if selectedSegment > indexOfSegment {
            self.transition(2, controller: myView)
        }
        else{
            self.transition(3, controller: myView)
        }
    }
}

