import UIKit

class HomeViewController: UIViewController {
    
    let viewModel:ViewModel = ViewModel()
    
    var screen: HomeScreenView2?
    
    override func loadView() {
        self.screen = HomeScreenView2()
        
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate(delegate: self)
        self.viewModel.fetchAllRequest()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        cell?.setupCell(user: self.viewModel.loudCurrentUser(indexPath: indexPath))
        cell?.delegate(delegate: self)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.viewModel.getName(indexPath: indexPath))
    }
    
}

extension HomeViewController: CustomTableViewCellDelegate{
    func tappedHeartButton(_ user: User) {
        self.viewModel.exchangeHearState(user)
    }
}

extension HomeViewController:ViewModelDelegate{
    func sucessRequest() {
        self.screen?.setupTableViewProtocols(delegate: self, dataSource: self)
        self.screen?.reloadTableView()
    }
    
    func errorRequest() {
        print("Error ao realizar a request")
    }
    
    
    
    
}


