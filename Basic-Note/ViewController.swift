//
//  ViewController.swift
//  Basic-Note
//
//  Created by Smith on 2015/3/20.
//  Copyright (c) 2015 Smith-Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    var txtFileList:Array<String> = []
    var fm:NSFileManager = NSFileManager()
    var rootPath = NSHomeDirectory() + "/Documents/"
    var documentName:UILabel!
    var documentContent:UILabel!
    var textFieldFileName: UITextField!
    var listTableView: UITableView!
    var btnSaveFile:UIButton!
    var btnDelFile:UIButton!
    var textViewContent: UITextView!
    var theFont:String = "Avenir-Book"
    var fontSize:CGFloat = 15
    var goldColor:UIColor!
    var goldLightColor:UIColor!
    var logo:UILabel!
    
    let cellIdentifier = "cell_indentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var logoPosX:Int = Int(self.view.bounds.width / 2) - 50
        
        var heightTen:CGFloat = (view.bounds.height * 0.125) / 2
        var heightThirty:CGFloat = view.bounds.height * 0.3
        var elementPosX:CGFloat = 15
        var elementPoxY:CGFloat = (heightTen * 2) + elementPosX
        var btnPoxY:CGFloat = (elementPoxY + heightTen + 10) + heightThirty + 10
        var elementWidth:CGFloat = view.bounds.width - 30
        var btnWidth:CGFloat = (view.bounds.width - 40) / 2
        goldColor = UIColor(red: 0.812, green: 0.655, blue: 0.404, alpha: 1)
        goldLightColor = UIColor(red: 0.812, green: 0.655, blue: 0.404, alpha: 0.7)
        
        logo = UILabel()
        logo.frame = CGRect(x: logoPosX, y: Int(heightTen - 10), width: 100, height: 50)
        logo.font = UIFont(name:"untitled-font-1", size:35.0)
        logo.textColor = goldColor
        logo.textAlignment = .Center
        logo.text = "s"
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg")?.drawInRect(self.view.bounds)
        
        var bgImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage:bgImage)
        //        view.backgroundColor = UIColor(patternImage: UIImage(named:"bgImage")!)
        
        textFieldFileName = UITextField()
        textViewContent = UITextView()
        btnSaveFile = UIButton()
        btnDelFile = UIButton()
        
        textFieldFileName.frame = CGRect(x: elementPosX, y: elementPoxY, width: elementWidth, height: heightTen)
        textViewContent.frame = CGRect(x: elementPosX, y: elementPoxY + heightTen + 10, width: elementWidth, height: heightThirty)
        btnSaveFile.frame = CGRect(x: elementPosX, y: btnPoxY, width: btnWidth, height: heightTen)
        btnDelFile.frame = CGRect(x: elementPosX + btnWidth + 10, y: btnPoxY, width: btnWidth, height: heightTen)
        
        textFieldFileName.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        textFieldFileName.layer.borderColor = goldLightColor.CGColor
        textFieldFileName.layer.borderWidth = 1.0
        textViewContent.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        textViewContent.layer.borderColor = goldLightColor.CGColor
        textViewContent.layer.borderWidth = 1.0
        btnSaveFile.backgroundColor = goldLightColor
        btnDelFile.backgroundColor = goldLightColor
        btnSaveFile.titleLabel?.font = UIFont(name: theFont, size: fontSize)
        btnDelFile.titleLabel?.font = UIFont(name: theFont, size: fontSize)
        btnSaveFile.setTitle("SAVE", forState: UIControlState.Normal)
        btnDelFile.setTitle("DELETE", forState: UIControlState.Normal)
        btnSaveFile.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.7), forState: UIControlState.Normal)
        btnDelFile.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.7), forState: UIControlState.Normal)
        
        //textFieldFileName.placeholder = "Enter file name here..."
        if textFieldFileName.text.isEmpty {
            textFieldFileName.text = " Enter file name here..."
            textFieldFileName.textColor = goldLightColor
            textFieldFileName.font = UIFont(name: theFont, size: fontSize)
        }
        
        if textViewContent.text.isEmpty {
            textViewContent.text = "Enter your content here..."
            textViewContent.textColor = goldLightColor
            textViewContent.font = UIFont(name: theFont, size: fontSize)
        }
        
        btnSaveFile.addTarget(self, action: "saveContent:", forControlEvents: UIControlEvents.TouchUpInside)
        btnDelFile.addTarget(self, action: "deleteData:", forControlEvents: UIControlEvents.TouchUpInside)
        
        textFieldFileName.delegate = self
        textViewContent.delegate = self
        
        listTableView = UITableView(frame:CGRectMake(elementPosX, btnPoxY + heightTen + 10, elementWidth, heightThirty + heightTen), style:UITableViewStyle.Plain)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        listTableView.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        listTableView.separatorColor = goldLightColor
        listTableView.separatorInset = UIEdgeInsetsMake(0, 0, view.bounds.width, 0);
        
        txtFileList.removeAll(keepCapacity:true)
        var fileList:Array<NSString> = fm.subpathsAtPath(rootPath) as Array<NSString>
        for file in fileList {
            if file.substringWithRange(NSRange(location: file.length-4, length: 4)) == ".txt" {
                txtFileList.append(file)
            }
        }
        
        view.addSubview(logo)
        view.addSubview(textFieldFileName)
        view.addSubview(textViewContent)
        view.addSubview(btnSaveFile)
        view.addSubview(btnDelFile)
        view.addSubview(listTableView)
        
    }
    
    func saveContent(sender:UIButton){
        if textViewContent.text == "" || textFieldFileName.text == "" {
            var alertView:UIAlertView = UIAlertView(title: "Input Check", message: "Please input file name & content", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        } else {
            var file:NSString = textFieldFileName.text
            if file.substringWithRange(NSRange(location: file.length-4, length: 4)) != ".txt" {
                textFieldFileName.text = textFieldFileName.text + ".txt"
            }
            var fileName = rootPath + textFieldFileName.text
            var flag = textViewContent.text.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
            if flag {
                var alertView:UIAlertView = UIAlertView(title: "File Save", message: "Success", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
                if find(txtFileList, textFieldFileName.text) == nil{
                    txtFileList.append(textFieldFileName.text)
                }
            } else {
                var alertView:UIAlertView = UIAlertView(title: "File Save", message: "Fail", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
        textViewContent.resignFirstResponder()
        listTableView.reloadData()
    }
    
    func deleteData(sender:UIButton){
        if textFieldFileName.text == "" {
            var alertView:UIAlertView = UIAlertView(title: "!", message: "Please choice one", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }else{
            var fileName = rootPath + textFieldFileName.text
            var flag = fm.removeItemAtPath(fileName, error: nil)
            if flag {
                var alertView:UIAlertView = UIAlertView(title: "File Delete", message: "Document remove", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
                var n:Int = find(txtFileList, textFieldFileName.text)!
                txtFileList.removeAtIndex(n)
                textFieldFileName.text = ""
                textViewContent.text = ""
            }else{
                var alertView:UIAlertView = UIAlertView(title: "File Delete", message: "Fail", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
            }
            listTableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return txtFileList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,reuseIdentifier: cellIdentifier) //樣式 及 Identifier 指定
        cell.textLabel?.text = txtFileList[indexPath.row]
        cell.textLabel?.font = UIFont(name: theFont, size: fontSize)
        cell.textLabel?.textColor = goldColor
        cell.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor =  UIColor(red: 0.592, green: 0.482, blue: 0.306, alpha: 1)
        selectedCell.textLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        textFieldFileName.text = txtFileList[indexPath.row]
        var fileName = rootPath + textFieldFileName.text
        var readContent = NSString(contentsOfFile: fileName, encoding: NSUTF8StringEncoding, error: nil)
        textViewContent.text = readContent
        textFieldFileName.textColor = goldColor
        textViewContent.textColor = goldColor
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        selectedCell.textLabel?.textColor = goldColor
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        textField.textColor = goldColor
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
        textView.textColor = goldColor
    }
    
    func textView(textView: UITextView!, shouldChangeTextInRange: NSRange, replacementText: NSString!) -> Bool {
        if(replacementText == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
