//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by tuqiangyao on 2021/1/8.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "RxSwiftExample"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - 私有属性
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.delegate = self
        temp.dataSource = self
        temp.rowHeight = 44
        temp.register(SimpleTextTableViewCell.self, forCellReuseIdentifier: "SimpleTextTableViewCell")
        return temp
    }()
    
    private var dataList: [RxSwiftType] = [.coreLogic, .operators]
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleTextTableViewCell", for: indexPath) as? SimpleTextTableViewCell else { return UITableViewCell() }
        cell.textString = dataList[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataList[indexPath.row] {
        case .coreLogic:
            self.coreLogic()
        case .operators:
            let operatorsViewController = OperatorsViewController()
            navigationController?.pushViewController(operatorsViewController, animated: true)
        default:
            break
        }
    }
}

extension ViewController {
    private func coreLogic() {
        // 1: 创建序列
        let observable = Observable<Any>.create { (observer) -> Disposable in
            // 3: 发送响应
            observer.onNext("发送信号")
            observer.onCompleted()
            return Disposables.create()
        }
                
        // 2: 订阅序列
        let _ = observable.subscribe(onNext: { (text) in
            print("订阅到信号:\(text)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }) {
            print("销毁")
        }
    }
}

enum RxSwiftType: String {
    case coreLogic = "核心逻辑"
    case operators = "操作符"
    case dispose = "销毁者"
    case scheduler = "调度者"
    case subject = "Observable & Observer"
}
