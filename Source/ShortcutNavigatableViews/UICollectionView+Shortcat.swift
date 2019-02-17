import UIKit

extension UICollectionView: ShortcutNavigatableView {

    var firstSelectedIndexPath: IndexPath? {
        return self.indexPathsForSelectedItems?.first
    }

    var firstCompletelyVisibleIndexPath: IndexPath? {
        return self.sortedVisibleIndexPaths
            .first(where: {
                return self.indexPathIsCompletelyVisible($0)
            })
    }

    var lastCompletelyVisibleIndexPath: IndexPath? {
        return self.sortedVisibleIndexPaths
            .last(where: {
                return self.indexPathIsCompletelyVisible($0)
            })
    }

    func deselectAllIndexPaths(animated: Bool = false) {
        self.indexPathsForSelectedItems?.forEach({ indexPath in
            self.deselectItem(at: indexPath, animated: animated)
        })
    }

    func indexPathIsCompletelyVisible(_ indexPath: IndexPath) -> Bool {
        guard let attributes = self.layoutAttributesForItem(at: indexPath) else { return false }
        return self.bounds.contains(attributes.frame)
    }

}

private extension UICollectionView {

    var sortedVisibleIndexPaths: [IndexPath] {
        return self.indexPathsForVisibleItems
            .sorted(by: {
                guard $0.section != $1.section else { return $0.row < $1.row }
                return $0.section < $1.section
            })
    }

}
