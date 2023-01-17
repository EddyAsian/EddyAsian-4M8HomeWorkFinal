import UIKit

//protocol ProductCellImageDelegate: AnyObject {
//
//    func openNewImageViewController(_ item: PhoneModel)
//}

class SearchProductTableViewCell: UITableViewCell {
    public static let reusedID = String(describing: SearchProductTableViewCell.self)
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var category: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var timeScheduleLabel: UILabel!
    @IBOutlet private weak var productRate: UILabel!
    @IBOutlet private weak var brand: UILabel!
    @IBOutlet private weak var stock: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productTime: UILabel!
    @IBOutlet private weak var productDistance: UILabel!
    @IBOutlet private weak var searchCustomView: UIView!
    weak var delegate: ProductCellImageDelegate?
    private var product: ProductModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        foodImgGestureRecognizer()
    }
    
    func display(phone: ProductArray) {
        guard let imageURLPath = URL(string: phone.thumbnail) else {
            print("Incorrect url for image url path")
            return
        }
        productName.text = phone.title
        //        downloadImage(from: imageURLPath, to: self.productImage)
        discountLabel.text = "\(phone.discountPercentage)"
        category.text = phone.category
        productRate.text = "\(phone.rating)"
        brand.text = phone.brand
        stock.text = "\(phone.stock)"
        productPrice.text = "\(phone.price)"
        descriptionLabel.text = phone.description
    }
    
    func foodImgGestureRecognizer() {
        let productImageTap = UITapGestureRecognizer(
            target: self, action: #selector(tapOnProductImage)
        )
        productImage.isUserInteractionEnabled = true
        productImage.addGestureRecognizer(productImageTap)
    }
    
    @objc
    private func tapOnProductImage() {
        guard let product = product else {
            return
        }
        delegate?.openNewImageViewController(product)
    }
   public static var reuseID = String(describing: SearchProductTableViewCell.self)
}

extension SearchProductTableViewCell {
   private func getData(from url: URL, completion: @escaping (
        Data?, URLResponse?, Error?
    ) -> ()) {
        URLSession.shared.dataTask(
            with: url, completionHandler: completion
        ).resume()
    }
    private func downloadImage(from url: URL, to imageView: UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
}


