//
//  LEELotController.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/9.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit
import CoreMotion

class LEELotController: ViewController {

    @IBOutlet weak var switchButton1: UIButton!
    
    @IBOutlet weak var switchButton2: UIButton!
    
    @IBOutlet weak var switchBackgroundImage: UIImageView!
    
    @IBOutlet weak var ballCount: UIButton!
    
    @IBOutlet weak var machineBallImage: UIImageView!
    
    @IBOutlet weak var addBallView: UIView!
    
    private var isMachineImage: Bool = false
    
    fileprivate var animator: UIDynamicAnimator?
    fileprivate var gravity: UIGravityBehavior?
    fileprivate var collision: UICollisionBehavior?
    fileprivate var dynamicItemBehavior: UIDynamicItemBehavior?
    fileprivate var leaderAttach: UIAttachmentBehavior?
    fileprivate var balls: Array<UIImageView> = Array()
    fileprivate var motionManger: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchButton1.isUserInteractionEnabled = false
        switchButton2.isSelected = true
        switchButton2.isUserInteractionEnabled = true
        
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: 点击事件
    
    @IBAction func popAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchButtonAction(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected = false
        switchButton2.isSelected = true
        self.switchButton2.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.switchBackgroundImage.transform = CGAffineTransform.identity
        }) { (finish) in
            
        }
        
    }
    
    @IBAction func switchButton2Action(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected = false
        switchButton1.isSelected = true
        switchButton1.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.switchBackgroundImage.transform = CGAffineTransform.init(translationX: 75, y: 0)
        }) { (finish) in
            
        }
    }

    
    
    @IBAction func removeSameAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected;
        if sender.isSelected {
            sender.setImage(#imageLiteral(resourceName: "quchong-selected"), for: [.highlighted, .selected])
            
        } else {
            sender.setImage(#imageLiteral(resourceName: "quchong"), for: UIControlState.highlighted )
        }
    }
    
    @IBAction func ballCountButtonAction(_ sender: UIButton) {
        
        
    }
    //MARK: 加球，减球
    @IBAction func subtractButtonAction(_ sender: UIButton) {
        var count: Int = Int((ballCount.titleLabel?.text)!)!
        count -= 1
        if count < 0 {
            count = 0
        }
        ballCount.setTitle("\(count)", for: .normal)
    }
    @IBAction func addButtonAction(_ sender: HighlightButton) {
        var count: Int = Int((ballCount.titleLabel?.text)!)!
        count += 1
        ballCount.setTitle("\(count)", for: .normal)
        
        if !isMachineImage {
            isMachineImage = true
            machineBallImage.image = #imageLiteral(resourceName: "machine")
            setDynamicAnimator()
            addGes()
        }
        addBall(count: count)
    }
    
    deinit {
        motionManger.stopDeviceMotionUpdates()
    }
}

extension LEELotController {

    
    
    fileprivate func setDynamicAnimator() {
        
        animator = UIDynamicAnimator(referenceView: addBallView)
        //重力
        gravity = UIGravityBehavior(items: [])
        animator?.addBehavior(gravity!)
        //碰撞
        collision = UICollisionBehavior(items: [])
        let path = UIBezierPath(ovalIn: addBallView.bounds)
        collision?.addBoundary(withIdentifier: "circle" as NSCopying, for: path)
        collision?.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision!)
        //弹性
        dynamicItemBehavior = UIDynamicItemBehavior(items: [])
        dynamicItemBehavior?.allowsRotation = true
        dynamicItemBehavior?.elasticity = 0.7 //弹性
        animator?.addBehavior(dynamicItemBehavior!)
        
        motionManger = CMMotionManager()
        motionManger.deviceMotionUpdateInterval = 0.01
        motionManger.startDeviceMotionUpdates(to: OperationQueue.current!) { [unowned self] (motion, error) in
//            let yaw = "\(motion?.attitude.yaw)"
//            let pitch = "\(motion?.attitude.pitch)"
//            let roll = "\(motion?.attitude.roll)"
            let rotation = atan2(motion!.attitude.pitch, motion!.attitude.roll)
            self.gravity?.angle = CGFloat(rotation)
        }
    }
    //MARK: 增加手势
    fileprivate func addGes() {
        //增加手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(pan:)))
        addBallView.addGestureRecognizer(pan)
        addBallView.isUserInteractionEnabled = true
    }
    
    fileprivate func addBall(count: Int) {
        
        let ballImage: UIImageView
        if #available(iOS 9.0, *) {
            ballImage = LEECircleImage()
        } else {
            ballImage = UIImageView()
        }
        ballImage.image = UIImage(named: "ball\(count % 5)")
        ballImage.layer.cornerRadius = 24.5
        ballImage.layer.masksToBounds = true
        
        ballImage.frame = CGRect(x: addBallView.LEE_Width / 2.0 - 15.0 + CGFloat(arc4random_uniform(18)), y: 5, width: 49, height: 49)
        
        addBallView.addSubview(ballImage)
        balls.append(ballImage)
        
        gravity?.addItem(ballImage)
        collision?.addItem(ballImage)
        dynamicItemBehavior?.addItem(ballImage)
    }
    
    func panAction(pan: UIPanGestureRecognizer) {
        
        let loc = pan.location(in: addBallView)
        print(loc)
        if pan.state == .began {
            
            var img: UIImageView?
            for item: UIImageView in balls {
                if item.frame.contains(loc) {
                    img = item
                    break
                }
            }
            if img == nil {
                return
            }
        
            leaderAttach = UIAttachmentBehavior(item: img!, attachedToAnchor: loc)
            leaderAttach?.damping = 0.5
            animator?.addBehavior(leaderAttach!)
        } else if pan.state == .changed {
            leaderAttach?.anchorPoint = loc
        } else if pan.state == .ended {
            animator?.removeBehavior(leaderAttach!)
        }
    }
    
}
