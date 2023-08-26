//
//  ViewController.swift
//  testqwer
//
//  Created by apple on 25/08/23.
//

import UIKit

class ViewController: UIViewController, ShareViewDelegate {
   
    
    
    let screenRect = UIScreen.main.bounds
    var tableView: UITableView  =   UITableView()
    private let sharePresenter = ShareViewPresenter(service:  Service())
       
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
        view.addSubview(tableView)
        sharePresenter.setViewDelegate(shareViewDelegate: self)
        if let oldDatas = UserDefaults.standard.object(forKey: "share") as? [String] {
            oldDatas.forEach { oldData in
                sharePresenter.shareArray.append(oldData)
            }
            tableView.reloadData()
        }
        sharePresenter.getShare()
    }
     
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sharePresenter.timer.invalidate()
        sharePresenter.timer = Timer()
        UserDefaults.standard.set(sharePresenter.shareArray, forKey: "share")
    }
    
    
    func displayShare(description: (String)) {
        if sharePresenter.shareArray.count == 0 {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else if sharePresenter.shareArray.count < 11 {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.beginUpdates()
                let indexPath =  IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                self?.tableView.endUpdates()
            }
        }else{
            DispatchQueue.main.async { [weak self] in
                self?.tableView.beginUpdates()
                let indexPath =  IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                self?.tableView.endUpdates()
                
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: [IndexPath(row: 10, section: 0)], with: .none)
                self?.sharePresenter.shareArray.removeLast()
                self?.tableView.endUpdates()
            }
        }
    }
    
    func setUpView(){
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        tableView.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sharePresenter.shareArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 8
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: screenRect.size.width, height: 100))
        cell.contentView.addSubview(cellView)
        cell.backgroundColor = #colorLiteral(red: 0.7882251143, green: 0.96599859, blue: 0.2397134304, alpha: 1)
        cell.textLabel?.text = sharePresenter.shareArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}


//let horizontalConstraint = NSLayoutConstraint(item: cellView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 8)
//let verticalConstraint = NSLayoutConstraint(item: cellView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 8)
//let widthConstraint = NSLayoutConstraint(item: cellView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 8)
//let heightConstraint = NSLayoutConstraint(item: cellView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 8)
