//
//  OnboardingVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import SnapKit
import AdvancedPageControl
import Localize_Swift

class OnboardingVC: UIViewController {
    
    var delegate: LanguageProtocol?
    
    let languageArray = [
        ["Movies, TV series, sitcoms, animated projects, TV programs and reality shows, anime and more", "Watch on any device, Watch your favorite movie on your phone, tablet, laptop without extra charge", "Registration is easy. Register now and get your desired movie", "en"],
        ["Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити - шоулар, аниме және тағы басқалары", "Кез келген құрылғыдан қара, Сүйікті фильміңді қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз", "kk"],
        ["Фильмы, сериалы, ситкомы, анимационные проекты, телепередачи и реалити-шоу, аниме и многое другое», «Смотрите на любом устройстве, смотрите любимый фильм на телефоне, планшете, ноутбуке без доплаты», «Регистрация проста. Зарегистрируйтесь сейчас и получите желаемый фильм", "ru"]]
    
    let slides = ["Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити - шоулар, аниме және тағы басқалары", "Кез келген құрылғыдан қара, Сүйікті фильміңді қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(OnboardingCell.self, forCellWithReuseIdentifier: "Cell")
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
            numberOfPages: slides.count,
            height: 6,
            width: 6,
            space: 4,
            raduis: 3,
            indicatorColor: UIColor(named: "LightPurple"),
            dotsColor: UIColor.lightGray,
            borderWidth: 0
        )
        
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        
    }
    
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
        let signIn = SignIn()
        navigationController?.show(signIn, sender: self)
        navigationItem.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - CollectionView

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OnboardingCell
        
        cell.setData()
        cell.descriptionLabel.text = languageArray[indexPath.row][0]
        cell.imageView.image = UIImage(named: "Onboarding\(indexPath.row + 1)")
        cell.descriptionLabel.text = slides[indexPath.row]
        cell.scipButton.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
        cell.nextButton.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
        if indexPath.row != slides.count - 1 {
            cell.nextButton.isHidden = true
        } else {
            cell.scipButton.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChange()
        dismiss(animated: true, completion: nil)
    }
}

