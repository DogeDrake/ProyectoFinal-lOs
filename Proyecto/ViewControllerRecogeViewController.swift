
import Foundation
import UIKit

class ViewControllerRecogeViewController: UIViewController
{
    
    @IBOutlet weak var name: UILabel!
    
    
    var selectedShape : Rutinas!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        name.text = "potat"
    }
}
