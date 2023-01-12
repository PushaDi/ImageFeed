//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by DMITRY KHLOPTSOV on 06.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let profileImageView = UIImageView()
    private let exitButton = UIButton()
    private let profileNameLabel = UILabel()
    private let profileNicknameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let profileService = ProfileService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImageView()
        setupExitButton()
        setupNameLabel()
        setupNicknameLabel()
        setupDescriptionLabel()
        configureView()
        setupConstraints()
        guard let profile = profileService.profile else { return }
        updateProfileDetails(profile: profile)
    }

    private func setupProfileImageView() {
        let profileImage = UIImage(named: "ProfileImage")
        profileImageView.image = profileImage

        profileImageView.layer.cornerRadius = 61
    }

    private func setupExitButton() {
        let exitButtonImage = UIImage(named: "ExitButton" )
        exitButton.setImage(exitButtonImage, for: .normal)
        exitButton.tintColor = .clear
    }

    private func setupNameLabel() {
        profileNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        profileNameLabel.textColor = .white
        profileNameLabel.text = "Екатерина Новикова"
    }

    private func setupNicknameLabel() {
        profileNicknameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        profileNicknameLabel.text = "@ekaterina_nov"
        profileNicknameLabel.textColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
    }

    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.text = "Hello, world!"
    }

    private func configureView() {
        let views = [
            profileImageView,
            exitButton,
            profileNameLabel,
            profileNicknameLabel,
            descriptionLabel
        ]

        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
    }

    private func setupProfileImageConstraints() {
        let profileImageWidthAnchor = profileImageView.widthAnchor.constraint(equalToConstant: 70)
        let profileImageHeightAnchor = profileImageView.heightAnchor.constraint(equalToConstant: 70)
        let profileImageLeadingAnchor = profileImageView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 16
        )
        let profileImageTopAnchor = profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 76)

        let profileImageViewConstraints = [
            profileImageWidthAnchor,
            profileImageHeightAnchor,
            profileImageTopAnchor,
            profileImageLeadingAnchor]
        NSLayoutConstraint.activate(profileImageViewConstraints)
    }

    private func setupExitButtonConstraints() {
        let exitButtonWidthAnchor = exitButton.widthAnchor.constraint(equalToConstant: 20)
        let exitButtonHeightAnchor = exitButton.heightAnchor.constraint(equalToConstant: 22)
        let exitButtonCenterYAnchor = exitButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        let exitButtonTralingAnchor = exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26)

        let exitButtonConstraints = [
            exitButtonWidthAnchor,
            exitButtonHeightAnchor,
            exitButtonCenterYAnchor,
            exitButtonTralingAnchor
        ]

        NSLayoutConstraint.activate(exitButtonConstraints)
    }

    private func setupProfileNameConstraints() {
        let profileNameLabelTopAnchor = profileNameLabel.topAnchor.constraint(
            equalTo: profileImageView.bottomAnchor, constant: 8
        )
        let profileNameLabelLeadingAnchor = profileNameLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 16
        )

        let profileNameLabelConstraints = [
            profileNameLabelTopAnchor,
            profileNameLabelLeadingAnchor
        ]

        NSLayoutConstraint.activate(profileNameLabelConstraints)
    }

    private func setupProfileNicknameConstraints() {
        let profileNicknameLabelTopAnchor = profileNicknameLabel.topAnchor.constraint(
            equalTo: profileNameLabel.bottomAnchor, constant: 8
        )
        let profielNicknameLabelLeadingAnchor = profileNicknameLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 16
        )

        let profileNicknameLabelConstraints = [
            profileNicknameLabelTopAnchor,
            profielNicknameLabelLeadingAnchor
        ]

        NSLayoutConstraint.activate(profileNicknameLabelConstraints)
    }

    private func setupDescriptionLabelConstraints() {
        let descriptionLabelTopAnchor = descriptionLabel.topAnchor.constraint(
            equalTo: profileNicknameLabel.bottomAnchor, constant: 8
        )
        let descriptionLabelLeadingAnchor = descriptionLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 16
        )

        let descriptionLabelConstraints = [
            descriptionLabelTopAnchor,
            descriptionLabelLeadingAnchor]

        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }

    private func setupConstraints() {
        setupProfileImageConstraints()
        setupExitButtonConstraints()
        setupProfileNameConstraints()
        setupProfileNicknameConstraints()
        setupDescriptionLabelConstraints()
    }
    
    private func updateProfileDetails(profile: Profile) {
        profileNameLabel.text = profile.name
        profileNicknameLabel.text = profile.username
        descriptionLabel.text = profile.bio
    }
}
