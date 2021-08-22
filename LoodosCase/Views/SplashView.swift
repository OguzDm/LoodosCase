//
//  SplashViewController.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 21.08.2021.
//

import UIKit
import Firebase

final class SplashView: UIViewController {

    private let alertController = UIAlertController(title: "Error"
                                            , message: "You don't have any network connection please check your network connection before go on"
                                            , preferredStyle: .alert)
    private let remoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 50)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        fetchValue()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkConnection()
    }
    
    private func configureLabel(){
        view.addSubview(remoteLabel)
        remoteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            remoteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            remoteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchValue(){
        let defaults: [String: NSObject] = [
            "Loodos": "" as NSObject
        ]
        remoteConfig.setDefaults(defaults)
        self.remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { updated, error in
                    DispatchQueue.main.async {
                        self.remoteLabel.text = self.remoteConfig.configValue(forKey: "Loodos").stringValue ?? ""
                    }
                }
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    private func checkConnection() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if Connectivity.isConnectedToInternet {
                let mainNav = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "mainNav")
                mainNav.modalPresentationStyle = .fullScreen
                self.present(mainNav, animated: true, completion: nil)
             } else {
                self.alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    self.checkConnection()
                }))
                DispatchQueue.main.async {
                    self.present(self.alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
