//
//  MovieDetailVC.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

class MovieDetailVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MovieDetailVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initVM()
    }
    
    func setupUI() {
        view.backgroundColor = StyleConstants.Color.darkBlue
        title = TextConstants.movieDetail
        let textAttributes = [NSAttributedString.Key.foregroundColor:StyleConstants.Color.lightGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        tableView.register(TitleHeaderCell.self)
        tableView.register(DashboardMoviesRowCell.self)
        tableView.register(DetailHeaderCell.self)
        tableView.register(ReviewCell.self)
        tableView.delegate = self
        tableView.dataSource = self        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func initVM() {
        viewModel.reloadDataClosure = reloadData()
        
        viewModel.showAlertClosure = { [weak self] (msg) in
            guard let self = self else { return }
            self.viewModel.alertMessage = nil
        }
        
        viewModel.getMovieDetail()
    }
    
    private func reloadData() -> (() -> Void) {
        return { [ weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func coordinator() -> MovieDetailCoordinator? {
        guard let coordinator = coordinator as? MovieDetailCoordinator else { return nil }
        return coordinator
    }
}



extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellTypes.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let feed = viewModel.cellTypes[section]
        switch feed {
        case .reviews(items: let items):
            return items.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = viewModel.cellTypes[indexPath.section]
        switch feed {
        case .header(let model):
            let cell: DetailHeaderCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(model: model, delegate: self)
            return cell            
        case .info:
            return UITableViewCell()
        case .similarMovies(items: let items):
            let cell: DashboardMoviesRowCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(title: "Similar Movies", model: items, delegate: self, titleColor: .white)
            return cell
        case .reviewTitle(let title):
            let cell: TitleHeaderCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(text: title)
            return cell
        case .reviews(let items):
            let cell: ReviewCell = tableView.dequeue(cellForRowAt: indexPath)
            let item = items[indexPath.row]
            cell.setCellData(model: item)
            return cell
        }
    }
}

extension MovieDetailVC: DashboardMoviesRowCellDelegate {
    func didTappedMovieItem(model: MovieModel) {
        coordinator()?.goMovieDetail(movie: model)
    }
}

extension MovieDetailVC: DetailHeaderCellDelegate {
    func didTappedBack() {
        coordinator()?.goBack()
    }
    
    func didTappedHome() {
        coordinator()?.goHome()
    }
}
