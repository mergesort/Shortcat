import UIKit

public protocol ShortcutNavigatableTableViewController: ShortcutNavigatableViewController {

    var tableView: UITableView { get }

}

extension ShortcutNavigatableTableViewController {

    var keyUpTitle: String {
        return NSLocalizedString("Previous Item", comment: "Previous Item")
    }

    var keyDownTitle: String {
        return NSLocalizedString("Next Item", comment: "Next Item")
    }

    var enterTitle: String {
        return NSLocalizedString("Open Selected", comment: "Open Selected")
    }

    func scrollViewDidEndScrollingAnimationNavigationHandler(_ scrollView: UIScrollView) {
        if let firstSelectedIndexPath = self.tableView.firstSelectedIndexPath, self.isScrolling {
            let cell = self.tableView.cellForRow(at: firstSelectedIndexPath)
            cell?.setSelected(true, animated: false)
        }

        self.isScrolling = false
    }

    public func scrollViewWillBeginDraggingNavigationHandler(_ scrollView: UIScrollView) {
        // Reset selected index paths so next key up/down is within current view
        self.tableView.deselectAllIndexPaths()
    }

}

extension ShortcutNavigatableTableViewController where Self: UIViewController {

    var navigationKeyCommands: [UIKeyCommand] {
        return [
            UIKeyCommand(
                input: " ",
                modifierFlags: .shift,
                action: #selector(self.tableView_pageUp),
                discoverabilityTitle: self.pageUpTitle
            ),

            UIKeyCommand(
                input: " ",
                modifierFlags: UIKeyModifierFlags(rawValue: 0),
                action: #selector(self.tableView_pageDown),
                discoverabilityTitle: self.pageDownTitle
            ),

            UIKeyCommand(
                input: UIKeyCommand.inputUpArrow,
                modifierFlags: UIKeyModifierFlags(rawValue: 0),
                action: #selector(self.tableView_keyUp),
                discoverabilityTitle: self.keyUpTitle
            ),

            UIKeyCommand(
                input: UIKeyCommand.inputDownArrow,
                modifierFlags: UIKeyModifierFlags(rawValue: 0),
                action: #selector(self.tableView_keyDown),
                discoverabilityTitle: self.keyDownTitle
            ),
        ]

    }

    var enterKeyCommand: UIKeyCommand {
        return UIKeyCommand(
            input: "\r",
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(self.tableView_keyEnter),
            discoverabilityTitle: self.enterTitle
        )
    }

    var navigationAndInputKeyCommands: [UIKeyCommand] {
        return [self.navigationKeyCommands, [self.enterKeyCommand]].flatMap { $0 }
    }

}

private extension UIViewController {

    @objc
    func tableView_keyEnter() {
        guard let self = self as? ShortcutNavigatableTableViewController else { return }
        guard let selectedIndexPath = self.tableView.firstSelectedIndexPath else { return }

        self.tableView.delegate?.tableView?(self.tableView, didSelectRowAt: selectedIndexPath)
    }

    @objc
    func tableView_keyUp() {
        guard let self = self as? (UIViewController & ShortcutNavigatableTableViewController) else { return }
        guard !self.isScrolling else { return }
        guard let lastVisibleIndexPath = self.tableView.lastCompletelyVisibleIndexPath else { return }

        let indexPathToSelect: IndexPath

        if let firstSelectedIndexPath = self.tableView.firstSelectedIndexPath {
            let row = Swift.max(firstSelectedIndexPath.row - 1, 0)

            if firstSelectedIndexPath.section > 0 && firstSelectedIndexPath.row == 0 {
                let section = firstSelectedIndexPath.section - 1
                let row = self.tableView.numberOfRows(inSection: section) - 1
                indexPathToSelect = IndexPath(row: row, section: section)
            } else {
                indexPathToSelect = IndexPath(row: row, section: firstSelectedIndexPath.section)
            }
        } else {
            indexPathToSelect = lastVisibleIndexPath
        }

        let position: UITableView.ScrollPosition = self.isScrolling ? .top : .none
        self.moveToRow(at: indexPathToSelect, position: position)
    }

    @objc
    func tableView_keyDown() {
        guard let self = self as? (UIViewController & ShortcutNavigatableTableViewController) else { return }
        guard !self.isScrolling else { return }

        guard let firstVisibleIndexPath = self.tableView.firstCompletelyVisibleIndexPath else { return }

        let indexPathToSelect: IndexPath

        if let firstSelectedIndexPath = self.tableView.firstSelectedIndexPath {
            let itemCount = self.tableView.numberOfRows(inSection: firstSelectedIndexPath.section)
            let row = Swift.min(firstSelectedIndexPath.row + 1, itemCount - 1)

            if firstSelectedIndexPath.row == itemCount - 1, firstSelectedIndexPath.section < self.tableView.numberOfSections - 1 {
                let section = firstSelectedIndexPath.section + 1
                indexPathToSelect = IndexPath(row: 0, section: section)
            } else {
                indexPathToSelect = IndexPath(row: row, section: firstSelectedIndexPath.section)
            }
        } else {
            indexPathToSelect = firstVisibleIndexPath
        }

        let position: UITableView.ScrollPosition = self.isScrolling ? .bottom : .none
        self.moveToRow(at: indexPathToSelect, position: position)
    }

    @objc
    func tableView_pageUp() {
        guard let self = self as? ShortcutNavigatableTableViewController else { return }
        guard let firstCompletelyVisibleIndexPath = self.tableView.firstCompletelyVisibleIndexPath else { return }

        self.tableView.scrollToRow(at: firstCompletelyVisibleIndexPath, at: .bottom, animated: true)
        self.tableView.deselectAllIndexPaths()
    }

    @objc
    func tableView_pageDown() {
        guard let self = self as? ShortcutNavigatableTableViewController else { return }
        guard let lastCompletelyVisibleIndexPath = self.tableView.lastCompletelyVisibleIndexPath else { return }

        self.tableView.scrollToRow(at: lastCompletelyVisibleIndexPath, at: .top, animated: true)
        self.tableView.deselectAllIndexPaths()
    }

    func moveToRow(at indexPath: IndexPath, position: UITableView.ScrollPosition) {
        guard let self = self as? ShortcutNavigatableTableViewController else { return }

        self.tableView.deselectAllIndexPaths()
        self.tableView.selectRow(at: indexPath, animated: self.isScrolling, scrollPosition: position)
        self.tableView.scrollToRow(at: indexPath, at: position, animated: self.isScrolling)
    }

}
