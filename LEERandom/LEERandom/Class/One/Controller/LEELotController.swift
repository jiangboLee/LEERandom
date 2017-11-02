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
    
    @IBOutlet weak var removeSameButton: HighlightButton!
    
    @IBOutlet weak var addButton: HighlightButton!
    @IBOutlet weak var jianButton: HighlightButton!
    
    @IBOutlet weak var ballScrollView: UIScrollView!
    
    //翻卡片
    @IBOutlet weak var carCollectionView: UICollectionView!
    
    @IBOutlet weak var cardStartButton: HighlightButton!
    
    @IBOutlet weak var cardStartButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var cardCollectionHeight: NSLayoutConstraint!
    
    //尺寸适配
    @IBOutlet weak var machineHeight: NSLayoutConstraint!
    
    @IBOutlet weak var machineWidth: NSLayoutConstraint!
    
    @IBOutlet weak var machineTop: NSLayoutConstraint!
    
    @IBOutlet weak var startButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var startButtonBottom: NSLayoutConstraint!
    
    @IBOutlet weak var setValueLable: UILabel!
    
    @IBOutlet weak var twoCardsLable: UILabel!
    
    private var isMachineImage: Bool = false
    
    fileprivate var animator: UIDynamicAnimator?
    fileprivate var gravity: UIGravityBehavior?
    fileprivate var collision: UICollisionBehavior?
    fileprivate var dynamicItemBehavior: UIDynamicItemBehavior?
    fileprivate var leaderAttach: UIAttachmentBehavior?
    fileprivate var balls: Array<UIImageView> = Array()
    fileprivate var motionManger: CMMotionManager!
    
    fileprivate var timer: Timer!
    
    fileprivate var leaveBalls: Int?
    fileprivate var isGoonLeave: Bool = false
    fileprivate var produce: ProduceRandom!
    fileprivate var donotJianOne: Bool = true
    fileprivate var donotJianBalls: Int?
    fileprivate var i: Int = 0
    
    //卡片
    fileprivate var cardNum: CardRandom!
    fileprivate var cardArr: [String] = ["last"]
    fileprivate var cardBgArr: [NSInteger] = [1]
    fileprivate var fanCardOutArr: [NSInteger] = []
    fileprivate var needAnimation: Bool = true
    
    fileprivate var coverView: UIView = {
        let v = UIView(frame: UIScreen.main.bounds)
        v.backgroundColor = UIColor.clear
        v.isUserInteractionEnabled = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        machineWidth.constant = widthSize * 293.0
        machineHeight.constant = widthSize * 468.0
        if ISIPHONE_SE() {
            machineTop.constant = 85
            setValueLable.font
             = UIFont.systemFont(ofSize: 11)
        } else {
            machineTop.constant = widthSize * 108
            setValueLable.font
                = UIFont.systemFont(ofSize: 14)
        }
        startButtonWidth.constant = widthSize * 148.0
        startButtonBottom.constant = widthSize * 25.0
        
        switchButton1.isUserInteractionEnabled = false
        switchButton2.isSelected = true
        switchButton2.isUserInteractionEnabled = true
        
        cardStartButtonWidth.constant = widthSize * 148
        cardCollectionHeight.constant = widthSize * 440
    
        produce = ProduceRandom.shared
        cardNum = CardRandom.shared
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: 点击事件
    
    @IBAction func popAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: 点击抽球球
    @IBAction func switchButtonAction(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected = false
        switchButton2.isSelected = true
        self.switchButton2.isUserInteractionEnabled = true
        
        ballScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.switchBackgroundImage.transform = CGAffineTransform.identity
        }) { (finish) in
            
        }
        
    }
    //MARK: 点击翻卡片
    @IBAction func switchButton2Action(_ sender: UIButton) {
        
        sender.isUserInteractionEnabled = false
        sender.isSelected = false
        switchButton1.isSelected = true
        switchButton1.isUserInteractionEnabled = true
        
        ballScrollView.setContentOffset(CGPoint(x: view.LEE_Width, y: 0), animated: true)
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
    //MARK: 设置球数弹框
    @IBAction func ballCountButtonAction(_ sender: UIButton) {
        
//        sender.isSelected = !sender.isSelected;
        let inputView = UINib(nibName: "LEEInputView", bundle: nil).instantiate(withOwner: nil, options: nil).last as? LEEInputView
        inputView?.frame = view.bounds
        inputView?.bgView.transform = CGAffineTransform(translationX: 0, y: -400)
        view.addSubview(inputView!)
        
        inputView?.sureInputBlock = { str in
            if self.ballCount.titleLabel?.text != "0" {
            
                for _ in 1...Int((self.ballCount.titleLabel?.text)!)! {
                    self.subtractButtonAction(UIButton())
                }
            }
            for i in 1...Int(str)! {
                self.i = i
                self.addButtonAction(UIButton())
            }
//            self.ballCount.setTitle(str, for: .normal)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 8, options: .curveEaseInOut, animations: {
            inputView?.bgView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        
    }
    //MARK: 加球，减球
    @IBAction func subtractButtonAction(_ sender: UIButton) {
        
        var count: Int = Int((ballCount.titleLabel?.text)!)!

        if count > 0 && count <= 22 {
            
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
        
        count -= 1
        if count < 0 {
            count = 0
        }
        ballCount.setTitle("\(count)", for: .normal)
        
    }
    func ballHideOne() {
        if donotJianOne {
            donotJianBalls = Int((ballCount.titleLabel?.text)!)! - 1
        }
        
        if donotJianBalls! > 0 && donotJianBalls! < 22 {
            balls[donotJianBalls!].isHidden = true
        }
        
        donotJianBalls! -= 1
        if donotJianBalls! < 0 {
            donotJianBalls! = 0
        }

    }
    

    
    @IBAction func addButtonAction(_ sender: UIButton) {
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

        if count > 22 {
            
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
        
        if balls.count == 0 {
            ballCountButtonAction(UIButton())
            return
        }
        
        self.view.addSubview(self.coverView)
        
        if !isGoonLeave {
            leaveBalls = Int((self.ballCount.titleLabel?.text)!)! - 1
        }
        
        startBallRoll()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.9) {
            
            self.coverView.removeFromSuperview()
            
            let alertV = UINib(nibName: "LEEEndView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! LEEEndView
            alertV.frame = self.view.bounds
            alertV.removeSame = self.removeSameButton.isSelected
            alertV.levelBalls = self.leaveBalls
            
            if self.removeSameButton.isSelected {
                
                self.produce.num = Int((self.ballCount.titleLabel?.text)!)!
                alertV.ballNum = self.produce.noAgainStart()
            } else {
                if !self.isGoonLeave {
                
                    self.produce.num = Int((self.ballCount.titleLabel?.text)!)!
                }
                alertV.ballNum = self.produce.start()
            }
            
            alertV.againBlock = {
                
                self.isGoonLeave = false
                for _ in 1...Int((self.ballCount.titleLabel?.text)!)! {
                    self.subtractButtonAction(UIButton())
                }
            }
            alertV.goonBlock = {
            
               
                
                if self.removeSameButton.isSelected {
                    
                } else {
                    self.isGoonLeave = true
                    if self.leaveBalls == 0 {
                        self.isGoonLeave = false
                        self.leaveBalls = Int((self.ballCount.titleLabel?.text)!)
                        
                        self.donotJianOne = true
                        for item: UIImageView in self.balls {
                            item.isHidden = false
                        }
                    } else {
                        self.ballHideOne()
                        self.donotJianOne = false
                    }
                    self.leaveBalls! -= 1
                }
                
                self.staetButtonAction(UIButton())
            }
            
            self.view.addSubview(alertV)
        }
    }
    
    func startBallRoll() {
        
        let baseAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        baseAnimation.toValue = Double.pi * 10
        baseAnimation.duration = 2
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        baseAnimation.isRemovedOnCompletion = false
        baseAnimation.fillMode = kCAFillModeForwards
        addBallView.layer.add(baseAnimation, forKey: nil)
        
    }
    
    //MARK: 卡片开始
    @IBAction func cardStartAction(_ sender: UIButton) {
        
        if cardArr.count <= 2 {
            
            twoCardsLable.isHidden = false;
            twoCardsLable.alpha = 0.5;
            UIView.animate(withDuration: 1, animations: {
                self.twoCardsLable.alpha = 1;
            })
            UIView.animate(withDuration: 1, animations: {
                self.twoCardsLable.alpha = 0;
            }, completion: { (_) in
                self.twoCardsLable.isHidden = true;
            })
            
            return;
        }
        
        
        sender.isHidden = true
        cardArr.removeLast()
        self.needAnimation = true
        
        fanCardOutArr = Array.init(repeating: -1, count: cardArr.count)
        cardBgArr = Array.init(repeating: 4, count: cardArr.count)
        cardNum.num = cardArr.count
        self.carCollectionView.reloadData()
        
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
        dynamicItemBehavior?.elasticity = 0.5 //弹性
        animator?.addBehavior(dynamicItemBehavior!)
        
        motionManger = CMMotionManager()
        motionManger.deviceMotionUpdateInterval = 0.02
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
        ballImage.frame = CGRect(x: addBallView.LEE_Width / 2.0 , y: 15, width: ballW, height: ballW)
        ballImage.layer.cornerRadius = ballW / 2.0
        ballImage.layer.masksToBounds = true
        
        addBallView.addSubview(ballImage)
        balls.append(ballImage)
        
        gravity?.addItem(ballImage)
        collision?.addItem(ballImage)
        self.dynamicItemBehavior?.addItem(ballImage)
        
    }
    
    func panAction(pan: UIPanGestureRecognizer) {
        
        let loc = pan.location(in: addBallView)
//        print(loc)
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

extension LEELotController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LEECardCollectionViewCell
        if cardStartButton.isHidden {
            
            cell.cardNum = self.fanCardOutArr[indexPath.item]
            
            cell.needAnimation = needAnimation
        } else {
            cell.cardNum = indexPath.item + 1
        }
        cell.index = cardBgArr[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cardInputView = UINib(nibName: "LEECardInputView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! LEECardInputView
        cardInputView.frame = view.bounds
        UIApplication.shared.keyWindow?.addSubview(cardInputView)
        
        if cardStartButton.isHidden {
            
            //已经翻过了
            if fanCardOutArr[indexPath.item] != -1 {
                cardInputView.cardTitle.text = "\(fanCardOutArr[indexPath.item])号卡片"
                cardInputView.cardStr = self.cardArr[fanCardOutArr[indexPath.item] - 1]
                
                cardInputView.addCard = 3
                cardInputView.cardDeletedBlock = {
                    //结束
                    self.removeSameButton.isUserInteractionEnabled = true
                    
                    self.cardArr = ["last"]
                    self.cardBgArr = [1]
                    self.cardStartButton.isHidden = false
                    self.carCollectionView.reloadData()
                }
                return
            }
            
            //开始翻盘
            var num: Int = 0
            if removeSameButton.isSelected {
                //去重
                num = cardNum.cardNoAgainStart()
            } else {
                //不去重
                num = cardNum.cardStart()
            }
            cardInputView.cardTitle.text = "\(num)号卡片"
            cardInputView.cardStr = self.cardArr[num - 1]
            
            cardInputView.addCard = 3
            cardInputView.cardSureBlock = {str in
                
                if self.removeSameButton.isSelected {
                    //去重
                    
                } else {
                    //不去重
                    self.needAnimation = false
                    self.fanCardOutArr[indexPath.item] = num
                    self.cardBgArr[indexPath.item] = 3                    
                    
                }
                self.removeSameButton.isUserInteractionEnabled = false
                self.carCollectionView.reloadData()
            }
            cardInputView.cardDeletedBlock = {
                //结束
                self.removeSameButton.isUserInteractionEnabled = true
                self.cardArr = ["last"]
                self.cardBgArr = [1]
                self.cardStartButton.isHidden = false
                self.carCollectionView.reloadData()
            }

        } else {
            
            if indexPath.item == cardArr.count - 1 {
                
                cardInputView.cardTitle.text = "\(cardArr.count)号卡片"
                cardInputView.addCard = 1
                cardInputView.cardSureBlock = { str in
                    
                    self.cardArr.insert(str, at: self.cardArr.count - 1)
                    self.cardBgArr.insert(2, at: 0)
                    self.carCollectionView.reloadData()
                    self.carCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
                }
            } else {
                cardInputView.cardTitle.text = "\(indexPath.item + 1)号卡片"
                cardInputView.addCard = 2
                cardInputView.cardStr = self.cardArr[indexPath.item]
                cardInputView.cardSureBlock = {str in
                    self.cardArr[indexPath.item] = str
                    self.carCollectionView.reloadData()
                }
                cardInputView.cardDeletedBlock = {
                    
                    self.cardArr.remove(at: indexPath.item)
                    self.cardBgArr.remove(at: 0)
                    self.carCollectionView.reloadData()
                }
                
            }

        }
        
    }
    
    
}







