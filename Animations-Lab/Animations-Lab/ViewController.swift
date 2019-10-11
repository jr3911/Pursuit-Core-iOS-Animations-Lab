//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    let pickerOptions: [UIView.AnimationOptions] = [.autoreverse, .repeat, .curveEaseIn, .curveEaseOut, .curveLinear]
    
    var chosenAnimationStyle: UIView.AnimationOptions!
    
    lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .magenta
        return label
    }()
    
    lazy var speedStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2
        stepper.stepValue = 1
        stepper.minimumValue = 0.0
        stepper.maximumValue = 4
        stepper.addTarget(self, action: #selector(speedStepperButtonPressed), for: .valueChanged)
        return stepper
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .magenta
        return label
    }()
    
    lazy var distanceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 50
        stepper.stepValue = 25
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.addTarget(self, action: #selector(distanceStepperButtonPressed), for: .valueChanged)
        return stepper
    }()
    
    lazy var sideButtonStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        return buttonStack
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move square left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateLeft), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move square right", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateRight), for: .touchUpInside)
        return button
    }()
    
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        return buttonStack
    }()
    
    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.dataSource = self
        pv.delegate = self
        return pv
    }()
    
    
    //MARK: Layout Constraints
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        chosenAnimationStyle = .autoreverse
        addSubviews()
        configureConstraints()
    }
    
    
    //MARK: IBActions
    @IBAction func animateSquareUp(sender: UIButton) {
        blueSquareCenterYConstraint.constant -= CGFloat(self.distanceStepper.value)
        UIView.animate(withDuration: self.speedStepper.value, delay: 0, options: chosenAnimationStyle, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        blueSquareCenterYConstraint.constant += CGFloat(self.distanceStepper.value)
        UIView.animate(withDuration: self.speedStepper.value, delay: 0, options: chosenAnimationStyle, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK: Objective C Functions
    @objc func speedStepperButtonPressed() {
        speedLabel.text = "Seconds: \(speedStepper.value.description)"
    }
    
    @objc func distanceStepperButtonPressed() {
        distanceLabel.text = "Distance: \(distanceStepper.value.description)"
    }
    
    @objc func animateRight() {
        blueSquareCenterXConstraint.constant += CGFloat(self.distanceStepper.value)
        UIView.animate(withDuration: self.speedStepper.value, delay: 0, options: chosenAnimationStyle, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func animateLeft() {
        blueSquareCenterXConstraint.constant -= CGFloat(self.distanceStepper.value)
        UIView.animate(withDuration: self.speedStepper.value, delay: 0, options: chosenAnimationStyle, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    //MARK: Collection - Functions
    private func addSubviews() {
        view.addSubview(speedLabel)
        view.addSubview(speedStepper)
        view.addSubview(blueSquare)
        view.addSubview(distanceLabel)
        view.addSubview(distanceStepper)
        view.addSubview(pickerView)
        addStackViewSubviews()
        addSideStackViewSubviews()
        view.addSubview(buttonStackView)
        view.addSubview(sideButtonStackView)
    }
    
    private func addSideStackViewSubviews() {
        sideButtonStackView.addSubview(leftButton)
        sideButtonStackView.addSubview(rightButton)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
    }
    
    private func configureConstraints() {
        constrainSpeedLabel()
        constrainSpeedStepper()
        constrainDistanceLabel()
        constrainDistanceStepper()
        constrainPickerView()
        constrainLeftButton()
        constrainRightButton()
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
        constrainButtonStackView()
        constrainSideButtonStackView()
    }
    
    //MARK: Individual - Functions
    private func constrainSpeedLabel() {
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedLabel.heightAnchor.constraint(equalToConstant: 30),
            speedLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            speedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            speedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
    }
    
    private func constrainSpeedStepper() {
        speedStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedStepper.centerXAnchor.constraint(equalTo: speedLabel.centerXAnchor),
            speedStepper.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            speedStepper.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
            speedStepper.heightAnchor.constraint(equalToConstant: 50)
        ])
        speedLabel.text = "Seconds: \(speedStepper.value.description)"
    }
    
    private func constrainDistanceLabel() {
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            distanceLabel.heightAnchor.constraint(equalToConstant: 30),
            distanceLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            distanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            distanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    private func constrainDistanceStepper() {
        distanceStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            distanceStepper.centerXAnchor.constraint(equalTo: distanceLabel.centerXAnchor),
            distanceStepper.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
            distanceStepper.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
            distanceStepper.heightAnchor.constraint(equalToConstant: 50)
        ])
        distanceLabel.text = "Distance: \(distanceStepper.value.description)"
    }
    
    private func constrainLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func constrainRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.heightAnchor.constraint(equalToConstant: 50),
            rightButton.trailingAnchor.constraint(equalTo: sideButtonStackView.trailingAnchor)
        ])
        
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upButton.heightAnchor.constraint(equalToConstant: 50),
            upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor)
        ])
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func constrainSideButtonStackView() {
        sideButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sideButtonStackView.centerYAnchor.constraint(equalTo: speedStepper.bottomAnchor, constant: 20),
            sideButtonStackView.heightAnchor.constraint(equalToConstant: 50),
            sideButtonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func constrainPickerView() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            pickerView.heightAnchor.constraint(equalToConstant: 200),
            pickerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
        ])
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Auto-Reverse"
        case 1:
            return "Repeat"
        case 2:
            return "Ease-In Curve"
        case 3:
            return "Ease-Out Curve"
        case 4:
            return "Linear Curve"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenAnimationStyle = pickerOptions[row]
    }
    
}
