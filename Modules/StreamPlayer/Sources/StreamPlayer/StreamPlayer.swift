//
//  StreamPlayer.swift
//  
//
//  Created by Vladislav Lisianskii on 06.03.2023.
//

import AVFoundation

public protocol PlaysStreamAudio {
    func play()
    func pause()
}

public final class StreamPlayer: PlaysStreamAudio {

    // MARK: - Properties
    private let playerItem: AVPlayerItem
    private let player: AVPlayer

    // MARK: - Initialization
    public init(url: URL) {
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }

    // MARK: - Public
    public func play() {
        player.play()
    }

    public func pause() {
        player.pause()
    }
}
