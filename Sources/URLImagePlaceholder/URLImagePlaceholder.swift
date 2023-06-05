import UIKit

public class URLImagePlaceholder: UIImageView {
    private let fallbackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public init(fallbackText: String? = nil, fallbackTextColor: UIColor = .white, fallbackTextFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold), frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.fallbackText = fallbackText
        self.fallbackLabel.textColor = fallbackTextColor
        self.fallbackLabel.font = fallbackTextFont
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(fallbackLabel)
        fallbackLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fallbackLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        fallbackLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 8).isActive = true
    }
    
    public func setImageURL(_ url: URL, placeholderImage: UIImage? = nil, fallbackText: String? = nil) {
        image = placeholderImage
        self.fallbackText = fallbackText
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error fetching image data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.image = nil
                    self?.fallbackLabel.isHidden = false
                }
            } else {
                DispatchQueue.main.async {
                    let httpResponse = response as? HTTPURLResponse
                    print("httpResponse: \(httpResponse.statusCode)")
                    if  httpResponse.statusCode != 200 {
                        self?.image = nil
                        self?.fallbackLabel.isHidden = false
                    } else {
                        if let data = data, let image = UIImage(data: data) {
                            self?.image = image
                        }
                        self?.fallbackLabel.isHidden = true
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    public var fallbackText: String? {
        get {
            return fallbackLabel.text
        }
        set {
            fallbackLabel.text = newValue
            fallbackLabel.sizeToFit()
            fallbackLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
}
