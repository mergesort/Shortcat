import UIKit

class HomeViewController: UIViewController {

    private static let reuseIdentifier = "reuseIdentifier"

    var isScrolling: Bool = false

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.section) : \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }

}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.reuseIdentifier) else { fatalError() }
        cell.textLabel?.text = "Row \(indexPath.row)"

        return cell
    }

}

extension HomeViewController: ShortcutNavigatableTableViewController {

    public override var keyCommands: [UIKeyCommand]? {
        return self.navigationAndInputKeyCommands
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimationNavigationHandler(scrollView)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollViewWillBeginDraggingNavigationHandler(scrollView)
    }

}

private extension HomeViewController {

    func setup() {
        self.navigationItem.title = "Shortcat 🐱"
        self.view.addSubview(self.tableView)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeViewController.reuseIdentifier)

        self.setupConstraints()
    }

    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ]

        NSLayoutConstraint.activate(constraints)
    }

}
