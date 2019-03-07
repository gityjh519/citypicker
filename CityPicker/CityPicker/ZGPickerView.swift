//
//  ZGPickerView.swift
//  Young_app
//
//  Created by yaojinhai on 2018/11/29.
//  Copyright © 2018年 chinaso. All rights reserved.
//

import UIKit

public class ZGPickerView: UIView {

    private var dataPicker: UIPickerView!
    public var configBtn: UIButton!
    public var cancelBtn: UIButton!
    
    public lazy var selectedItem = [Int:Int]();
    
    public var dataModel: PickerDataModelDelegate! {
        didSet{
            reloadData();
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        backgroundColor = rgbColor(rgb: 249);
        
        cancelBtn = UIButton(frame: .init(x: 0, y: 0, width: 80, height: 46));
        configBtn = UIButton(frame: .init(x: frame.width - cancelBtn.frame.width, y: 0, width: cancelBtn.frame.width, height: cancelBtn.frame.height))
        cancelBtn.setTitle("取消", for: .normal);
        configBtn.setTitle("确定", for: .normal);
        addSubview(cancelBtn);
        addSubview(configBtn);
        
        let color = rgbColor(r: 0, g: 109, b: 251);
        cancelBtn.setTitleColor(color, for: .normal);
        configBtn.setTitleColor(color, for: .normal);
        
        
        
        dataPicker = UIPickerView(frame: .init(x: 0, y: cancelBtn.frame.height, width: frame.width, height: frame.height - cancelBtn.frame.height));
        addSubview(dataPicker);
        dataPicker.showsSelectionIndicator = true;
        dataPicker.backgroundColor = UIColor.white;
        dataPicker.dataSource = self;
        dataPicker.delegate = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reloadData() -> Void {
        dataPicker?.reloadAllComponents();
    }
    
    func rgbColor(rgb: CGFloat) -> UIColor {
        return rgbColor(r: rgb, g: rgb, b: rgb);
    }
    func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1);
    }

}
extension ZGPickerView: UIPickerViewDataSource,UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataModel?.itemOfColum ?? 0;
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataModel?.numberOrRows(column: component) ?? 0;
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataModel?.title(column: component, row: row) ?? "没有数据";
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedItem[component] = row;

        dataModel?.selected(column: component, row: row);
        let counts = dataModel?.itemOfColum ?? 0;
        let fromIdx = component + 1;
        if fromIdx >= counts {
            return;
        }
        for idx in fromIdx..<counts {
            pickerView.reloadComponent(idx);
            selectedItem[idx] = 0;
            pickerView.selectRow(0, inComponent: idx, animated: true);
        }
    }
    
    
    
}

@objc
public protocol PickerDataModelDelegate: NSObjectProtocol{
    var itemOfColum: Int {get}
    func numberOrRows(column: Int) -> Int
    func title(column:Int,row: Int) -> String
    func selected(column: Int,row: Int)
}
