//
//  ShareViewPresenter.swift
//  testqwer
//
//  Created by apple on 25/08/23.
//

import Foundation

protocol ShareViewDelegate: NSObjectProtocol {
    func displayShare(description:(String))
}

class ShareViewPresenter {
    private let service : Service
    weak private var shareViewDelegate : ShareViewDelegate?
    var shareArray = [String]()
    var timer = Timer()
    
    init(service:Service){
        self.service = service
    }
    
    func setViewDelegate(shareViewDelegate:ShareViewDelegate?){
        self.shareViewDelegate = shareViewDelegate
    }
    
    func getShare(){
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
     
    
    @objc  func timerAction() {
        //Call api here
        service.getDataFromApi() { [weak self] traficLight,newStatus in
            if let newStatus, newStatus == true {
                self?.shareArray.insert(traficLight ?? "", at: 0)
                self?.shareViewDelegate?.displayShare(description: traficLight?.description ?? "")
            }else{
                print("Somthing want wrong")
            }
        }
    }
    
} 
