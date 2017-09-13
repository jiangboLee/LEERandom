//
//  LEELotController.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/9.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit
import CoreMotion

class LEELotController: UIViewController {

    @IBOutlet weak var switchButton1: UIButton!
    
    @IBOutlet weak var switchButton2: UIButton!
    
    @IBOutlet weak var switchBackgroundImage: UIImageView!
    
    @IBOutlet weak var ballCount: UIButton!
    
    @IBOutlet weak var machineBallImage: UIImageView!
    
    @IBOutlet weak var addBallView: UIView!
    
    //尺寸适配
    @IBOutlet weak var machineHeight: NSLayoutConstraint!
    
    @IBOutlet weak var machineWidth: NSLayoutConstraint!
    
    @IBOutlet weak var machineTop: NSLayoutConstraint!
    
    @IBOutlet weak var startButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var startButtonBottom: NSLayoutConstraint!
    
    @IBOutlet weak var setValueLable: UILabel!
    
    private var isMachineImage: Bool = false
    
    fileprivate var animator: UIDynamicAnimator?
    fileprivate var gravity: UIGravityBehavior?
    fileprivate var collision: UICollisionBehavior?
    fileprivate var dynamicItemBehavior: UIDynamicItemBehavior?
    fileprivate var leaderAttach: UIAttachmentBehavior?
    fileprivate var balls: Array<UIImageView> = Array()
    fileprivate var motionManger: CMMotionManager!
    
    fileprivate var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        machineWidth.constant = widthSize * 293.0
        machineHeight.constant = widthSize * 468.0
        if ISIPHONE_SE() {
            machineTop.constant = 20.0
            setValueLable.font
             = UIFont.systemFont(ofSize: 11)
        } else {
            machineTop.constant = widthSize * 38.0
            setValueLable.font
                = UIFont.systemFont(ofSize: 14)
        }
        startButtonWidth.constant = widthSize * 148.0
        startButtonBottom.constant = widthSize * 25.0
        
        switchButton1.isUserInteractionEnabled = false
        switchButton2.isSelected = true
        switchButton2.isUserInteractionEnabled = true
        
        timer = Timer(timeInterval: 0.2, target: self, selector: #selector(startBallRoll), userInfo: nil, repeats: true)
        timer.fireDate = NSDate.distantFuture
        RunLoop.current.add(timer, forMode: .commonModes)
    
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
        if balls.count > 0 {
            
            UIView.animate(withDuration: 0.3, animations: { 
                
                self.balls[0].bounds.size = CGSize.zero;
                self.balls[0].alpha = 0
            }, completion: { (finish) in
                
                self.balls[0].removeFromSuperview()
                self.gravity?.removeItem(self.balls[0])
                self.collision?.removeItem(self.balls[0])
                self.dynamicItemBehavior?.removeItem(self.balls[0])
                self.balls.remove(at: 0)
            })
        }
        
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
        
        if count > 20 {
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.balls[0].bounds.size = CGSize.zero;
                self.balls[0].alpha = 0
            }, completion: { (finish) in
                
                self.balls[0].removeFromSuperview()
                self.gravity?.removeItem(self.balls[0])
                self.collision?.removeItem(self.balls[0])
                self.dynamicItemBehavior?.removeItem(self.balls[0])
                self.balls.remove(at: 0)
            })
        }
    }
    
    @IBAction func staetButtonAction(_ sender: UIButton) {
        
//        timer.fireDate = NSDate(timeIntervalSinceNow: 0) as Date
        startBallRoll()
    }
    
    func startBallRoll() {
        
        
        let baseAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        baseAnimation.toValue = Double.pi * 10
        baseAnimation.duration = 2
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        baseAnimation.isRemovedOnCompletion = false
        baseAnimation.fillMode = kCAFillModeForwards
        addBallView.layer .add(baseAnimation, forKey: nil)
        
//        motionManger.startDeviceMotionUpdates(to: OperationQueue.current!) { [unowned self] (motion, error) in
        
//            let x: CGFloat = CGFloat(arc4random_uniform(30001)) / 10000.0 - 1.5
//            let y: CGFloat = CGFloat(arc4random_uniform(30001)) / 10000.0 - 1.5
//            let rotation = atan2(x, y)
//           
//            self.gravity?.angle = CGFloat(rotation)
           
//        }
    }
    
    
    deinit {
        if (motionManger != nil) {
            motionManger.stopDeviceMotionUpdates()
        }
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
//            let pitch = "\(String(describing: motion?.attitude.pitch))"
//            let roll = "\(String(describing: motion?.attitude.roll))"
//            print(pitch + "===" + roll)
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
        
        let ballW = widthSize * 49.0
        ballImage.frame = CGRect(x: addBallView.LEE_Width / 2.0 - 15.0 + CGFloat(arc4random_uniform(18)), y: 5, width: ballW, height: ballW)
        ballImage.layer.cornerRadius = ballW / 2.0
        ballImage.layer.masksToBounds = true
        
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
