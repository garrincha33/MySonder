//
//  CustomImageView.swift
//  Sonder
//
//  Created by Richard Price on 26/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView  {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, reponse, err) in
            if let err = err {
                print("unable to fetch image", err)
                return
            }
            guard let imageData = data else {return}
            let photoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}
