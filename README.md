# Basic-Note
Basic Note, .TXT file save、edit, built using Swift, without storyboard

*Create、Save、Edit and Remove .TXT Document File
-------------------------------------------------------------------

自動對應多尺寸螢幕的簡易記事本，能建立、儲存、編輯及刪除 .TXT 文字檔
![image](https://raw.githubusercontent.com/Smith0314/Basic-Note/master/screenshots/iphone5s.png)

![image](https://raw.githubusercontent.com/Smith0314/Basic-Note/master/screenshots/iphone6.png) 

.        

*檔案存取
-------------------------------------------------------------------

使用 NSFileManger 來操作檔案的生成及管理

    var fm:NSFileManager = NSFileManager()
    var rootPath = NSHomeDirectory() + "/Documents/"

    var fileName = rootPath + textFieldFileName.text
    var flag = textViewContent.text.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding, error: nil)

*UI 配置
-------------------------------------------------------------------

事實上檔案管理的 code 佔的成分並不多，畢竟是比 CoreData 簡易的儲存方式，大部份的 code 還是在 UI 的視覺 Layout 上，包括自訂樣式的 UITextView、UITableViewCell，自動對應不同螢幕的 Layout ..等

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
    
    
