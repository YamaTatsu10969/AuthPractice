//
//  loginViewController.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/2/10.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit
import TwitterKit

class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTouchedTwitterLoginButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // storyboardファイル名称が  "Main"
        
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "taskListNavigationController")
        // 上記指定したstoryboardの中のVCを指定（storyboardIDでwithIdentifierを指定）
        self.present(viewcontroller, animated: true, completion: nil)
        // など実現したい遷移方法に合わせて様々
        //※初期状態にリセットしたい場合（ログアウトなど）はAppDelegateのrootViewControllerへ
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = viewcontroller
//        Login状態を判別して、アプリ起動時に表示するViewContollerを変更
//        if Auth.auth().currentUser != nil {
//            // storyboard指定
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            // viewcontrollerを指定
//            let viewcontroller = storyboard.instantiateViewController(withIdentifier: "Tasknavigationcontroller")
//            // rootviewvontoroller でファルトでは、initial のgeneralに設定されている箇所
//            self.window?.rootViewController = viewcontroller
//        }
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
