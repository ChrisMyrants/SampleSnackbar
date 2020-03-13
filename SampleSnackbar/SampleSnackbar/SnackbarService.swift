import Snackbar

final class SnackbarService: SnackbarManagerDelegate {
    var snackbarManager: SnackbarManager
    
    init(snackbarManager: SnackbarManager) {
        self.snackbarManager = snackbarManager
        snackbarManager.delegate = self
    }
    
    func show(snackbarModel: SnackbarModel, animated: Bool) {
        let view = SnackbarView(
            model: snackbarModel,
            delegate: snackbarManager,
            animationTime: 1)
        
        snackbarManager.show(SnackbarView: view, animated: animated)
    }
    
    func actionTriggered(event: SnackbarEvent) {
        print("Received event: \(event)")
    }
}
