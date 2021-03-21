//
//  OperatorsViewController.swift
//  RxSwiftExample
//
//  Created by _祀梦 on 2021/3/21.
//

import UIKit

class OperatorsViewController: UIViewController {
    // MARK: - 生命周期及覆盖方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
    
    private var dataList: [RxSwiftOperatorType] = [.createOperator, .conversionOperator, .filterOperator]
}

extension OperatorsViewController: UITableViewDelegate, UITableViewDataSource {
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
        case .createOperator:
            let createObservableOperatorViewController = CreateOperatorsViewController()
            navigationController?.pushViewController(createObservableOperatorViewController, animated: true)
        case .conversionOperator:
            let conversionOperatorViewController = ConversionOperatorsViewController()
            navigationController?.pushViewController(conversionOperatorViewController, animated: true)
        case .filterOperator:
            let filterOperatorsViewController = FilterOperatorsViewController()
            navigationController?.pushViewController(filterOperatorsViewController, animated: true)
        }
    }
}


enum RxSwiftOperatorType: String {
    case createOperator = "创建操作符"
    case conversionOperator = "变换操作符"
    case filterOperator = "过滤操作符"
}
