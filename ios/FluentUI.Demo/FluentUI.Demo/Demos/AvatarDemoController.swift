//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI
import UIKit

class AvatarDemoController: DemoController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let enablePointerInteractionSettingView = createLabelAndSwitchRow(labelText: "Enable iPad pointer interaction",
                                                                          switchAction: #selector(toggleEnablePointerInteraction(switchView:)),
                                                                          isOn: isPointerInteractionEnabled)
        addRow(items: [enablePointerInteractionSettingView])

        let backgroundSettingView = createLabelAndSwitchRow(labelText: "Use alternate background color",
                                                            switchAction: #selector(toggleAlternateBackground(switchView:)),
                                                            isOn: isUsingAlternateBackgroundColor)
        addRow(items: [backgroundSettingView])

        let transparencySettingView = createLabelAndSwitchRow(labelText: "Do not use transparency",
                                                              switchAction: #selector(toggleOpaqueBorders(switchView:)),
                                                              isOn: !isTransparent)
        addRow(items: [transparencySettingView])

        let showPresenceSettingView = createLabelAndSwitchRow(labelText: "Show presence",
                                                              switchAction: #selector(toggleShowPresence(switchView:)),
                                                              isOn: isShowingPresence)
        addRow(items: [showPresenceSettingView])

        let outOfOfficeSettingView = createLabelAndSwitchRow(labelText: "Out Of Office",
                                                             switchAction: #selector(toggleOutOfOffice(switchView:)),
                                                             isOn: isOutOfOffice)
        addRow(items: [outOfOfficeSettingView])

        let showRingsSettingView = createLabelAndSwitchRow(labelText: "Show rings",
                                                           switchAction: #selector(toggleShowRings(switchView:)),
                                                           isOn: isShowingRings)
        addRow(items: [showRingsSettingView])

        let enableRingInnerGapSettingView = createLabelAndSwitchRow(labelText: "Enable ring inner gap",
                                                                    switchAction: #selector(toggleShowRingInnerGap(switchView:)),
                                                                    isOn: isShowingRingInnerGap)
        addRow(items: [enableRingInnerGapSettingView])

        addTitle(text: "Default style")
        for size in MSFAvatarSize.allCases.reversed() {
            let name = "Kat Larrson"
            let imageAvatar = createAvatarView(size: size,
                                               name: name,
                                               image: UIImage(named: "avatar_kat_larsson")!,
                                               style: .default)
            avatarViews.append(imageAvatar)

            let initialsAvatar = createAvatarView(size: size,
                                                  name: name,
                                                  style: .default)
            avatarViews.append(initialsAvatar)

            addRow(text: size.description, items: [imageAvatar.view, initialsAvatar.view], textStyle: .footnote, textWidth: 100)
        }

        addTitle(text: "Fallback (default style and accent style)")
        for size in MSFAvatarSize.allCases.reversed() {
            let phoneNumber = "+1 (425) 123 4567"
            let defaultAvatar = createAvatarView(size: size,
                                                 name: phoneNumber,
                                                 style: .default)
            avatarViews.append(defaultAvatar)

            let accentAvatar = createAvatarView(size: size,
                                                name: phoneNumber,
                                                style: .accent)
            avatarViews.append(accentAvatar)

            addRow(text: size.description, items: [defaultAvatar.view, accentAvatar.view], textStyle: .footnote, textWidth: 100)
        }

        addTitle(text: "Fallback (outlined style and outlinedPrimary style)")
        for size in MSFAvatarSize.allCases.reversed() {
            let phoneNumber = "+1 (425) 123 4567"
            let outlinedAvatar = createAvatarView(size: size,
                                                  name: phoneNumber,
                                                  style: .outlined)
            avatarViews.append(outlinedAvatar)

            let outlinedPrimaryAvatar = createAvatarView(size: size,
                                                         name: phoneNumber,
                                                         style: .outlinedPrimary)
            avatarViews.append(outlinedPrimaryAvatar)

            addRow(text: size.description, items: [outlinedAvatar.view, outlinedPrimaryAvatar.view], textStyle: .footnote, textWidth: 100)
        }

        addTitle(text: "Group style")
        for size in MSFAvatarSize.allCases.reversed() {
            let name = "NorthWind Traders"
            let imageAvatar = createAvatarView(size: size,
                                               name: name,
                                               image: UIImage(named: "site")!,
                                               style: .group)
            avatarViews.append(imageAvatar)

            let initialsAvatar = createAvatarView(size: size,
                                                  name: name,
                                                  style: .group)
            avatarViews.append(initialsAvatar)

            addRow(text: size.description, items: [imageAvatar.view, initialsAvatar.view], textStyle: .footnote, textWidth: 100)
        }

        addTitle(text: "Overflow style")
        for size in MSFAvatarSize.allCases.reversed() {
            let overflowAvatar = createAvatarView(size: size,
                                                  name: "20",
                                                  style: .overflow)
            overflowAvatar.state.accessibilityLabel = "20 more contacts"

            avatarViews.append(overflowAvatar)

            addRow(text: size.description, items: [overflowAvatar.view], textStyle: .footnote, textWidth: 100)
        }
    }

    private var isUsingAlternateBackgroundColor: Bool = false {
        didSet {
            updateBackgroundColor()
        }
    }

    private var isPointerInteractionEnabled: Bool = false {
        didSet {
            if oldValue != isPointerInteractionEnabled {
                for avatarView in avatarViews {
                    avatarView.state.hasPointerInteraction = isPointerInteractionEnabled
                }
            }
        }
    }

    private var isShowingPresence: Bool = false {
        didSet {
            if oldValue != isShowingPresence {
                for avatarView in avatarViews {
                    avatarView.state.presence = isShowingPresence ? nextPresence() : .none
                }
            }
        }
    }

    private var isOutOfOffice: Bool = false {
        didSet {
            if oldValue != isOutOfOffice {
                for avatarView in avatarViews {
                    avatarView.state.isOutOfOffice = isOutOfOffice
                }
            }
        }
    }

    private var isShowingRings: Bool = false {
        didSet {
            if oldValue != isShowingRings {
                for avatarView in avatarViews {
                    avatarView.state.isRingVisible = isShowingRings
                }
            }
        }
    }

    private var isShowingRingInnerGap: Bool = true {
        didSet {
            if oldValue != isShowingRingInnerGap {
                for avatarView in avatarViews {
                    avatarView.state.hasRingInnerGap = isShowingRingInnerGap
                }
            }
        }
    }

    private var isTransparent: Bool = true {
        didSet {
            if oldValue != isTransparent {
                for avatarView in avatarViews {
                    avatarView.state.isTransparent = isTransparent
                }
            }
        }
    }

    private lazy var presenceIterator = MSFAvatarPresence.allCases.makeIterator()

    private func nextPresence() -> MSFAvatarPresence {
        var presence = presenceIterator.next()

        if presence == nil {
            presenceIterator = MSFAvatarPresence.allCases.makeIterator()
            presence = presenceIterator.next()
        }

        if presence! ==  .none {
            presence = presenceIterator.next()
        }

        return presence!
    }

    @objc private func toggleEnablePointerInteraction(switchView: UISwitch) {
        isPointerInteractionEnabled = switchView.isOn
    }

    @objc private func toggleShowPresence(switchView: UISwitch) {
        isShowingPresence = switchView.isOn
    }

    @objc private func toggleOutOfOffice(switchView: UISwitch) {
        isOutOfOffice = switchView.isOn
    }

    @objc private func toggleShowRings(switchView: UISwitch) {
        isShowingRings = switchView.isOn
    }

    @objc private func toggleShowRingInnerGap(switchView: UISwitch) {
        isShowingRingInnerGap = switchView.isOn
    }

    @objc private func toggleAlternateBackground(switchView: UISwitch) {
        isUsingAlternateBackgroundColor = switchView.isOn
    }

    @objc private func toggleOpaqueBorders(switchView: UISwitch) {
        isTransparent = !switchView.isOn
    }

    private func updateBackgroundColor() {
        view.backgroundColor = isUsingAlternateBackgroundColor ? UIColor(light: Colors.gray100, dark: Colors.gray600) : Colors.surfacePrimary
    }

    private var avatarViews: [MSFAvatar] = []

    private func createAvatarView(size: MSFAvatarSize,
                                  name: String? = nil,
                                  image: UIImage? = nil,
                                  style: MSFAvatarStyle) -> MSFAvatar {
        let avatarView = MSFAvatar(style: style,
                                     size: size)
        avatarView.state.primaryText = name
        avatarView.state.image = image

        return avatarView
    }
}

extension MSFAvatarSize {
    var description: String {
        switch self {
        case .xsmall:
            return "ExtraSmall"
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .xlarge:
            return "ExtraLarge"
        case .xxlarge:
            return "ExtraExtraLarge"
        }
    }
}