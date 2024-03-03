//
//  OnboardingVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import SnapKit
import AdvancedPageControl
import Localize_Swift

class OnboardingViewController: UIViewController {
    
    let languageSlide = [
        ["Movies, TV series, sitcoms, animated projects, TV programs and reality shows, anime and more",  "Фильмы, сериалы, ситкомы, анимационные проекты, телепередачи и реалити-шоу, аниме и многое другое»", "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити - шоулар, аниме және тағы басқалары"],
        ["Watch on any device, Watch your favorite movie on your phone, tablet, laptop without extra charge", "«Смотрите на любом устройстве, смотрите любимый фильм на телефоне, планшете, ноутбуке без доплаты»", "Кез келген құрылғыдан қара, Сүйікті фильміңді қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"],
        ["Registration is easy. Register now and get your desired movie", "«Регистрация проста. Зарегистрируйтесь сейчас и получите желаемый фильм", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.contentInsetAdjustmentBehavior = .never
        
        return cv
    }()
    
    lazy var pageControl: AdvancedPageControlView = {
        let pc = AdvancedPageControlView()
        
        pc.drawer = ExtendedDotDrawer(
            numberOfPages: languageSlide.count,
            height: 6,
            width: 6,
            space: 4,
            raduis: 3,
            indicatorColor: UIColor(named: "9753FO"),
            dotsColor: UIColor.lightGray,
            borderWidth: 0
        )
        
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func localizedString(for key: Int) -> String {
        if Localize.currentLanguage() == "en" {
            return languageSlide[key][0]
        }
        if Localize.currentLanguage() == "ru" {
            return languageSlide[key][1]
        }
            return languageSlide[key][2]

    }
    //MARK: - SetupUI
    func SetupUI() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 152))
            make.height.equalTo(26)
            make.width.equalTo(116)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let widht = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / widht)
        pageControl.setPage(currentPage)
        
    }
    
    @objc func openSignIn() {
        let signIn = SignInViewController()
        navigationController?.show(signIn, sender: self)
        navigationItem.title = ""
    }
    
    
    
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languageSlide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setData()
        cell.descriptionLabel.text = localizedString(for: indexPath.row)
        cell.posterImage.image = UIImage(named: "Onboarding\(indexPath.row + 1)")
        cell.scipButton.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
        cell.nextButton.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
        if indexPath.row != languageSlide.count - 1 {
            cell.nextButton.isHidden = true
        } else {
            cell.scipButton.isHidden = true
        }
        return cell
    }
}
