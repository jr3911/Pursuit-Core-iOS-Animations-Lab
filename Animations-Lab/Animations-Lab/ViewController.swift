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
    lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var speedStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2
        stepper.stepValue = 1
        stepper.minimumValue = 0.0
        stepper.maximumValue = 4
        stepper.addTarget(self, action: #selector(stepperButtonPressed), for: .valueChanged)
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
        addSubviews()
        configureConstraints()
    }
    
    
    //MARK: IBActions
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - 150
        UIView.animate(withDuration: self.speedStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffet + 150
        UIView.animate(withDuration: self.speedStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Objective C Functions
    @objc func stepperButtonPressed() {
        speedLabel.text = speedStepper.value.description
    }
    
    @objc func animateRight() {
        let originalConstant = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = originalConstant + 50
        UIView.animate(withDuration: self.speedStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateLeft() {
        let originalConstant = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = originalConstant - 50
        UIView.animate(withDuration: self.speedStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: Collection - Functions
    private func addSubviews() {
        view.addSubview(speedLabel)
        view.addSubview(speedStepper)
        view.addSubview(blueSquare)
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
        speedLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        speedLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        speedLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        speedLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func constrainSpeedStepper() {
        speedStepper.translatesAutoresizingMaskIntoConstraints = false
        speedStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        speedStepper.centerYAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 40).isActive = true
        speedStepper.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25).isActive = true
        speedStepper.heightAnchor.constraint(equalToConstant: 50).isActive = true
        speedLabel.text = speedStepper.value.description
    }
    
    private func constrainLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func constrainRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: sideButtonStackView.trailingAnchor).isActive = true
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
}


