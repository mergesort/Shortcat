import UIKit

public protocol ShortcutNavigatableViewController: class {

    var isScrolling: Bool { get set }

    var keyUpTitle: String { get }
    var keyDownTitle: String { get }
    var pageUpTitle: String { get }
    var pageDownTitle: String { get }

}

extension ShortcutNavigatableViewController {

    var pageUpTitle: String {
        return NSLocalizedString("Page Up", comment: "Page Up")
    }

    var pageDownTitle: String {
        return NSLocalizedString("Page Down", comment: "Page Down")
    }

}
