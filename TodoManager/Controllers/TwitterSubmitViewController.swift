//
//  TwitterSubmitViewController.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/2/21.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterSubmitViewController: UIViewController {
    
    
    @IBOutlet weak var tweetText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTouchedTweetButton(_ sender: Any) {
        tweetSubmit()
    }
    func tweetSubmit(){
        guard let text:String = tweetText.text else {
            showAlert("文字の入力してください。")
            return
        }
        let composer = TWTRComposer()
        composer.setText(text)
        composer.show(from: self, completion: { result in
            if (result == .done) {
                print("OK")
            } else {
                print("NG")
            }
        })
    }
    
    func showAlert(_ text: String){
        //UIViewControllerを作成しているだけ！
        let alertController = UIAlertController(title: text, message: nil , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // ツイートを投稿
//    private func postTweet() {
//        let URL = NSURL(string: "https://api.twitter.com/1.1/statuses/update.json")
//
//        // ツイートしたい文章をセット
//        let params = ["status" : "Tweet from iOS!"]
//
//        // リクエストを生成
//        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
//                                requestMethod: .POST,
//                                url: URL as! URL,
//                                parameters: params)
//
//        // 取得したアカウントをセット
//        request?.account = ACAccount
//
//        // APIコールを実行
//        request?.performRequestWithHandler { (responseData, urlResponse, error) -> Void in
//
//            if error != nil {
//                println("error is \(error)")
//            }
//            else {
//                // 結果の表示
//                let result = NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments, error: nil) as NSDictionary
//                println("result is \(result)")
//            }
//        }
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
