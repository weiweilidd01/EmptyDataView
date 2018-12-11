# EmptyDataView
[更多功能，参照demo](https://github.com/weiweilidd01/EmptyDataView.git)

#### 1.基本使用

```
    //网络请求回来后，调用此方法
  // emptyDataView 方法为Extension在UIView中，都能调用

    tableView.emptyDataView(type: .common, hasData: rows == 0 ? false : true)
```

#### 2.若type == .custom,使用注意

```
     //emptyDataDelegate一定要设置在加载前面
     tableView.emptyDataDelegate = self
     tableView.emptyDataView(type: .custom, hasData: res)
     
     
    extension TableViewController: EmptyDataDelegate {
         func emptyData(_ view: UIView) -> EmptyDataConfig {
            let config = EmptyDataConfig(title: "我是自定义", image: UIImage(named: "blankpage_common"))
            return config
    }
}

```

#### 3.更多类型展示

<img src="https://upload-images.jianshu.io/upload_images/2026287-e5f5dbdda7255bf3.gif?imageMogr2/auto-orient/strip" width=200 height=400 />
        
