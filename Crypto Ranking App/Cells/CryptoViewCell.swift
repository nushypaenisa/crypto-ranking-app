//
//  CryptoViewCell.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 21/02/2025.
//


import UIKit
import SVGKit

class CryptoViewCell: UITableViewCell {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
               

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.textColor = .darkGray
            label.textAlignment = .right
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let changeLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.textAlignment = .right
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(changeLabel)
        

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),

            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            symbolLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            symbolLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
            changeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            changeLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }

    func configure(with model: Coin) {
        nameLabel.text = model.name
        priceLabel.text = "$\(model.price)"
        symbolLabel.text = model.symbol
        changeLabel.text = model.change
        if model.iconURL.hasSuffix(".svg") {
            loadSVG(from: model.iconURL)
        } else {
            loadImage(from: model.iconURL)
        }
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.iconImageView.image = image
            }
        }.resume()
    }

    private func loadSVG(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url),
                  let svgImage = SVGKImage(data: data) else { return }

            DispatchQueue.main.async {
                self.iconImageView.image = svgImage.uiImage
            }
        }
    }
}
    
