//
//  AddLogVC.swift
//  WaterTracker
//
//  Created by Abcom on 30/03/24.
//

import UIKit

enum AddLogSection:String{
    case dailyLog = "Add water log"
    case target = "Add target hydration"
    case updateLog = "Update water log"
}

let screenWidth = UIScreen.main.bounds.size.width

class AddLogVC: UIViewController {
    let dr: TimeInterval = 20.0
    var timer: Timer?
    let waterWaveView = WaterWaveView()
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!{
        didSet{
            saveButton.layer.cornerRadius =  12
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
            addButton.layer.cornerRadius =  12
        }
    }
    
    @IBOutlet weak var minusButton: UIButton!{
        didSet{
            minusButton.layer.cornerRadius =  12
        }
    }
    
    var logSection:AddLogSection = .dailyLog
    
    var targetValue:CGFloat = 2600.0
    var initialValue:CGFloat = 0.0
    
    var savedReading:Reading?
    
    var didDismiss:(()->())?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(waterWaveView)
        waterWaveView.setupProgress(waterWaveView.progress, finalValue: 2600)
        
        
        waterWaveView.anchor(top: self.view.topAnchor, paddingTop: 170, width: screenWidth*0.5, height: screenWidth*0.5, isGreaterThanTop: true)        
        waterWaveView.centerX(inView: self.view)
        
        configUI()
    }
    
    func configUI(){
        titleLbl.text = logSection.rawValue
    }
    
    @IBAction func onClick_Remove(_ sender: UIButton) {
        
        if self.waterWaveView.progress < 0.99 && self.waterWaveView.progress > 0.0  {
            
            animate(progress: CGFloat(-10.0/targetValue))
        }
    }
    
    @IBAction func onClick_Add(_ sender: UIButton) {
        
        if self.waterWaveView.progress < 0.99 && self.waterWaveView.progress >= 0.0  {
            
            animate(progress: CGFloat(10.0/targetValue))
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animate(progress: CGFloat(initialValue/targetValue))
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        let quantity = self.waterWaveView.progress * CGFloat(targetValue)

        if logSection == .target{
            
            UserDefaultManager.standard.targetGoal = Int(quantity)
            
        }else if logSection == .dailyLog{
            
            saveReading(date: Date(), quantity: quantity) // Example usage

        }else{
            
            
            updateReading(savedReading: savedReading, quantity: quantity)
            
            
        }
        
        self.dismiss(animated: true) {[weak self] in
            self?.didDismiss?()
        }
    }
    
    func animate(progress:CGFloat){
        
        self.waterWaveView.progress += progress
        self.waterWaveView.setupProgress(self.waterWaveView.progress, finalValue: targetValue)
        
        print(self.waterWaveView.progress)
        
        
        self.timer?.invalidate()
        self.timer = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.waterWaveView.percentAnim()
        }
        
    }
    
    func saveReading(date: Date, quantity: Double) {
        CoreDataStack.shared.save(date: date, quantity: quantity)
    }
    
    func updateReading(savedReading: Reading?, quantity: Double) {
        
        guard let savedReading = savedReading else{return}        
        CoreDataStack.shared.update(item: savedReading, quantity: Int(quantity))
    }

    
}

