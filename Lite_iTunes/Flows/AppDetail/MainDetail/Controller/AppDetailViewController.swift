//
//  AppDetailViewController.swift
//  Lite_iTunes
//
//  Created by Eduard on 27.08.2021.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    public var app: ITunesApp
    
    private let sizeReleaseNotes: CGSize
    
    lazy var headerViewController = AppDetailHeaderViewController(app: app)
    lazy var whatNewViewController = AppDetailWhatsNewViewController(app: app)
    lazy var screenshotViewController = AppDetailScreenshotViewController(app: app)
    
    let scrollView = UIScrollView()
    let contentViewOfScrollView = UIView()
    
    init(app: ITunesApp, sizeReleaseNotes: CGSize) {
        self.app = app
        self.sizeReleaseNotes = sizeReleaseNotes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        addScrollView()
        addHeaderViewController()
        addScreenshotViewController()
        addWhatNewViewController()
    }
    
    private func addScrollView(){
        contentViewOfScrollView.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentViewOfScrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentViewOfScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentViewOfScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentViewOfScrollView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentViewOfScrollView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentViewOfScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentViewOfScrollView.heightAnchor.constraint(equalToConstant:890+sizeReleaseNotes.height),
            contentViewOfScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
    }
    
    private func addHeaderViewController() {
       
        contentViewOfScrollView.addSubview(headerViewController.view)
        self.addChild(headerViewController)
        headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: contentViewOfScrollView.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: contentViewOfScrollView.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: contentViewOfScrollView.rightAnchor)
        ])
    }
    
    private func addScreenshotViewController() {
        self.addChild(screenshotViewController)
        contentViewOfScrollView.addSubview(screenshotViewController.view)
        screenshotViewController.didMove(toParent: self)
        
        screenshotViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            screenshotViewController.view.topAnchor.constraint(equalTo: headerViewController.view.bottomAnchor),
            screenshotViewController.view.leftAnchor.constraint(equalTo: contentViewOfScrollView.leftAnchor),
            screenshotViewController.view.rightAnchor.constraint(equalTo: self.contentViewOfScrollView.rightAnchor),
            screenshotViewController.view.widthAnchor.constraint(equalToConstant: 414),
            screenshotViewController.view.heightAnchor.constraint(equalToConstant: 560)
        ])
    }
    
    private func addWhatNewViewController() {
        self.addChild(whatNewViewController)
        contentViewOfScrollView.addSubview(whatNewViewController.view)
        whatNewViewController.didMove(toParent: self)
        
        whatNewViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whatNewViewController.view.topAnchor.constraint(equalTo: screenshotViewController.view.bottomAnchor),
            whatNewViewController.view.leftAnchor.constraint(equalTo: contentViewOfScrollView.leftAnchor),
            whatNewViewController.view.rightAnchor.constraint(equalTo: self.contentViewOfScrollView.rightAnchor)
        ])
    }
}


