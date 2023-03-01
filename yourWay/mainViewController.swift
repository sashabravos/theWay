//
//  ViewController.swift
//  yourWay
//
//  Created by Александра Кострова on 27.02.2023.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView.init(image: UIImage(named: "backgroundImage") ?? UIImage())
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = Constants.mainStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.text = storyLogic.story[storyNum].title
        questionLabel.numberOfLines = 0
        questionLabel.textColor = .white
        questionLabel.font = .systemFont(ofSize: Constants.labelFontSize)
        questionLabel.textAlignment = .center
        questionLabel.highlightedTextColor = .systemGray
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        return questionLabel
    }()
    private lazy var upButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        button.setTitle(storyLogic.story[storyNum].choice1, for: .normal)
        button.titleLabel!.numberOfLines = 0
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize, weight: .semibold)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.masksToBounds = true
        button.layer.borderWidth = Constants.buttonBorderWidth
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(choiceMade(choice:)), for: .touchUpInside)
        return button
    }()
    private lazy var downButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        button.setTitle(storyLogic.story[storyNum].choice2, for: .normal)
        button.titleLabel!.numberOfLines = 0
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize, weight: .semibold)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.masksToBounds = true
        button.layer.borderWidth = Constants.buttonBorderWidth
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(choiceMade(choice:)), for: .touchUpInside)
        return button
    }()
    var storyLogic = StoryLogic()
    var storyNum = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(stackView)
        addToStackView()
        layoutConstraint()
    }

    private func addToStackView() {
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(upButton)
        stackView.addArrangedSubview(downButton)
    }
    private func layoutConstraint() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            upButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            downButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)

        ])
    }
    func updateUI() {
        questionLabel.text = storyLogic.getStoryTitle()
        upButton.setTitle(storyLogic.getChoice1(), for: .normal)
        downButton.setTitle(storyLogic.getChoice2(), for: .normal)
    }
    @objc func choiceMade(choice: UIButton) {
        storyLogic.nextStory(userChoice: choice.currentTitle!)
        updateUI()
    }
    private enum Constants {
        static let mainStackViewSpacing: CGFloat = 10.0
        static let labelFontSize: CGFloat = 30.0
        static let buttonHeight: CGFloat = 80.0
        static let buttonFontSize: CGFloat = 25.0
        static let buttonCornerRadius: CGFloat = 15.0
        static let buttonBorderWidth: CGFloat = 2.0
    }
}
