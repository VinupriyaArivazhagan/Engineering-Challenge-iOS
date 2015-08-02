//
//  ViewController.swift
//  Holmusk
//
//  Created by Vinupriya on 7/29/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblHolmusk: UILabel!
    @IBOutlet weak var lblFeature: UILabel!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var btnGo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGo.layer.cornerRadius = btnGo.frame.size.width/2
        btnGo.layer.masksToBounds = true
        
        doSomeInitialAnimation() // do some initial animation
    }

    
    
    @IBAction func btnGoTouchDown(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: {
            self.btnGo.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: { finished in
        })
    }
    
    @IBAction func btnGoTouchUpInside(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.btnGo.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { finished in
                self.doSomeFinalAnimation() // do some final animation
        })
    }
    
    private func doSomeInitialAnimation()
    {
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.tipView.hidden = false
            self.tipView.alpha = 1
            }, completion: { finished in
                UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
                    self.btnGo.hidden = false
                    self.btnGo.alpha = 1
                    }, completion: { finished in
                        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
                            
                            self.btnGo.transform = CGAffineTransformMakeScale(1.5, 1.5)
                            }, completion: { finished in
                                UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
                                    
                                    self.btnGo.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: { finished in
                                        self.btnGo.userInteractionEnabled = true
                                })
                        })
                })
        })
        
    }
    
    
    private func doSomeFinalAnimation()
    {
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.btnGo.alpha = 0
            }, completion: { finished in
                UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
                    self.tipView.alpha = 0
                    }, completion: { finished in
                        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
                            self.lblFeature.alpha = 0
                            }, completion: { finished in
                            UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
                                self.lblHolmusk.alpha = 0
                            }, completion: { finished in
                        let searchCon : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchViewController") as! UINavigationController
                        self.presentViewController(searchCon, animated: true, completion: nil)
                    })
                })
            })
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

