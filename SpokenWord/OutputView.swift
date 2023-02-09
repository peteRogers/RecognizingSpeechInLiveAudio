//
//  TextView.swift
//  SpokenWord
//
//  Created by Peter Rogers on 09/02/2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit
import Speech

@available(iOS 13, *)
class OutputView: UIView {
    
    public var voice: SFVoiceAnalytics?
    public var utterance:String?
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        draw(context: context)
        
        // Drawing code
        
    }
    
    func draw(context: CGContext){
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineCap(.round)
        context.beginPath()
        var inc = 0.0
        var multiplier:Double = 6
        context.move(to: CGPoint(x: 0, y: frame.height))
        for i in voice?.shimmer.acousticFeatureValuePerFrame ?? []{
            context.addLine(to:CGPoint(x: inc, y: frame.height - i * multiplier))
            inc += 5
        }
        inc = 0
        context.strokePath()
       // print(voice?.voicing)
        for i in voice?.voicing.acousticFeatureValuePerFrame ?? []{

            if(i > 0.5){
                context.setFillColor(CGColor(red: 1, green: 0, blue: 0, alpha: 1))
            }else{
                context.setFillColor(CGColor(red: 0, green: 0, blue: 1, alpha: 1))
            }
            context.fill( CGRect(x: inc, y: 0, width: 5, height: frame.height))
            inc += 5
        }
        
        let highScore = (voice?.shimmer.acousticFeatureValuePerFrame.max() ?? 0)
       
        let font = UIFont.systemFont(ofSize: highScore * multiplier)
        let string = NSAttributedString(string: utterance ?? "X", attributes: [NSAttributedString.Key.font: font])
        let textPos = (self.frame.width/2) - (string.size().width/2)
        print(textPos)
        string.draw(at: CGPoint(x: CGFloat(textPos), y: CGFloat((self.frame.height / 2.0) - highScore * multiplier)))
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .red
    }
    
    
}
