//
//  HomeVC.swift
//  WaterTracker
//
//  Created by Abcom on 30/03/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var currentQuantityLbl: UILabel!
    
    @IBOutlet weak var goalLbl: UILabel!

    
    @IBOutlet weak var editButtonView: UIButton!{
        didSet{
            editButtonView.layer.cornerRadius =  editButtonView.frame.height / 2
        }
    }
    
    @IBOutlet weak var currentView: UIView!{
        didSet{
            currentView.layer.cornerRadius =  12
        }
    }
    
    @IBOutlet weak var targetView: UIView!{
        didSet{
            targetView.layer.cornerRadius =  12
        }
    }
    
    @IBOutlet weak var addButton: UIButton!{
        didSet{
            addButton.layer.cornerRadius =  addButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.removeHeaderPadding()
            tableView.registerCellNib(LogCell.self)
        }
    }
    
    let vm = HomeViewmodel()
    private var readingArr:[Reading] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        configUI()
    }
    
     func configUI(){
        readingArr = vm.getAlldata()
        currentQuantityLbl.text = "\(vm.getCurrentStat())"
        goalLbl.text = "\(UserDefaultManager.standard.targetGoal)"
         tableView.reloadData()
    }

    func presentAddLogViewController(logSection: AddLogSection, initialValue: CGFloat,targetValue: CGFloat,reading:Reading? = nil) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addLog") as! AddLogVC
        vc.logSection = logSection
        vc.targetValue = 2600.0
        vc.initialValue = initialValue
        vc.savedReading = reading
        
        vc.didDismiss = { [weak self] in
            self?.configUI()
        }
        
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func onClick_Edit(_ sender: UIButton) {
        presentAddLogViewController(logSection: .target, initialValue: CGFloat(UserDefaultManager.standard.targetGoal), targetValue: 2600.0)
    }
    
    @IBAction func onClick_Add(_ sender: UIButton) {
        presentAddLogViewController(logSection: .dailyLog, initialValue: 0.0, targetValue: 2600.0)
    }
    
}

extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String.className(LogCell.self), for: indexPath) as! LogCell
            cell.configCell(reading: readingArr[indexPath.row])
            cell.onClickUpdate = {[weak self] in
                guard let self = self else{return}
                
                presentAddLogViewController(logSection: .updateLog, initialValue: CGFloat(self.readingArr[indexPath.row].quantity), targetValue: 2600.0,reading: self.readingArr[indexPath.row])
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 60
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section{
        case 0:
            let header = TextHeader.loadNib()
            header.configUI(text: "Water Logs" )
            return header
                        
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 60
            
        default:
            return 0
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section{
//        case 5:
//            CommonMethods.callThroughPhoneApp(using: vm.supportContact)
//        default:
//            break;
//        }
//    }
}

