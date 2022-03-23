//
//  TimerHandler.swift
//  SlidingPhotos
//
//  Created by Alex Shum on 23/03/2022.
//

import Foundation


class TimerHandler{
    
    private var counter:Int
    
    private var timer:Timer

    
    init(){
        self.timer = Timer()
        self.counter = 0
    }
    
    //func bruhcounting(){
      //  timer = Timer.scheduledTimer(timeInterval: 1, target: <#T##Any#>, selector: <#T##Selector#>, userInfo: nil, repeats: true)
    //}
    
    func counting(){
        self.counter += 1
    }
    
    func stopCounting(){
        timer.invalidate()
    }
}
