//
//  CustomButton.swift
//  CustomUIButton
//
//  Created by Isnard Silva on 13/03/20.
//  Copyright © 2020 Isnard Silva. All rights reserved.
//

import UIKit

// Propriedade que permite que seja visualizado em tempo real
// pelo Interface Builder as edicoes feitas no botao
@IBDesignable
public final class CustomButton: UIButton {
    
    // MARK: - Properties
    
    // Propriedades que permitem que o usuario edite seu botao
    // tanto pelo Interface Builder quanto via Codigo

    // Texto presente em cada estado do botao
    @IBInspectable public var selectedText: String = "Selected"
    @IBInspectable public var deselectedText: String = "Deselected"
    
    // Cor do texto em cada state do Botao
    @IBInspectable public var textColorSelected: UIColor = .gray
    @IBInspectable public var textColorDeselected: UIColor = .lightGray
    
    // Cores das bordas em cada state do Botao
    @IBInspectable public var borderColorSelected: UIColor = .purple
    @IBInspectable public var borderColorDeselected: UIColor = .purple
    
    // Tamanho e arredondamento das bordas
    @IBInspectable public var borderWidth: CGFloat = 3.0
    @IBInspectable public var cornerRadius: CGFloat = 10.0
    
    // Identifica se o botao esta ativo/desativo
//    @IBInspectable public var active: Bool = false
    
    
    public override var isSelected: Bool {
        didSet {
            print("isSelected = \(oldValue)")
            if oldValue == true {
                setDeselected()
            } else {
                setSelected()
            }
        }
    }
    
    
    public override var isHighlighted: Bool {
        didSet {
            self.tintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    
    
//    override public var isHighlighted: Bool {
//        didSet {
//            self.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//        }
//    }
    
    
    // MARK: - Private properties
    
    // Criando uma borda customizada para o botao
    private let border = CAShapeLayer()
    
    
    // MARK: - Drawing
    // Realiza o desenho do conteudo da View - Botao
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        
        // Configurando a borda
        border.lineWidth = borderWidth
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(border)
        
        // Configurando o arredondamento das bordas
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        self.tintColor = .none
        
        
        // Desabilitando isHighlighted para que o fundo do
        // botao nao fique azul quando estiver no estado de Selected
        self.isHighlighted = false
//        self.adjustsImageWhenHighlighted = true
        
        // Configurando o botao dependendo de qual estado ele esta
        if isSelected {
            setSelected()
        } else {
            setDeselected()
        }
        
        // Add uma resposta ao toque do usuario no botao
        addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    // Configurando o botao para quando ele estiver selecionado
    public func setSelected() {
        // Mudando o estilo da borda
        border.lineDashPattern = nil
        border.strokeColor = borderColorSelected.cgColor
        
        // Mudando o estilo do texto
//        self.tintColor = .clear
        self.setTitle(selectedText, for: .selected)
        self.setTitleColor(textColorSelected, for: .selected)
    }
    
    // Configurando o botao para quando ele nao estiver selecionado
    public func setDeselected() {
        print(state.rawValue)
        // Mudando o estilo da borda
        border.lineDashPattern = [4, 4]
        border.strokeColor = borderColorDeselected.cgColor
        
        // Mudando o estilo do texto
        self.setTitle(deselectedText, for: .normal)
        self.setTitleColor(textColorDeselected, for: .normal)
    }
    
    
    
    // MARK: - Actions
    @objc private func onPress() {
        print("Button pressed")
        
        isSelected = !isSelected
        
        
        // Mudando o estado atual do botao
//        active = !active
        
//        if active {
//            setSelected()
//        } else {
//            setDeselected()
//        }
    }
}

