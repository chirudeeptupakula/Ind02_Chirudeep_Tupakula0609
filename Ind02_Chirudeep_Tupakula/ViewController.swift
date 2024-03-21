//
//  ViewController.swift
//  Ind02_Chirudeep_Tupakula
//
//  Created by Sandeep Nuthi on 3/21/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageViews: [UIImageView]! // Ensure these are connected via the storyboard
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var showAnswerButton: UIButton!
    
    var puzzleLogic: PuzzleLogic!
    var originalImages: [UIImage?] = [] // Initialize this with your 20 images

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages() // Call this to load your images into originalImages
        initializeGame()
    }
    
    func initializeGame() {
        puzzleLogic = PuzzleLogic(images: originalImages)
        puzzleLogic.shuffleTiles()
        updateUI()
    }

    func loadImages() {
        // Load your images from the assets into the originalImages array
        // Example loading logic (assuming images named "image1", "image2", ..., "image20")
        for i in 1...20 {
            let imageName = "image\(i)"
            if let image = UIImage(named: imageName) {
                originalImages.append(image)
            } else {
                print("Failed to load \(imageName) from assets.")
            }
        }
    }

    func updateUI() {
        // Assign images to imageViews and setup tap gestures
        for (index, imageView) in imageViews.enumerated() {
            imageView.image = puzzleLogic.images[index]
            imageView.isUserInteractionEnabled = true // Enable user interaction
            
            // Add tap gesture recognizer to each imageView
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tileTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageView.tag = index // Use tag to identify imageView in tileTapped
        }
    }
    
    @IBAction func shuffleTapped(_ sender: UIButton) {
        puzzleLogic.shuffleTiles()
        updateUI()
    }
    
    @IBAction func showAnswerTapped(_ sender: UIButton) {
        // Implementation for showing/hiding the answer
    }

    @objc func tileTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view else { return }
        let tappedIndex = tappedImageView.tag
        
        if puzzleLogic.isAdjacent(to: tappedIndex) {
            puzzleLogic.swapWithEmptySlot(tappedIndex)
            updateUI()
            
            // Optional: Add your puzzle solved logic here
        }
    }
    
    // Additional methods like checking if the puzzle is solved
}
