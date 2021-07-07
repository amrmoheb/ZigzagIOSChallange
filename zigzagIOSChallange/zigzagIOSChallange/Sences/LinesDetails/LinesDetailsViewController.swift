//
//  LinesDetailsViewController.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import UIKit
import MapKit
class LinesDetailsViewController: UIViewController {
    var presenter : LinesDetailsPresenterInput!
    enum CardState {
        case expanded
        case collapsed
    }
    var LineColor = #colorLiteral(red: 0.09019607843, green: 0.6392156863, blue: 0.2705882353, alpha: 1)
    var polyline = MKPolyline()
    var station = Station()
   // var cardViewController:RedVIewController!
    var UndeLineView : UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var LinesListTableView: UITableView!
    
    @IBOutlet weak var CardHightConstrians: NSLayoutConstraint!
    
    @IBOutlet weak var FiltersStack: UIStackView!
    @IBOutlet weak var SBahanStack: UIStackView!
    
    @IBOutlet weak var SBahanLable: UILabel!
    
    @IBOutlet weak var RbahanStack: UIStackView!
    
    @IBOutlet weak var RBahanLable: UILabel!
    @IBOutlet weak var UbahanStack: UIStackView!
    
    @IBOutlet weak var UBahanLable: UILabel!
    @IBOutlet weak var BusStack: UIStackView!
    @IBOutlet weak var BusLable: UILabel!
    @IBOutlet weak var StationImage: UIImageView!
    @IBOutlet weak var StationName: UILabel!
    
    var MapCenter = CLLocationCoordinate2D()
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
    
        // Do any additional setup after loading the view.
        setupCard()
       
        SetUpMap()
        
    }
    func SetUpMap()  {
        mapView.delegate = self
        
       
        ReCenterMap(center: MapCenter)
      
    }
    func ReCenterMap(center : CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 10000

        let coordinateRegion = MKCoordinateRegion(center: center,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
    }
    func DrawLines(){
        mapView.removeOverlays(mapView.overlays)
        var LinesCount = presenter.GetDrawableLinesCount()
        for i in 0...LinesCount-1 {
            var drowableLineCoordinates = presenter.GetDrawableLineCoordsByIndex(index: i)
             polyline = MKPolyline(coordinates: drowableLineCoordinates, count: drowableLineCoordinates.count)
            mapView.addOverlay(polyline)
        }
        ReCenterMap(center: MapCenter)
    }
    func setupCard() {
       
        cardHeight =  (self.view.frame.height/3)*2
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
       // BusStack.isHidden = true
        let BusGesture = UITapGestureRecognizer(target: self, action:  #selector(self.BusSelected))
        self.BusStack.addGestureRecognizer(BusGesture)
        let UBahanGesture = UITapGestureRecognizer(target: self, action:  #selector(self.UBahanSelected))
        self.UbahanStack.addGestureRecognizer(UBahanGesture)
        let RBahanGesture = UITapGestureRecognizer(target: self, action:  #selector(self.RBahanSelected))
        self.RbahanStack.addGestureRecognizer(RBahanGesture)
        let SBahanGesture = UITapGestureRecognizer(target: self, action:  #selector(self.SBahanSelected))
        self.SBahanStack.addGestureRecognizer(SBahanGesture)
        FiltersStack.isHidden = true
        StationImage.image = UIImage(named: station.ImageName)
        StationName.text = station.StationName
        MapCenter.longitude = station.Stationlongitude
        MapCenter.latitude = station.Stationlatitude
        presenter.setStopRefPoint(value: station.StopPointRef)
        presenter?.handle()
        
    }
 
  @objc  func BusSelected()  {
    print("BusSelected")
    LineColor = UIColor.red
    presenter.FilterSelected(filterState: .Bus)
    }
    @objc  func UBahanSelected()  {
        print("UBahanSelected")
        LineColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.8862745098, alpha: 1)
        presenter.FilterSelected(filterState: .UBahan)


      }
    @objc  func RBahanSelected()  {
        print("RBahanSelected")
        LineColor = UIColor.gray
        presenter.FilterSelected(filterState: .RBahan)

      }
    @objc  func SBahanSelected()  {
        print("SBahanSelected")
        LineColor = #colorLiteral(red: 0.09019607843, green: 0.6392156863, blue: 0.2705882353, alpha: 1)
        presenter.FilterSelected(filterState: .SBahan)

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
    func display(draw : Draw) {
        DrawLines()
    }
    
    func display(Filters: Display.Filters) {
        var filtersCount = 4
        if Filters.bus == false {
            BusStack.isHidden = true
            filtersCount -= 1
        }
        if Filters.ubahan == false {
            UbahanStack.isHidden = true
            filtersCount -= 1

        }
        if Filters.rbahan == false {
            RbahanStack.isHidden = true
            filtersCount -= 1

        }
        if Filters.sbahan == false {
            SBahanStack.isHidden = true
            filtersCount -= 1

        }
        if Filters.bus && Filters.rbahan && Filters.ubahan && Filters.sbahan {
            BusLable.isHidden = true
            UBahanLable.isHidden = true
            RBahanLable.isHidden = true
            SBahanLable.isHidden = true
        }
        if filtersCount > 1 {
            FiltersStack.isHidden = false
        }
    }
    
    
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
        cell.ArrivalTimeLable.text = presenter.GetArriveTimeByIndex(index: indexPath.row)
        print(presenter.GetArriveTimeByIndex(index: indexPath.row))
        cell.EstimatedTmeLable.text = presenter.GetEstimatedTimeByIndex(index: indexPath.row)
        cell.PublishedLineName.text = presenter.GetPublishedLineNmaeByIndex(index: indexPath.row)
        cell.GateName.text = presenter.GetGateByIndex(index: indexPath.row)
        cell.PublishedLineVIew.backgroundColor = LineColor
        return cell
    }
}
extension LinesDetailsViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = LineColor
            renderer.lineWidth = 7
            return renderer
        }

        return MKOverlayRenderer()
    }
}
