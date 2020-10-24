import UIKit
import Charts

class MeViewController: UIViewController {
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    weak var embeddedViewController: MeContainerViewController!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableContainer: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var cardContainer: UIView!

    var presenter: MeOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowContainer()
        configureHeader()
        presenter.didLoadView()
    }

    private func configureHeader() {
        setRoundedCorners()
        setShadow()
    }

    private func setRoundedCorners() {
        headerView.layer.cornerRadius = MeViewController.Constants.headerRadius
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    private func setShadow() {
        headerView.layer.shadowPath = UIBezierPath(rect: headerView.bounds).cgPath
        headerView.layer.shadowRadius = MeViewController.Constants.shadowRadius
        headerView.layer.shadowOpacity = MeViewController.Constants.shadowOpacity
        profileImage.layer.cornerRadius = MeViewController.Constants.viewRadius
    }
    private func setShadowContainer() {
        cardContainer.layer.shadowColor = UIColor.black.cgColor
        cardContainer.layer.shadowOpacity = MeViewController.Constants.shadowOpacity
        cardContainer.layer.shadowOffset = .zero
        cardContainer.layer.shadowRadius = MeViewController.Constants.shadowRadius
    }
    @IBAction private func didIndexChanged(_ sender: UISegmentedControl) {
        presenter.didIndexChanged(index: segmentControl.selectedSegmentIndex)
    }
}

extension MeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MeContainerViewController,
                    segue.identifier == "MeContainerSegue" {
            self.embeddedViewController = vc
        }
    }
}

extension MeViewController: MeInput {
    func setUserData(name: String, lastname: String, image: UIImage?) {
        nameLabel.text = name
        surnameLabel.text = lastname
        profileImage.image = image
    }

    func setUserSpentInfo(spent: Int) {
        embeddedViewController.setTotalSpent(spent: spent)
    }

    func setUserCurrentBalance(currentBalance: Int) {
        embeddedViewController.setCurrentBalance(currentBalance: currentBalance)
    }

    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        tableContainer.addSubview(viewController.view)
        viewController.view.frame = tableContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

}

extension MeViewController {
    struct Constants {
        static let headerRadius: CGFloat = 20
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity: Float = 0.6
        static let legendFormSize: Float = 15
    }
}

extension  NSUIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
