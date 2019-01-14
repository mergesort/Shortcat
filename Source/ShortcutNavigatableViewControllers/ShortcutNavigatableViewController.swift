import UIKit

public protocol ShortcutNavigatableViewController: class {

    var isScrolling: Bool { get set }

    var upArrowKeyCommandTitle: String { get }
    var downArrowKeyCommandTitle: String { get }
    var pageUpKeyCommandTitle: String { get }
    var pageDownKeyCommandTitle: String { get }

}

extension ShortcutNavigatableViewController {

    var pageUpKeyCommandTitle: String {
        return NSLocalizedString("Page Up", comment: "Page Up")
    }

    var pageDownKeyCommandTitle: String {
        return NSLocalizedString("Page Down", comment: "Page Down")
    }

}
