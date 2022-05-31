//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    struct Model {
        let cityName: String
        let temperature: String
        let shortForecast: String?
        let forecaseImageUrl: String?
    }

    static let identifier = "CityTableViewCell"//String(describing: CityTableViewCell.self)
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var shortDescriptionLabel: UILabel!
    @IBOutlet private weak var forecastImageView: UIImageView! {
        didSet {
            forecastImageView.layer.cornerRadius = 5.0
            forecastImageView.layer.borderWidth = 1.0
            forecastImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    override func prepareForReuse() {
        cityNameLabel.text = ""
        temperatureLabel.text = ""
        shortDescriptionLabel.text = ""
        forecastImageView.image = nil
    }

    func configure(with model: CityTableViewCell.Model) {
        cityNameLabel.text = model.cityName
        temperatureLabel.text = model.temperature
        shortDescriptionLabel.text = model.shortForecast
        
        if let thumbnailUrl = model.forecaseImageUrl {
            forecastImageView.loadThumbnial(urlString: thumbnailUrl)
        } else {
            forecastImageView.image = UIImage(named: "placeholder_forecast")
        }
    }
}
