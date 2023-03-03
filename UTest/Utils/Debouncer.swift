//
//  Debouncer.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 05.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import Foundation

protocol DebouncerProtocol: AnyObject {
    typealias Handler = () -> Void

    var handler: Handler? { get set }

    func renewInterval()
}

final class Debouncer: DebouncerProtocol {

    // MARK: - Properties

    var handler: Handler?

    private let timeInterval: TimeInterval
    private var timer: Timer?

    // MARK: - Initialization
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    // MARK: - Public
    public func renewInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: false
        ) { [weak self] (timer: Timer) in
            self?.timeIntervalDidFinish(for: timer)
        }
    }

    // MARK: - Private
    @objc private func timeIntervalDidFinish(for timer: Timer) {
        guard timer.isValid else { return }
        handler?()
        handler = nil
    }
}
