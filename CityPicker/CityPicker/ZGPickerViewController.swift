//
//  ZGPickerViewController.swift
//  Young_app
//
//  Created by yaojinhai on 2018/11/29.
//  Copyright © 2018年 chinaso. All rights reserved.
//

import UIKit



class ZGPickerViewController: PopBaseViewController {

    private var dataPicker: ZGPickerView!
    


    var finished: ((_ model: [ZGCityModel]) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        dataPicker = ZGPickerView(frame: .init(x: 0, y: height() - 260, width: width(), height: 260));
        addSubview(subView: dataPicker);

        dataPicker.cancelBtn.addTarget(self , action: #selector(buttonAction(_:)), for: .touchUpInside);
        dataPicker.configBtn.addTarget(self , action: #selector(buttonAction(_:)), for: .touchUpInside);
        

        loadSchoolsList();
    }
    
    
    
    @objc func buttonAction(_ btn:UIButton) -> Void {
        self.dismiss(animated: true) {
            
        }
        if let done = finished ,btn === dataPicker.configBtn{
            if let item = (dataPicker.dataModel as? ZGCityModel)?.selectModel {
                done(item);
            }
        }
        
    }
    
    override func dismissViewController() {
        dataPicker.frame.origin.y = height();
    }
    
    
}



extension ZGPickerViewController {
    func loadSchoolsList() -> Void {
        let path = Bundle.main.url(forResource: "city", withExtension: "");
        let data = try? Data(contentsOf: path!);
        let dict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary;
        
        if let list = dict?["data"] as? NSArray,list.count > 0 {

            let cityModel = ZGCityModel();
            cityModel.cityList = [ZGCityModel]();
            for item  in list {
                let model = ZGCityModel(anyData: item);
                cityModel.cityList.append(model);
            }
            self.dataPicker.dataModel = cityModel;
        }
    }
    
    
    
}

extension UIViewController {
    func height() -> CGFloat {
        return self.view.frame.height;
    }
    func width() -> CGFloat {
        return view.frame.width;
    }
    func addSubview(subView: UIView) -> Void {
        view.addSubview(subView);
    }
}


