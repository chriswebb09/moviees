//
//  SearchViewController.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        view.layoutSubviews()
    }
    
    @IBAction func search(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "movieVC") as! MovieViewController
        vc.title = searchView.searchField.text
        vc.navigationController?.navigationBar.topItem?.title = searchView.searchField.text
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        vc.loadView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MovieViewController
        destinationVC.title = searchView.searchField.text
        destinationVC.navigationController?.navigationBar.topItem?.title = searchView.searchField.text
        //        destinationVC.navigationController?.navigationBar.topItem?.title = searchView.searchField.text
        //        // Get the new view controller using [segue destinationViewController].
        //        // Pass the selected object to the new view controller.
        //    }
    }
    
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // let destViewController = segue.destinationViewController as! MovieViewController
    //
    //        if let buttonTitle = (sender as? UIButton)?.titleLabel?.text {
    //            destViewController.title = buttonTitle
    //        }
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let destinationVC = segue.destination as! MovieViewController
    //        destinationVC.navigationController?.navigationBar.topItem?.title = searchView.searchField.text
    //        // Get the new view controller using [segue destinationViewController].
    //        // Pass the selected object to the new view controller.
    //    }
}
