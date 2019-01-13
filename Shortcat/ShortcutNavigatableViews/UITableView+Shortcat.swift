import UIKit

extension UITableView: ShortcutNavigatableView {

    var firstSelectedIndexPath: IndexPath? {
        return self.indexPathsForSelectedRows?.first
    }

    var firstCompletelyVisibleIndexPath: IndexPath? {
        return self.sortedVisibleIndexPaths?
            .first(where: {
                return self.indexPathIsCompletelyVisible($0)
            })
    }

    var lastCompletelyVisibleIndexPath: IndexPath? {
        return self.sortedVisibleIndexPaths?
            .last(where: {
                return self.indexPathIsCompletelyVisible($0)
            })
    }

    func deselectAllIndexPaths(animated: Bool = false) {
        self.indexPathsForSelectedRows?.forEach({ indexPath in
            self.deselectRow(at: indexPath, animated: animated)
        })
    }

    func indexPathIsCompletelyVisible(_ indexPath: IndexPath) -> Bool {
        let cellFrame = self.rectForRow(at: indexPath)
        return self.bounds.contains(cellFrame)
    }

}

private extension UITableView {

    var sortedVisibleIndexPaths: [IndexPath]? {
        return self.indexPathsForVisibleRows?
            .sorted(by: {
                guard $0.section != $1.section else { return $0.row < $1.row }
                return $0.section < $1.section
            })
    }

}
