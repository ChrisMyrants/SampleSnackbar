import UIKit
import Snackbar

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var snackbarService: SnackbarService?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        snackbarService = SnackbarService(snackbarManager: SnackbarManager(rootView: window!))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.snackbarService?.show(
                snackbarModel: SnackbarModel(
                    message: "Sample 🍫",
                    action: SnackbarAction(
                        title: "Dismiss",
                        event: .dismiss),
                    timeout: 5),
                animated: true)
        }
    }
    
}

extension UIWindow: RootView {
    public func add(_ viewAddable: RootViewAddable) {
        guard let view = viewAddable as? UIView else { return }
        addSubview(view)
    }
}

