//
//  HomeViewController.swift
//  iOS
//
//  Created by 이정동 on 2023/01/17.
//

import UIKit
import CalendarDateRangePicker


class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var upcomingSchedules: [Schedule] = []
    var previousSchedules: [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Travelog"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        readScheduleData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    // 여행 일정 불러오기
    /// - parameter uid : 로그인 유저 ID
    func readScheduleData() {
        let user = UserDefaults.standard.getLoginUser()!
        
        ScheduleNetManager.shared.read(uid: user.uid!) { schedules in
            self.upcomingSchedules = schedules
            
            self.divideScheduleData(schedules: self.upcomingSchedules)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func divideScheduleData(schedules: [Schedule]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let currentDate = formatter.string(from: Date())
        
        for schedule in schedules {
            if currentDate <= schedule.stop! {
                break
            }
            self.previousSchedules.insert(schedule, at: 0)
//            self.previousSchedules.append(schedule)
            self.upcomingSchedules.removeFirst()
        }
    }
    
    // 테이블 뷰 세팅
    func setupTableView() {
        //register TableViewCell
        tableView.register(UINib(nibName:"FirstTableViewCell", bundle: nil), forCellReuseIdentifier:"FirstTableViewCell")
        tableView.register(UINib(nibName:"CalendarTableViewCell", bundle: nil), forCellReuseIdentifier:"CalendarTableViewCell")
        
        tableView.register(UINib(nibName:"SecondTableViewCell", bundle: nil), forCellReuseIdentifier:"SecondTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    @IBAction func createScheduleBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let planningVC = storyboard?.instantiateViewController(withIdentifier: "PlanningVC") as! PlanningViewController
        
        navigationController?.pushViewController(planningVC, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            cell.configure()
            cell.selectionStyle = .none
            cell.schedules = self.upcomingSchedules
            
            // 여행일정 셀 클릭 시 동작할 기능 정의
            cell.didSelectItem = { schedule in
                let mainPlanVC = self.storyboard?.instantiateViewController(withIdentifier: "MainPlanViewController") as! MainPlanViewController
                self.navigationController?.pushViewController(mainPlanVC, animated: true)
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            cell.selectionStyle = .none
            cell.schedules = self.previousSchedules
            
            cell.didSelectItem = { schedule in
                let mainPlanVC = self.storyboard?.instantiateViewController(withIdentifier: "MainPlanViewController") as! MainPlanViewController
                self.navigationController?.pushViewController(mainPlanVC, animated: true)
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let interval:CGFloat = 3
        let width: CGFloat = ( UIScreen.main.bounds.width - interval * 3 ) / 2
        
        switch indexPath.row {
        case 0:
            return 130
        case 1:
            return 400
        case 2:
            return 300
            
            //            return (width + 40 + 3) * 5 + 40
        default:
            return 0
        }
        
    }
}
