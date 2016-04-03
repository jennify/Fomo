//
// DayHeaderCell.swift
// ============================


import UIKit


class DayHeaderCell: UITableViewHeaderFooterView {

    var dayName: UILabel = UILabel.newAutoLayoutView()

    var didSetupConstraints = false

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initViews()
        updateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViews()
        updateConstraints()
    }

    override func updateConstraints() {
        if !didSetupConstraints {
            dayName.autoPinEdgeToSuperviewEdge(.Bottom)
            dayName.autoAlignAxisToSuperviewAxis(.Vertical)

            didSetupConstraints = true
        }

        super.updateConstraints()
    }

    func initViews() {
        dayName = UILabel()
        dayName.text = "Testing"
        addSubview(dayName)
    }
}
