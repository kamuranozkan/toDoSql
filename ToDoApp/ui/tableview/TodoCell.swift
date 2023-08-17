import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var todoContentLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
