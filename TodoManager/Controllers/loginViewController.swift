//
//  loginViewController.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/2/10.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase
import TwitterKit


class loginViewController: UIViewController, FUIAuthDelegate  {
    
    
//    @IBOutlet weak var logInButton: UIButton!
//    @IBOutlet weak var AuthButton: UIButton!
    
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    // 認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUITwitterAuth()
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.authUI.delegate = self
        self.authUI.providers = providers
        
        let AuthButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)");
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                // storyboardファイル名称が  "Main"
                
                let viewcontroller = storyboard.instantiateViewController(withIdentifier: "taskListNavigationController")
                // 上記指定したstoryboardの中のVCを指定（storyboardIDでwithIdentifierを指定）
                self.present(viewcontroller, animated: true, completion: nil)
            } else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        })
       AuthButton.addTarget(self,action: #selector(self.AuthButtonTapped(sender:)),for: .touchUpInside)
        AuthButton.center = self.view.center
        self.view.addSubview(AuthButton)
        // Do any additional setup after loading the view.
        checkLoggedIn()
    }
    
    
    
    
    @IBAction func didTouchedTwitterAuthButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // storyboardファイル名称が  "Main"
        
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "taskListNavigationController")
        // 上記指定したstoryboardの中のVCを指定（storyboardIDでwithIdentifierを指定）
        self.present(viewcontroller, animated: true, completion: nil)
       
       }
    
            
        @objc func AuthButtonTapped(sender : AnyObject) {
            // FirebaseUIのViewの取得
            let authViewController = self.authUI.authViewController()
            // FirebaseUIのViewの表示
            self.present(authViewController, animated: true, completion: nil)
        }
    
        //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
        public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
            // 認証に成功した場合
            if error == nil {
                self.performSegue(withIdentifier: "taskListNavigationController", sender: self)
            }
            // エラー時の処理をここに書く
        }
    
    func checkLoggedIn() {
        
        Auth.auth().addStateDidChangeListener{auth, user in
            if user != nil{
                print("success")
            } else {
                print("fail")
            }
        }
    }
    
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


