
import UIKit

class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomView()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomView()
    }
    
    func setCustomView() {
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 3, height: 0)
    }
}
