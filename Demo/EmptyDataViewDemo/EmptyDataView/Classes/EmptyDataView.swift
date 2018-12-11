//
//  BlankPageView.swift
//  DDMall
//
//  Created by cw on 2018/3/23.
//  Copyright © 2018年 dd01. All rights reserved.
//

import SnapKit
import UIKit

public struct EmptyDataConfig {
    public var title: String?
    public var image: UIImage?
    
    public init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}

public protocol EmptyDataDelegate: NSObjectProtocol {
    func emptyData(_ view: UIView) -> EmptyDataConfig
}

public enum EmptyDataType {
    case common
    case search
    case wifi
    case message
    case activity
    case integral
    case license
    case todo
    case comment
    case like
    case custom
}

public typealias  EmptyDataClickBlock = (() -> Void)?

extension UIView {
    
   
    private struct EmptyDataKey {
        static var managerKey = "EmptyDateViewKey"
        static var emptyDataDelegateKey = "emptyDataDelegateKey"
    }
    
    fileprivate var blankView: EmptyDataView? {
        set (value) {
            objc_setAssociatedObject(self, &EmptyDataKey.managerKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &EmptyDataKey.managerKey) as? EmptyDataView
        }
    }
    
    public weak var emptyDataDelegate: EmptyDataDelegate? {
        set (value) {
            if blankView == nil {
                blankView = EmptyDataView(frame: bounds)
                blankView?.isUserInteractionEnabled = true
                blankView?.delegate = value
            }
            objc_setAssociatedObject(self, &EmptyDataKey.emptyDataDelegateKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &EmptyDataKey.emptyDataDelegateKey) as? EmptyDataDelegate
        }
    }
    
    fileprivate var blankPageContainer: UIView {
        var bView = self
        for view in subviews {
            if let view = view as? UIScrollView {
                bView = view
            }
        }
        return bView
    }
    
    /// scrollView或者view直接调用
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - offSet: 中心点偏移的位置
    ///   - showImage: 是否显示图片
    ///   - showButton: 是否显示按钮
    ///   - btnTitle: 按钮的title
    ///   - hasData: 是否有数据
    ///   - clickAction: 按钮点击回调
    public func emptyDataView(type: EmptyDataType = .common,
                              hasData: Bool,
                             offSet: CGPoint = CGPoint.zero,
                             showImage: Bool = true,
                             showButton: Bool = false,
                             btnTitle: String = "确定",
                             clickAction: EmptyDataClickBlock = nil) {
        guard !hasData else {
            cleanBlankView()
            setScrollEnabled(true)
            return
        }
        if blankView == nil {
            blankView = EmptyDataView(frame: bounds)
            blankView?.isUserInteractionEnabled = true
        }
        blankView?.isHidden = false
        
        blankView?.backgroundColor = backgroundColor
        if let blankView = blankView {
            blankPageContainer.insertSubview(blankView, at: 0)
        }
    
        setScrollEnabled(false)
        let result: EmptyDataClickBlock = {[weak self] in
            self?.cleanBlankView()
            self?.setScrollEnabled(true)
            clickAction?()
        }
        
        blankView?.config(type: type,
                      offSet: offSet,
                      showImage: showImage,
                      showButton: showButton,
                      btnTitle: btnTitle,
                      hasData: hasData,
                      clickAction: result)
    }
    
    private func cleanBlankView() {
        blankView?.isHidden = true
        blankView?.removeFromSuperview()
        blankView = nil
    }
    
    private func setScrollEnabled(_ enabled: Bool) {
        if let scroll = blankPageContainer as? UIScrollView {
            scroll.isScrollEnabled = enabled
        }
    }
}

public class EmptyDataView: UIView {
    fileprivate weak var delegate: EmptyDataDelegate?
    public let blankImage = UIImageView(frame: CGRect.zero)
    public let tipLabel = UILabel(frame: CGRect.zero)
    public let operateButton = UIButton(type: .custom)
    var clickBlock: EmptyDataClickBlock
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func config(type: EmptyDataType, offSet: CGPoint, showImage: Bool, showButton: Bool, btnTitle: String, hasData: Bool, clickAction: EmptyDataClickBlock) {
        guard !hasData else {
            removeFromSuperview()
            return
        }
        blankImage.isHidden = !showImage
        addSubview(blankImage)
        blankImage.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX).offset(offSet.x)
            make.centerY.equalTo(snp.centerY).offset(-40 + offSet.y)
        }
        tipLabel.font = UIFont.systemFont(ofSize: 16)
        tipLabel.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        tipLabel.textAlignment = .center
        addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-20)
            if showImage {
                make.top.equalTo(blankImage.snp.bottom).offset(10)
            } else {
                make.centerY.equalTo(snp.centerY).offset(-40 + offSet.y)
            }
        }
        operateButton.isHidden = !showButton
        addSubview(operateButton)
        operateButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(44)
            make.centerX.equalTo(snp.centerX).offset(offSet.x)
            make.top.equalTo(tipLabel.snp.bottom).offset(40)
        }
        operateButton.setTitleColor( #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        operateButton.backgroundColor = #colorLiteral(red: 0, green: 0.5803921569, blue: 1, alpha: 1)
        operateButton.setTitle(btnTitle, for: .normal)
        operateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        operateButton.addTarget(self, action: #selector(clickBtnAction), for: .touchUpInside)
        clickBlock = clickAction
        updateContent(type: type)
    }
    
    @objc func clickBtnAction() {
        clickBlock?()
    }
    
    private func updateContent(type: EmptyDataType) {
        var image: UIImage? = self.image(ForName: "blankpage_common")
        var title = ""
        switch type {
        case .common:
            image = self.image(ForName: "blankpage_common")
            title = NSLocalizedString("暂无内容", comment: "")
        case .license:
            image = self.image(ForName: "blankpage_search")
            title = NSLocalizedString("您目前没有绑定任何车牌", comment: "")
            operateButton.setTitle(NSLocalizedString("添加", comment: ""), for: .normal)
        case .activity:
            image = self.image(ForName: "blankpage_activity")
            title = NSLocalizedString("暂无活动", comment: "")
        case .integral:
            image = self.image(ForName: "blankpage_integral")
            title = NSLocalizedString("暂无卡券", comment: "")
        case .message:
            image = self.image(ForName: "blankpage_message")
            title = NSLocalizedString("这里还没有任何消息哦", comment: "")
        case .wifi:
            image = self.image(ForName: "blankpage_wifi")
            title = NSLocalizedString("oops!沒有网络讯号", comment: "")
        case .search:
            image = self.image(ForName: "blankpage_search")
            title = NSLocalizedString("没有搜寻结果", comment: "")
        case .todo:
            image = self.image(ForName: "blankpage_todo")
            title = NSLocalizedString("该功能暂未上线，敬请期待！", comment: "")
        case .comment:
            image = self.image(ForName: "iconNoComment")
            title = NSLocalizedString("没有收到评论哦~", comment: "")
        case .like:
            image = self.image(ForName: "iconNoLike")
            title = NSLocalizedString("没有收到赞哦~", comment: "")
        case .custom:
            let config = delegate?.emptyData(self)
            image = config?.image
            title = config?.title ?? ""
            break
  
        }
        blankImage.image = image
        tipLabel.text = title
    }
    
    fileprivate func image(ForName name: String) -> UIImage? {
        if let path = Bundle(for: EmptyDataView.classForCoder()).path(forResource: "EmptyDataView", ofType: "bundle"),
            let bundle = Bundle(path: path),
            let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        {
            return image
        }
        return nil
    }
}
