//
//  ReceiptViewController.swift
//  iOS
//
//  Created by 박다미 on 2023/02/17.
//

import UIKit
//총합과 AllData(품명, 수량, 가격)넘기기
//MARK: WritingEditPageViewController : 영수증정보( 1총합, 2품명, 3수량, 4가격) EditPageViewController로 넘기기
protocol TotalProtocol: AnyObject {
    func sendData(totalPriceData: String, priceData: [AllData],subTotalData:[Int])
}

class ReceiptViewController: UIViewController {
    var delegate: TotalProtocol?
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textInput1: UITextField!
    @IBOutlet weak var textInput2: UITextField!
    @IBOutlet weak var textInput3: UITextField!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    var totalPrice : Int! = 0
    var newTotalPrice : Int! = 0
    @IBOutlet weak var tableView: UITableView!
    var stackLabel : String!
    var stringArr: [AllData] = []
    //var getStringArr: [AllData]? = []
    var stringArr1: [Int] = [] //삭제시 사용할 그 행의 총 가격 subTotalData로 넘김
    var getTotalData: String!
    var getSubTotalData : [Int]?
    //var allData: [AllData]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        addButton.layer.cornerRadius = 5
        
        textInput2.delegate = self
        textInput3.delegate = self
        if getSubTotalData != nil {
            //stringArr1 = getSubTotalData!
            stringArr1.append(contentsOf: getSubTotalData!)
        }
//        if getTotalData != "0"{
//           // totalPrice = Int(getTotalData)
//            
//            totalPriceLabel.text = getTotalData
//            print(totalPriceLabel.text)
//           //totalPrice = Int(totalPriceLabel.text!) ?? 0
//        }
        totalPriceLabel.text = getTotalData
        totalPrice = Int(totalPriceLabel.text ?? "0")

        //totalPrice = Int(totalPriceLabel.text!) ?? 0
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    //사라질때 넘기기
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.sendData(totalPriceData: "\(totalPrice ?? 0)", priceData: stringArr, subTotalData: stringArr1)
        
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if let txt1 = textInput1.text , let txt2 = textInput2.text , let txt3 = textInput3.text{
            if textInput1.text != "" && textInput3.text != ""{
               
                
                let txtString : AllData = AllData(itemData: "\(txt1)", amountData: "\(txt2)", priceData: "\(txt3)") 
                
                
                let input1:Int = Int(textInput2.text ?? "1") ?? 1
                let input2:Int! = Int(textInput3.text!)
                newTotalPrice = input1 * input2
                totalPrice += newTotalPrice
                
                totalPriceLabel.text = "\(totalPrice!)"
                
                self.stringArr.insert(txtString, at: 0)
                self.stringArr1.insert(newTotalPrice, at: 0)
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
                textInput1.text = nil
                textInput2.text = nil
                textInput3.text = nil
                tableView.endUpdates()
            }
            
            
        }
    }
    
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexpath = tableView.indexPathForRow(at: point) else {return}
        totalPrice -= stringArr1[indexpath.row]
        stringArr.remove(at: indexpath.row)
        stringArr1.remove(at: indexpath.row)
        totalPriceLabel.text = "\(totalPrice!) "
        
       
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
        tableView.endUpdates()
    }
    
}

extension ReceiptViewController: UITableViewDelegate, UITableViewDataSource{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as? EditTableViewCell else {return UITableViewCell()}
        cell.itemLabel.text = stringArr[indexPath.row].itemData
        cell.amountLabel.text = stringArr[indexPath.row].amountData
        cell.priceLabel.text = stringArr[indexPath.row].priceData
        return cell
    }
    

}


extension ReceiptViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        
        //숫자만
        if Int(string) != nil || string == "" {
            if Int(string) ?? 0 < 1000000{
                return true
            }
        }
        return false
    }
}
