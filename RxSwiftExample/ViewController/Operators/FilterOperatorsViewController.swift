//
//  FilterOperationsViewController.swift
//  RxSwiftExample
//
//  Created by tuqiangyao on 2021/2/7.
//

import Foundation
import RxSwift
import RxCocoa

class FilterOperatorsViewController: UIViewController {
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
    
    private var dataList: [FilterOperatorType] = [.filter, .distinctUntilChanged, .elementAt, .single, .take, .takeLast, .takeWhile, .takeUntil, .skip, .skipUntil, .ignoreElements, .sample, .debounce, .distinct, .first, .last]
    
    private let disposeBag = DisposeBag()
}

extension FilterOperatorsViewController: UITableViewDelegate, UITableViewDataSource {
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
        case .filter:
            print("-------------- filter --------------")
            filter()
        case .distinctUntilChanged:
            print("-------------- distinctUntilChanged --------------")
            distinctUntilChanged()
        case .elementAt:
            print("-------------- elementAt --------------")
            elementAt()
        case .single:
            print("-------------- single --------------")
            single()
        case .take:
            print("-------------- take --------------")
            take()
        case .takeLast:
            print("-------------- takeLast --------------")
            takeLast()
        case .takeWhile:
            print("-------------- takeWhilt --------------")
            takeWhile()
        case .skip:
            print("-------------- takeSkip --------------")
            skip()
        case .skipUntil:
            print("-------------- skipUntil --------------")
            skipUntil()
        case .ignoreElements:
            print("-------------- ignoreElements --------------")
            ignoreElements()
        case .sample:
            print("-------------- sample --------------")
            sample()
        case .debounce:
            print("-------------- debounce --------------")
            debounce()
        case .distinct:
            print("-------------- distinct --------------")
            distinct()
        case .first:
            print("-------------- first --------------")
            first()
        case .last:
            print("-------------- last --------------")
            last()
        default:
            break
        }
    }
}

extension FilterOperatorsViewController {
    private func filter() {
        
    }
    
    private func distinctUntilChanged() {
        
    }
    
    private func elementAt() {
        
    }
    
    private func single() {
        
    }
    
    private func take() {
        
    }
    
    private func takeLast() {
        
    }
    
    private func takeWhile() {
        
    }
    
    private func takeUntil() {
        
    }
    
    private func skip() {
        
    }
    
    private func skipUntil() {
        
    }
    
    private func ignoreElements() {
        
    }
    
    private func sample() {
        
    }
    
    private func debounce() {
        
    }
    
    private func distinct() {
        
    }
    
    private func first() {
        
    }
    
    private func last() {
        
    }
}

enum FilterOperatorType: String {
    case filter
    case distinctUntilChanged
    case elementAt
    case single
    case take
    case takeLast
    case takeWhile
    case takeUntil
    case skip
    case skipUntil
    case ignoreElements
    case sample
    case debounce
    case distinct
    case first
    case last
}
