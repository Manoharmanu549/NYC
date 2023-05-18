//
//  SchoolDetailViewController.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: SchoolDetailViewModel
    
    // MARK: - UI Components
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(writingScoreLabel)
        stack.addArrangedSubview(mathScoreLabel)
        stack.addArrangedSubview(readingScoreLabel)
        stack.addArrangedSubview(totalTestTakersLabel)
        stack.addArrangedSubview(UIView())
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 10
        
        return stack
    }()
    
    private lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var writingScoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var mathScoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var readingScoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var totalTestTakersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Initialization
    
    init(viewModel: SchoolDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setNavigationBar()
        setUIData()
        configUI()
    }
    
    // MARK: - View Setup
    
    private func configUI() {
        view.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setUIData() {
        self.title = viewModel.schoolDetails.schoolName
        writingScoreLabel.attributedText = getFormatedString(title: String.WritingAvgScoreText, value: viewModel.schoolDetails.satWritingAvgScore)
        
        mathScoreLabel.attributedText = getFormatedString(title: String.MathAvgScoreText, value: viewModel.schoolDetails.satMathAvgScore)
        readingScoreLabel.attributedText = getFormatedString(title: String.TotalTestTakersText, value: viewModel.schoolDetails.satCriticalReadingAvgScore)
        totalTestTakersLabel.attributedText = getFormatedString(title: String.TotalTestTakersText, value: viewModel.schoolDetails.numOfSatTestTakers)
        
    }
    
    private func getFormatedString(title: String, value: String? = "") -> NSMutableAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.customGreen, NSAttributedString.Key.kern: 3]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        let firstString = NSMutableAttributedString(string: title, attributes: firstAttributes)
        let secondString = NSAttributedString(string: value ?? "", attributes: secondAttributes)
        firstString.append(secondString)
        return firstString
    }
    
    private func setNavigationBar() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.text = self.viewModel.schoolDetails.schoolName
        self.navigationItem.titleView = label
        self.navigationController?.navigationBar.backgroundColor = .gray
    }
}

extension String {
    static let TotalTestTakersText = "Number of SAT Test Takers: "
    static let ReadingAvgScoreText = "Critical Reading Avg Score: "
    static let MathAvgScoreText = "Math avg score: "
    static let WritingAvgScoreText = "Writing Avg Score: "
}

extension UIColor {
    static let customGreen = UIColor(hexString: "#85DBA1")
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
