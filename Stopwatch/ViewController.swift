//
//  ViewController.swift
//  Stopwatch
//
//  Created by Kevin Wang on 10/24/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  var timer: Timer!
  var startButton: UILabel!

  var count: Double!

  override func viewDidLoad() {
    super.viewDidLoad()

    startButton = UILabel()

    count = 0.0

    setupViews()
    setupStartButton()
  }

  func setupViews() {
    view.backgroundColor = .white
    view.addSubview(startButton)

    startButton.text = String(count)
    startButton.textAlignment = .center
    startButton.snp.makeConstraints { make in
      make.centerX.centerY.equalTo(view)
      make.width.height.equalTo(100)
    }
  }

  func setupStartButton() {
    let tapped = UITapGestureRecognizer(target: self, action: #selector(tap))
    startButton.addGestureRecognizer(tapped)
    startButton.isUserInteractionEnabled = true
  }

  @objc func tap() {
    if let _ = timer {
      timer.invalidate()
      timer = Timer()
    } else {
      timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
        self.count += timer.timeInterval
        print("Count == \(self.count!)")
        self.startButton.text = String(format: "%.1f", self.count)
      })
      self.startButton.backgroundColor = .gray
    }
  }
}

