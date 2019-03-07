//
//  ZGCityModel.swift
//  Young_app
//
//  Created by yaojinhai on 2018/11/30.
//  Copyright © 2018年 chinaso. All rights reserved.
//

import UIKit

class ZGCityModel: BaseModel {
    
    private var selectedDict = [Int:Int]();


    var cityList: [ZGCityModel]!
    @objc var name = "未选择";
    @objc var id = "";
    
    override func setValue(_ value: Any?, forKey key: String) {
        switch key {
        case "area": fallthrough
        case "city":
            guard let list = value as? NSArray else{
                return;
            }
            cityList = [ZGCityModel]();
            for item in list {
                let model = ZGCityModel(anyData: item);
                cityList.append(model);
            }
        default:
            super.setValue(value, forKey: key);
        }
    }
}


extension ZGCityModel:PickerDataModelDelegate {
    
    var selectModel: [ZGCityModel]?{
        
        var list = [ZGCityModel]();
        let fidx = selectedDict[0] ?? 0;
        if let fmodel = listModel(at: 0) {
            if fmodel.count > fidx {
                list.append(fmodel[fidx]);
            }
        }
        
        
        let sidx = selectedDict[1] ?? 0;
        if let semodel = listModel(at: 1) {
            if semodel.count > sidx {
                list.append(semodel[sidx]);
            }
        }
        
        
        let ssidx = selectedDict[2] ?? 0;
        if let ssmodel = listModel(at: 2){
            if ssmodel.count > ssidx {
                list.append(ssmodel[ssidx]);
            }
        }
        
        if list.count == 3 {
            return list;
        }
        
        return nil;
    }
    
    
    func listModel(at column: Int) -> [ZGCityModel]? {
        if cityList == nil {
            return nil;
        }
        if column == 0  {
            return cityList;
        }else if column == 1 {
            let fidx = selectedDict[0] ?? 0;
            if cityList.count > fidx {
                let list = cityList[fidx].cityList;
                return list;
            }
        }else if column == 2 {
            
            guard let scondList = listModel(at: 1) else{
                return nil;
            }
            let sIdx = selectedDict[1] ?? 0;
            if scondList.count > sIdx {
                let list = scondList[sIdx].cityList;
                return list;
            }
        }
        return nil;
    }
    
    var itemOfColum: Int {
        return 3;
    }
    
    func numberOrRows(column: Int) -> Int {
        return listModel(at: column)?.count ?? 0;
    }
    
    func title(column: Int, row: Int) -> String {
        guard let list = listModel(at: column) else{
            return "";
        }
        if list.count > row {
            return list[row].name;
        }
        return "";
    }
    func selected(column: Int, row: Int) {

        selectedDict[column] = row;
        let others = column + 1;
        for idx in others..<3 {
            selectedDict[idx] = 0;
        }
        
    }
}
