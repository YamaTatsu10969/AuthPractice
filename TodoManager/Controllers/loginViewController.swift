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
import FBSDKLoginKit



class loginViewController: UIViewController, FUIAuthDelegate, FBSDKLoginButtonDelegate{
    
    // プロトコルに定義されているから、必ず記載。
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        } else {
            // アクセストークンを取ってくる
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            // 認証させる
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    return
                }
                // User is signed in
                // ...
                self.didLogin()
            }
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
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
        
        // facebook
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.center = CGPoint(x:150, y:200)
        self.view.addSubview(loginButton)
        
        // twitter
        let AuthButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                guard let twSession = session else{
                    return
                }
                
                let authToken = twSession.authToken
                let authTokenSecret = twSession.authTokenSecret
                let credential = TwitterAuthProvider.credential(withToken: authToken, secret: authTokenSecret)
                
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error { return }
                    //Sign In Completed
                    self.didLogin()
                }
                
            } else {
                print("👿error: \(String(describing: error?.localizedDescription))");
            }
        })
        //AuthButton.addTarget(self,action: #selector(self.AuthButtonTapped(sender:)),for: .touchUpInside)
        AuthButton.center = self.view.center
        self.view.addSubview(AuthButton)
        // Do any additional setup after loading the view.
    
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
    }
    
    func didLogin(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // storyboardファイル名称が  "Main"
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "taskListNavigationController")
        // 上記指定したstoryboardの中のVCを指定（storyboardIDでwithIdentifierを指定）
        self.present(viewcontroller, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func AuthButtonTapped(sender : AnyObject) {
        // FirebaseUIのViewの取得
        let authViewController = self.authUI.authViewController()
        // FirebaseUIのViewの表示
        self.present(authViewController, animated: true, completion: nil)
    }
}

//extension loginViewController: FUIAuthDelegate {
//
////    //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
////    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
////        // 認証に成功した場合
////        if error == nil {
////            self.performSegue(withIdentifier: "taskListNavigationController", sender: self)
////            print("🌞success")
////        }else {
////            print("👿fail")
////        }
////        // エラー時の処理をここに書く
////    }
//
//    func checkLoggedIn() {
//        setupLogin()
//        Auth.auth().addStateDidChangeListener{auth, user in
//            if user != nil{
//                print("🌞success")
//            } else {
//                print("👿fail")
//            }
//        }
//    }
//
//    func setupLogin() {
//
//        authUI.delegate = self
//        authUI.providers = providers
//
//    }
//
//    func login() {
//
//        let authViewController = authUI.authViewController()
//        self.present(authViewController, animated: true, completion: nil)
//    }
//
//
//
//}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


