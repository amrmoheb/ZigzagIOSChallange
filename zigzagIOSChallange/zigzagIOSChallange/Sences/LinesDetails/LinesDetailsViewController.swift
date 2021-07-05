//
//  LinesDetailsViewController.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import UIKit

class LinesDetailsViewController: UIViewController {
    var presenter : LinesDetailsPresenterInput!
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardViewController:RedVIewController!//CardViewController!

    @IBOutlet weak var LinesListTableView: UITableView!
    
    @IBOutlet weak var CardHightConstrians: NSLayoutConstraint!
    
    var cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 65
    
    var cardVisible = true
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    @IBOutlet weak var CardView: UIView!
    
    @IBOutlet weak var handleArea: UIView!
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  MainPresenter = LinesDetailsPresenter()
        let MainInteractor = LinesDetailsInteractor()
        MainPresenter.view = self
        MainPresenter.interactor = MainInteractor
        MainInteractor.presenter = MainPresenter
        presenter = MainPresenter
        presenter?.handle()
        // Do any additional setup after loading the view.
        setupCard()

    }
    func setupCard() {
       
        cardHeight = (self.view.frame.height/3)*2
       // cardViewController =  CardView// CardViewController(nibName:"CardViewController", bundle:nil)
       // self.addChild(CardView)
        self.view.addSubview(CardView)
      //  cardViewController.LinesListTableView.dataSource = self
     //   cardViewController.LinesListTableView.delegate = self
        CardHightConstrians.constant = cardHeight
        CardView.frame = CGRect(x: 0, y: self.view.frame.height - cardHeight, width: self.view.bounds.width, height: cardHeight)
       // self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
        CardView.clipsToBounds = true
        self.CardView.frame.origin.y = self.view.frame.height - self.cardHeight

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LinesDetailsViewController.handleCardTap(recognzier:)))
       let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LinesDetailsViewController.handleCardPan(recognizer:)))
        
    handleArea.addGestureRecognizer(tapGestureRecognizer)
     handleArea.addGestureRecognizer(panGestureRecognizer)
        
     //   CardContaentSetup()
        
        
    }
    func CardContaentSetup()  {
     /*   let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        imageView.image = UIImage(named: "buttonFollowCheckGreen")

        //Text Label
        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.yellow
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textLabel.text  = "Hi World"
        textLabel.textAlignment = .center
        */
        // nib
        for i in 0...2 {
               CreateStackCell()
        }

 
        
    }
    func CreateStackCell()
    {
        
       let transType = TransportationCategoryViewController(nibName:"TransportationCategoryView", bundle:nil)

       // self.cardViewController.TransportationCategoryStack.addChild(transportationView)
     //   self.addChild(transType)
       self.view.addSubview(transType.view)
        transType.Logo.image = UIImage(named: "buttonFollowCheckGreen")
        transType.Name.text = "bus"
       self.cardViewController.TransportationCategoryStack.addArrangedSubview(transType.view)
      

    }
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.CardView.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.CardView.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.CardView.layer.cornerRadius = 12
                case .collapsed:
                    self.CardView.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
        
            
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

}
extension LinesDetailsViewController : LinesDetailsPresenterOutput{
    
    func display(reloadLinesList : Display) {
        LinesListTableView.reloadData()
        print("finally Display from presenter in the view")
    }
}
extension LinesDetailsViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.GetLineCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "LineCell") as! LineTableViewCell
        cell.SetLineName(name: presenter.GetLineNameByIndex(index: indexPath.row))
        return cell
    }
}
