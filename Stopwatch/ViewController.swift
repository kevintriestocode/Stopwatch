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

    startButton.layer.cornerRadius = 50
    startButton.layer.masksToBounds = true

    startButton.snp.makeConstraints { make in
      make.centerX.centerY.equalTo(view)
      make.width.height.equalTo(100)
    }
  }

  func setupStartButton() {
    let tapped = UITapGestureRecognizer(target: self, action: #selector(tap))
    let held = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
//    held.minimumPressDuration = 1.3

    startButton.addGestureRecognizer(tapped)
    startButton.addGestureRecognizer(held)

    startButton.isUserInteractionEnabled = true
  }

  @objc func tap() {
    if let _ = timer {
      self.startButton.backgroundColor = .gray
      timer.invalidate()
      timer = Timer()
    } else {
      timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
        self.count += timer.timeInterval
        self.startButton.text = String(format: "%.1f", self.count)
      })
      self.startButton.backgroundColor = UIColor(red: 75/255, green: 160/255, blue: 24/255, alpha: 1)
    }
  }

  @objc func longPress(sender: UILongPressGestureRecognizer) {
    sender.minimumPressDuration = 1.3
    if sender.state == .began {
      if let _ = timer {
        timer.invalidate()
        timer = Timer()
      }

      self.count = 0.0
      self.startButton.text = String(self.count!)
      self.startButton.backgroundColor = .white
    }
  }
}

