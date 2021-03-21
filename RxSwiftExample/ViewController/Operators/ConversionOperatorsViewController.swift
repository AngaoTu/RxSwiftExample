//
//  ConversionViewController.swift
//  RxSwiftExample
//
//  Created by tuqiangyao on 2021/2/5.
//

import UIKit
import RxSwift
import RxCocoa

class ConversionOperatorsViewController: UIViewController {
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
    
    private var dataList: [ConversionOperatorType] = [.map, .flatMap, .flatMapLatest, .scan, .buffer, .window]
    
    private let disposeBag = DisposeBag()
}

extension ConversionOperatorsViewController: UITableViewDelegate, UITableViewDataSource {
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
        case .map:
            print("-------------- map --------------")
            map()
        case .flatMap:
            print("-------------- flatMap --------------")
            flatMap()
        case .flatMapLatest:
            print("-------------- flatMapLatest --------------")
            flatMapLatest()
        case .scan:
            print("-------------- scan --------------")
            scan()
        case .buffer:
            print("-------------- buffer --------------")
            buffer()
        case .window:
            print("-------------- window --------------")
            window()
        }
    }
}

extension ConversionOperatorsViewController {
    func map() {
        Observable.of(1, 2, 3).map({ $0 * 10 }).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        }).disposed(by: disposeBag)
    }
    
    func flatMap() {
        Observable.of(1, 2, 3).flatMap { (item) -> Observable<String> in
            return Observable<String>.just("\(item) + flatMap")
        }.subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        }).disposed(by: disposeBag)
    }
    
    func flatMapLatest() {
        Observable.of(1, 2, 3).flatMapLatest { (item) -> Observable<String> in
            return Observable<String>.just("\(item) + flatMap")
        }.subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        }).disposed(by: disposeBag)
    }
    
    func scan() {
        Observable.of(1, 2, 3, 4, 5).scan(0, accumulator: { (accum, elemeent) -> Int in
            return accum + elemeent
        }).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        }).disposed(by: disposeBag)
    }
    
    func buffer() {
        let subject = PublishSubject<String>()
        
        subject.buffer(timeSpan: RxTimeInterval(1), count: 3, scheduler: MainScheduler.instance).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        }).disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
         
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
    
    func window() {
        let subject = PublishSubject<String>()
        
        subject.window(timeSpan: RxTimeInterval(1), count: 3, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] (value) in
            guard let self = self else { return }
            print("订阅: \(value)")
            value.asObservable().subscribe(onNext: {  (value) in
                print("订阅: \(value)")
            }).disposed(by: self.disposeBag)
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        }).disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
         
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
}

enum ConversionOperatorType: String {
    case map
    case flatMap
    case flatMapLatest
    case scan
    case buffer
    case window
}
