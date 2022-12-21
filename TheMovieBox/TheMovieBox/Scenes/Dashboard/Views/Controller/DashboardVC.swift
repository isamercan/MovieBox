//
//  ViewController.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

class DashboardVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = DashboardVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoriteMovies()
    }
    
    func setupUI() {
        view.backgroundColor = StyleConstants.Color.darkBlue
        tableView.backgroundColor = StyleConstants.Color.darkBlue
        tableView.register(DashboardHeaderCell.self)
        tableView.register(DashboardMoviesRowCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initVM() {
        viewModel.reloadDataClosure = reloadData()
        
        viewModel.showAlertClosure = { [weak self] (msg) in
            guard let self = self else { return }
            self.viewModel.alertMessage = nil
        }
    }
    
    private func reloadData() -> (() -> Void) {
        return { [ weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}


extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = viewModel.cellTypes[indexPath.row]
        switch feed {
        case .header:
            let cell: DashboardHeaderCell = tableView.dequeue(cellForRowAt: indexPath)
            return cell
        case .popularMovies(let items):
            let cell: DashboardMoviesRowCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(title: feed.title, model: items, delegate: self)
            return cell
        case .highlyRatedMovies(let items):
            let cell: DashboardMoviesRowCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(title: feed.title, model: items, delegate: self)
            return cell
        case .upcomingMovies(let items):
            let cell: DashboardMoviesRowCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(title: feed.title, model: items, delegate: self)
            return cell
        case .favoriteMovies(let items):
            let cell: DashboardMoviesRowCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(title: feed.title, model: items, delegate: self)
            return cell
        }
    }
}


extension DashboardVC: DashboardMoviesRowCellDelegate {
    func didTappedMovieItem(model: MovieModel) {
        guard let id = model.id else { return }
        (self.coordinator as? DashboardCoordinator)?.goMovieDetail(movieID: id)
    }
}
