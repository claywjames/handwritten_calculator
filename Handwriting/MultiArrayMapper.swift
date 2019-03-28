//
//  DigitMapper.swift
//  Handwriting
//
//  Created by Clay James on 3/27/19.
//  Copyright © 2019 Clay James. All rights reserved.
//

import Foundation
import CoreML

class MultiArrayMapper {
    static func mapImageToMultiArray(image: CGImage) -> MLMultiArray? {
            guard let data = try? MLMultiArray(shape: [8,8], dataType: .double) else {
                return nil
            }
            
            let hTileWidth = image.width / 8
            let vTileWidth = image.height / 8
            
            var xPos = 0
            var yPos = 0
            
            for rowIndex in 0...7 {
                for colIndex in 0...7 {
                    //cut the image part at the certain coordinates
                    let imageRect = CGRect(x: xPos, y: yPos, width: hTileWidth, height: vTileWidth)
                    let cutImage = image.cropping(to: imageRect)
                    let avgColor = cutImage.areaAverage()
                    var grayscale: CGFloat = 0
                    var alpha: CGFloat = 0
                    
                    avgColor.getWhite(&grayscale, alpha: &alpha)
                    xPos += hTileWidth
                    
                    let alphaAsNumber = NSNumber(integerLiteral: Int(alpha * 16.0))
                    data[rowIndex*8 + colIndex] = alphaAsNumber
                }
                xPos = 0
                yPos += vTileWidth
            }
            return data
    }
}
