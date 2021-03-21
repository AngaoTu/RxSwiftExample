//
//  CreateObservableViewController.swift
//  RxSwiftExample
//
//  Created by tuqiangyao on 2021/2/2.
//

import UIKit
import RxSwift
import RxCocoa

class CreateOperatorsViewController: UIViewController {
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
    
    private var dataList: [CreateOperatorType] = [.empty, .just, .of, .from, .deferred, .generate, .error, .range, .timer, .interval, .repeatElement, .never]
}

extension CreateOperatorsViewController: UITableViewDelegate, UITableViewDataSource {
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
        case .empty:
            print("-------------- empty --------------")
            empty()
        case .just:
            print("-------------- just --------------")
            just()
        case .of:
            print("-------------- of --------------")
            of()
        case .from:
            print("-------------- from --------------")
            from()
        case .deferred:
            print("-------------- deferred --------------")
            deferred()
        case .generate:
            print("-------------- generate --------------")
            generate()
        case .error:
            print("-------------- error --------------")
            error()
        case .range:
            print("-------------- range --------------")
            range()
        case .timer:
            print("-------------- timer --------------")
            timer()
        case .interval:
            print("-------------- interval --------------")
            interval()
        case .repeatElement:
            print("-------------- repeatElement --------------")
            repeatElement()
        case .never:
            print("-------------- never --------------")
            never()
        }
    }
}

extension CreateOperatorsViewController {
    private func empty() {
        _ = Observable<Int>.empty().subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func just() {
        let justArray = ["value1", "value2"]
        _ = Observable<[String]>.just(justArray).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func of() {
        _ = Observable<String>.of("value1", "value2").subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
        
        // 字典
        _ = Observable<[String : Any]>.of(["name" : "value1", "age" : "value2"]).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
        
        // 数组
        _ = Observable<[String]>.of(["value1", "value2"]).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func from() {
        _ = Observable<[String]>.from(optional: ["value1", "value2"]).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func deferred() {
        let flag: Bool = true
        _ = Observable<Int>.deferred({ () -> Observable<Int> in
            if flag {
                return Observable.of(1,3,5,7,9)
            }
            return Observable.of(2,4,6,8,10)
        }).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func generate() {
        _ = Observable.generate(initialState: 0, condition: { $0 < 10 }, iterate: { $0 + 2 }).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func error() {
        _ = Observable<String>.error(NSError.init(domain: "error", code: 100, userInfo: ["reson" : "unknow"])).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func range() {
        _ = Observable.range(start: 2, count: 5).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func timer() {
        _ = Observable<Int>.timer(RxTimeInterval(5), period: RxTimeInterval(2), scheduler: MainScheduler.instance).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func interval() {
        _ = Observable<Int>.interval(RxTimeInterval(1), scheduler: MainScheduler.instance).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func repeatElement() {
        _ = Observable<Int>.repeatElement(5).subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
    
    private func never() {
        _ = Observable<String>.never().subscribe(onNext: { (value) in
            print("订阅: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }, onDisposed: {
            print("释放")
        })
    }
}

enum CreateOperatorType: String {
    case empty
    case just
    case of
    case from
    case deferred
    case generate
    case error
    case range
    case timer
    case interval
    case repeatElement
    case never
}
