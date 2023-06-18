//
//  FirstTableViewCell.swift
//  iOS
//
//  Created by 박다미 on 2023/01/21.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var indexLabel: UILabel!
 
    var didSelectItem: ((_ schedule: Schedule)->())? = nil
    
    var schedules: [Schedule]?
    
    func configure(){
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //collectionCell register
        collectionView.register(UINib(nibName:"FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier : "FirstCollectionViewCell")
        collectionView.register(UINib(nibName: "BlankCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BlankCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 여행 진행 상태 계산 (진행 or 예정)
    func calcTripState(startDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let now = formatter.string(from: Date())
        
        if now >= startDate {
            return "🔴 여행 중"
        } else {
            return "🟢 예정"
        }
    }
    
}


extension FirstTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedules?.isEmpty == true ? 1 : schedules?.count ?? 0

        // return schedules?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if schedules?.isEmpty == true {
                  let blankCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlankCollectionViewCell", for: indexPath) as! BlankCollectionViewCell
            blankCell.textLabel.text = "등록된 여행정보가 없습니다"
                  return blankCell
              } else {
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
                  
                  guard let schedule = schedules?[indexPath.item] else { return UICollectionViewCell() }
                  
                  cell.tripDate.text = "\(schedule.start!) ~ \(schedule.stop!)"
                  cell.tripState.text = calcTripState(startDate: schedule.start!)
                  cell.tripTitle.text = schedule.title
                  cell.tripImage.image = UIImage(named: "tripimg")
                  
                  return cell
              }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if schedules?.isEmpty == true {
            // BlankCollectionViewCell인 경우에는 아무 동작도 수행하지 않음
            return
        }
        
        guard let schedule = schedules?[indexPath.item] else {
            // schedules 배열의 인덱스에 접근할 수 없는 경우
            return
        }
        
        didSelectItem?(schedule)
    
    
//        let schedule = schedules![indexPath.item]
//
//        // 여행 일정 클릭 시 상세 일정 페이지로 이동
//        didSelectItem?(schedule)
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           if let visibleIndexPaths = collectionView.indexPathsForVisibleItems.first {
               if let count = schedules?.count {
                   indexLabel.text = "\(visibleIndexPaths.item + 1)/\(count)"
               }
           } else {
               indexLabel.text = "0/0"
           }
       }
}
