import UIKit
import Snackbar

class SnackbarView: UIView, SnackbarViewType {
    var message: UILabel!
    var actionButton: UIButton!
    var containerView: UIView!
    
    var model: SnackbarModel
    
    var delegate: SnackbarViewDelegate?
    
    var animationTime: Double
    
    init(model: SnackbarModel, delegate: SnackbarViewDelegate? = nil, animationTime: Double = 1.0) {
        self.model = model
        self.delegate = delegate
        self.animationTime = animationTime
        
        super.init(frame: CGRect(
            x: 0,
            y: UIScreen.main.bounds.height - 120,
            width: UIScreen.main.bounds.width,
            height: 120))
        
        self.containerView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: 120))
        self.containerView.backgroundColor = .systemGray
        
        self.message = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width / 2, height: 30))
        self.message.text = model.message
        
        if let actionTitle = model.action.title {
            self.actionButton = UIButton(frame: CGRect(
                x: UIScreen.main.bounds.width / 2,
                y: 0,
                width: UIScreen.main.bounds.width / 2,
                height: 30))
            self.actionButton.setTitle(actionTitle, for: .normal)
            self.actionButton.setTitleColor(.green, for: .normal)
        }
        
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.message)
        self.containerView.addSubview(self.actionButton)
        self.actionButton.addTarget(self, action: #selector(getter: UICommandAlternate.action), for: .touchDown)
        
        self.containerView.frame.origin.y = 120
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SnackbarView {
    func present(animated: Bool, onComplete: (() -> ())?) {
        UIView.animate(withDuration: animationTime) {
            self.containerView.frame.origin.y = 0
        }
    }
    
    func dismiss(animated: Bool, onComplete: (() -> ())?) {
        UIView.animate(withDuration: animationTime) {
            self.containerView.frame.origin.y = 120
        }
    }
    
    @objc func action() {
        delegate?.actionTriggered(event: model.action.event)
    }
}
