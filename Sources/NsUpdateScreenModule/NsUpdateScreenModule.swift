import UIKit
import SwiftUI

public func getVersionLocal()->String{
    let infoDictionary = Bundle.main.infoDictionary
    let currentVersion = infoDictionary!["CFBundleShortVersionString"] as? String ?? "0.0.0"
    return currentVersion
}

public func getVersionNube(urlIos:String)->String{
    let url = URL(string: urlIos)
    guard let data = try? Data(contentsOf: url!) else {
        return "";
    }
    let lookup = (try? JSONSerialization.jsonObject(with: data , options: [])) as? [String: Any]
    if let resultCount = lookup!["resultCount"] as? Int, resultCount == 1{
        if let results = lookup!["results"] as? [[String:Any]]{
            if let appStoreVersion = results[0]["version"] as? String{
                return appStoreVersion
            }
        }
    }
    return ""
}

extension UIImageView {

    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}

extension Bundle {
    // Name of the app - title under the icon.
    var displayName: String? {
            return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
                object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}

@IBDesignable
open class NsUpdateScreenModule:UIView{
    var  stack:UIStackView=UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    
    public convenience init(msj:String) {
        self.init(frame: CGRect.zero)
        //assign custom vars
    }
    
    public override init(frame:CGRect){
        super.init(frame: frame)
        crearView()
    }
    
    public required init?(coder:NSCoder){
        super.init(coder: coder)
        crearView()
    }
    
    open func crearView(){
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.center=self.center
        
        //IMagen
        let image:UIImageView=UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.image=Bundle.main.icon
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.center.x=self.center.x
        
        
        let titulo:UILabel=UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 24))
        titulo.text=Bundle.main.displayName
        titulo.font=UIFont.boldSystemFont(ofSize: 24)
        titulo.textAlignment = .center
        titulo.textColor = .black
        
        let msjL:UILabel=UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        msjL.text="MSJs"
        msjL.font=UIFont.boldSystemFont(ofSize: 20)
        msjL.textAlignment = .center
        msjL.textColor = .black
        msjL.adjustsFontSizeToFitWidth=true
        msjL.numberOfLines=3

        let btn:UIButton=UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*90/100, height: 25))
        btn.setTitle("Actualizar", for: .normal)
        btn.center.x=self.center.x
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
//        btn.backgroundColor = UIColor.systemBlue
        btn.addTarget(self, action: #selector(NsUpdateScreenModule.actualizarFn(_:)), for: .touchUpInside)
        
        let spacer:UIView=UIView()
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(titulo)
        stack.addArrangedSubview(msjL)
        stack.addArrangedSubview(btn)
        addSubview(stack)
        self.backgroundColor = .white
    }
    
    @IBAction func actualizarFn(_ sender: UIButton){
        let url:String="https://www.hackingwithswift.com"
//        let ulr:String="itms-apps://apple.com/app/id839686104"
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
    
}
