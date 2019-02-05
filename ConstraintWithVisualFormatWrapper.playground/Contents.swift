import UIKit


func applyConstraintsWithFormat(constraintInString:String,
                                forMetrics metrics:[Int],
                                forViews views: [UIView],
                                withMetricPrefix mprefix:String = "m",
                                withViewsPrefix vprefix:String = "v") {
    let metricsIdx = metrics.enumerated().compactMap({index, _ in mprefix + "\(index)" })
    let viewIdx = views.enumerated().compactMap({index, _ in vprefix + "\(index)" })
    NSLayoutConstraint.activate(
        NSLayoutConstraint.constraints(
            withVisualFormat: constraintInString,
            metrics:Dictionary.init(
                uniqueKeysWithValues:zip(metricsIdx, metrics)),
            views: Dictionary.init(
                uniqueKeysWithValues:
                zip(viewIdx, views)
            )
        )
    )
}

//useless in a playground.
//currently cause an error if you try applyConstraintsWithFormat to UIView (in playground)
//crash xcode if you try to inspect
//applyConstraintsWithFormat(constraintInString: "H:[v0(m1)]-m0-[v1(m1)]-m0-[v2(m1)]", forMetrics: [10, 40], forViews: [UIView])
