//
//  ViewController.swift
//  CityPicker
//
//  Created by yaojinhai on 2019/3/7.
//  Copyright © 2019年 yaojinhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIButton(frame: .init(x: 40, y: 40, width: width() - 80, height: 60));
        addSubview(subView: btn);
        btn.backgroundColor = UIColor.lightGray;
        btn.setTitle("选择城市", for: .normal);
        btn.titleLabel?.textAlignment = .center;
        btn.titleLabel?.numberOfLines = 0;
        btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside);
        
    }
    

    @objc func buttonAction(_ btn: UIButton) -> Void {
        let ctrl = ZGPickerViewController();
        ctrl.finished = {
            (list: [ZGCityModel]) -> Void in
            btn.setTitle("城市\n\(list.last!.name)", for: .normal);
        }
        present(ctrl, animated: true) {
            
        }
    }

}

