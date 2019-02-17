import UIKit

public protocol ShortcutNavigatableScrollViewController: ShortcutNavigatableViewController {

    var scrollView: UIScrollView { get }
    var navigationKeyCommands: [UIKeyCommand] { get }

}

extension ShortcutNavigatableScrollViewController {

    var keyUpTitle: String {
        return NSLocalizedString("Scroll Up", comment: "Scroll Up")
    }

    var keyDownTitle: String {
        return NSLocalizedString("Scroll Down", comment: "Scroll Down")
    }

    func scrollViewDidEndScrollingAnimationNavigationHandler(_ scrollView: UIScrollView) {
        self.isScrolling = false
    }

}

extension ShortcutNavigatableScrollViewController where Self: UIViewController {

    var upArrowKeyCommand: UIKeyCommand {
        return UIKeyCommand(
            input: UIKeyCommand.inputUpArrow,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(self._scrollViewKeyUp),
            discoverabilityTitle: self.upArrowKeyCommandTitle
        )
    }

    var downArrowKeyCommand: UIKeyCommand {
        return UIKeyCommand(
            input: UIKeyCommand.inputDownArrow,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(self._scrollViewKeyDown),
            discoverabilityTitle: self.downArrowKeyCommandTitle
        )
    }

    var pageUpKeyCommand: UIKeyCommand {
        return UIKeyCommand(
            input: " ",
            modifierFlags: .shift,
            action: #selector(self._scrollViewPageUp),
            discoverabilityTitle: self.pageUpKeyCommandTitle
        )
    }

    var pageDownKeyCommand: UIKeyCommand {
        return UIKeyCommand(
            input: " ",
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(self._scrollViewPageDown),
            discoverabilityTitle: self.pageDownKeyCommandTitle
        )
    }

    var navigationKeyCommands: [UIKeyCommand] {
        return [
            self.upArrowKeyCommand,
            self.downArrowKeyCommand,
            self.pageUpKeyCommand,
            self.pageDownKeyCommand
        ]
    }

}

private extension UIViewController {

    private var scrollArrowHeight: CGFloat {
        return 350.0
    }

    private var scrollWithinPageMargin: CGFloat {
        return 150.0
    }

    @objc
    func _scrollViewKeyUp() {
        guard let self = self as? ShortcutNavigatableScrollViewController else { return }

        let yOffset = Swift.max(self.scrollView.contentOffset.y - scrollArrowHeight, 0)
        self.scrollToPoint(CGPoint(x: 0, y: yOffset))
    }

    @objc
    func _scrollViewKeyDown() {
        guard let self = self as? ShortcutNavigatableScrollViewController else { return }

        let yOffset = Swift.min(self.scrollView.contentOffset.y + scrollArrowHeight, self.scrollView.contentSize.height - self.scrollView.frame.size.height)
        self.scrollToPoint(CGPoint(x: 0, y: yOffset))
    }

    @objc
    func _scrollViewPageUp() {
        guard let self = self as? ShortcutNavigatableScrollViewController else { return }

        let yOffset = Swift.max(self.scrollView.contentOffset.y - self.scrollView.frame.size.height + scrollWithinPageMargin, 0)
        self.scrollToPoint(CGPoint(x: 0, y: yOffset))
    }

    @objc
    func _scrollViewPageDown() {
        guard let self = self as? ShortcutNavigatableScrollViewController else { return }

        let yOffset = Swift.min(self.scrollView.contentOffset.y + self.scrollView.frame.size.height - scrollWithinPageMargin, self.scrollView.contentSize.height - self.scrollView.frame.size.height)
        self.scrollToPoint(CGPoint(x: 0, y: yOffset))
    }

}

private extension ShortcutNavigatableScrollViewController {

    func scrollToPoint(_ point: CGPoint) {
        if self.isScrolling || point.y == self.scrollView.contentOffset.y {
            return
        }

        self.isScrolling = true
        self.scrollView.setContentOffset(point, animated: true)
    }

}
