import UIKit

public protocol ShortcutNavigatableScrollViewController: ShortcutNavigatableViewController {

    var scrollView: UIScrollView { get }

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

    var navigationKeyCommands: [UIKeyCommand] {
        return [
            UIKeyCommand(
                input: " ",
                modifierFlags: .shift,
                action: #selector(self.scrollView_pageUp),
                discoverabilityTitle: self.pageUpTitle
            ),

            UIKeyCommand(
                input: " ",
                modifierFlags: UIKeyModifierFlags(rawValue: 0),
                action: #selector(self.scrollView_pageDown),
                discoverabilityTitle: self.pageDownTitle
            ),

            UIKeyCommand(
                input: UIKeyCommand.inputUpArrow,
                modifierFlags: UIKeyModifierFlags(rawValue: 0),
                action: #selector(self.scrollView_keyUp),
                discoverabilityTitle: self.keyUpTitle
            ),

            UIKeyCommand(
                input: UIKeyCommand.inputDownArrow,
                modifierFlags: UIKeyModifierFlags(rawValue: 0),
                action: #selector(self.scrollView_keyDown),
                discoverabilityTitle: self.keyDownTitle
            ),
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
    func scrollView_keyUp() {
        guard let self = self as? ShortcutNavigatableScrollViewController else { return }

        let yOffset = Swift.max(self.scrollView.contentOffset.y - scrollArrowHeight, 0)
        self.scrollToPoint(CGPoint(x: 0, y: yOffset))
    }

    @objc
    func scrollView_keyDown() {
        guard let self = self as? ShortcutNavigatableScrollViewController else { return }

        let yOffset = Swift.min(self.scrollView.contentOffset.y + scrollArrowHeight, self.scrollView.contentSize.height - self.scrollView.frame.size.height)
        self.scrollToPoint(CGPoint(x: 0, y: yOffset))
    }

    @objc
    func scrollView_pageUp() {
        guard let self = self as? ShortcutNavigatableScrollViewController else { return }

        let yOffset = Swift.max(self.scrollView.contentOffset.y - self.scrollView.frame.size.height + scrollWithinPageMargin, 0)
        self.scrollToPoint(CGPoint(x: 0, y: yOffset))
    }

    @objc
    func scrollView_pageDown() {
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
