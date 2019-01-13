import Foundation

protocol ShortcutNavigatableView: class {

    var firstSelectedIndexPath: IndexPath? { get }
    var firstCompletelyVisibleIndexPath: IndexPath? { get }
    var lastCompletelyVisibleIndexPath: IndexPath? { get }
    func deselectAllIndexPaths(animated: Bool)
    func indexPathIsCompletelyVisible(_ indexPath: IndexPath) -> Bool

}
