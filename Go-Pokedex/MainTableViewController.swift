//
//  MainTableViewController.swift
//

import UIKit
import CloudKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableview: UITableView!
    let kCloseCellHeight: CGFloat = 85
    let kOpenCellHeight: CGFloat = 500
    
    var kRowsCount = 150
    
    var cellHeights = [CGFloat]()

    // selected pokemon index used to knpw which cell has been selected
    var selectedPokemon = 0
    
    // set the cursor
    var theCursor:CKQueryCursor!
    var loadMoreOk: Bool = false
    
    var activityIndicator: NVActivityIndicatorView! = nil
    var pokemonEvolutionList = [[Pokemon]]()
    
    var filteredPokemons = Array<Pokemon>()
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false
    
    var animated = false
    
    var needClose: Bool = false
    var index: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initActivityIndicator()
        searchBar.hidden = true
        tableview.backgroundColor = UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        initPokemon()
        initSearch()
        animateTable()
        delay(1.5) {
            self.tableview.backgroundColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.0)
        }
            }
   
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
   

    
    func initPokemon() {
        pokemonList = initAllPokemons()
        typeList = initAllTypes()
        quickMoveList = initAllQuickMoves()
        chargeMoveList = initAllChargeMoves()
        initAllPokemonInfos(pokemonList, quickMoveList: quickMoveList, chargeMoveList: chargeMoveList, typeList: typeList)
        addTypes(chargeMoveList, typeList: typeList)
        addTypes(quickMoveList, typeList: typeList)
        
        kRowsCount = pokemonList.count
        createCellHeightsArray()
        tableview.reloadData()
        activityIndicator.stopAnimation()
        searchBar.hidden = false
    }
    
    func initSearch() {
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            tableview.reloadData()
        } else {
            inSearchMode = true
            let lowercaseString = searchBar.text!.lowercaseString
            filteredPokemons = pokemonList.filter({(($0.name).lowercaseString.rangeOfString(lowercaseString) != nil)})
            tableview.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        searchBar.showsCancelButton = false
        filteredPokemons = pokemonList
        tableview.reloadData()
    }
    

    func initActivityIndicator() {
        self.activityIndicator = NVActivityIndicatorView(frame: CGRectMake(0, 0, 80, 80))
        self.activityIndicator.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/2 - activityIndicator.frame.height/2)
        self.activityIndicator.type = NVActivityIndicatorType.BallClipRotatePulse
        self.activityIndicator.color = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
        self.tableview.addSubview(activityIndicator)
        self.activityIndicator.startAnimation()
    }
    
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemons.count
        } else {
            return pokemonList.count
        }
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard case let cell as DemoCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! DemoCell

        var pokemonCopy: Pokemon
        if inSearchMode {
            pokemonCopy = filteredPokemons[indexPath.row]
        } else {
            pokemonCopy = pokemonList[indexPath.row]
        }
        cell.initHeader(pokemonCopy)
        cell.initMidCell(pokemonCopy)
        cell.initEvolution(pokemonCopy)
        cell.vc = self
        cell.pokemonId = indexPath.row
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    // MARK: Table vie delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        if cell.isAnimating() {
            return
        }
        
        if needClose {
            cellHeights[indexPath.row] = kCloseCellHeight
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else { // close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
    
    // Animation tableview
    func animateTable() {
        tableview.reloadData()
        
        let cells = tableview.visibleCells
        let tableHeight: CGFloat = tableview.bounds.size.height
        
        if index == 1 {
            for i in cells {
                let cell: UITableViewCell = i as UITableViewCell
                cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
            }
            
            for a in cells {
                let cell: UITableViewCell = a as UITableViewCell
                UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn , animations: {
                    cell.transform = CGAffineTransformMakeTranslation(0, 0);
                    }, completion: nil)
                
                self.index += 1
            }
        }
    }

    
    // prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            if inSearchMode {
                (segue.destinationViewController as! pokemonDetailViewController).pokemon = filteredPokemons[selectedPokemon]
            } else {
                (segue.destinationViewController as! pokemonDetailViewController).pokemon = pokemonList[selectedPokemon]
            }
        }
    }
}
