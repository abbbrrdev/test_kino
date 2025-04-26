//
//  YearCell.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//
import UIKit

class YearCell: UICollectionViewCell {
    private let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.isUserInteractionEnabled = false 
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with year: Int) {
        button.setTitle("\(year)", for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
