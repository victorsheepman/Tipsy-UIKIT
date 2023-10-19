

import UIKit

class CalculatorViewController: UIViewController {

    //variables de botones y labels
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    
    var tip = 0.10
    var peopleToSplit = 2
    var splitToShow = "0.00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //primera action para botones
    @IBAction func tipChanged(_ sender: UIButton) {
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        //Get the value button on double
        let selectedValue = sender.currentTitle!
        let removeMinuSign = String(selectedValue.dropLast())
        let buttonValue = Double(removeMinuSign)
        tip = buttonValue!/100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        let value =  String(sender.value.description.dropLast(2))
        splitNumberLabel.text =  value
        peopleToSplit = Int(sender.value)
        
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let splitValue = splitNumberLabel.text
        let billValue = Double(billTextField.text!.replacingOccurrences(of: ",", with: ".")) ?? 0.0;
        let split = (billValue * (1 + tip) / Double(peopleToSplit))
        
        splitToShow =  String(split)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.totalResult =  splitToShow
            destinationVC.peopleToSplit = peopleToSplit
            destinationVC.tipPercentage = Int(tip * 100)
        }
    }
}

