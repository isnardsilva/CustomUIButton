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
    @IBInspectable public var disabledText: String = "Disable"
    
    // Cor do texto em cada state do Botao
    @IBInspectable public var textColorSelected: UIColor = .gray
    @IBInspectable public var textColorDeselected: UIColor = .lightGray
    @IBInspectable public var textColorDisabled: UIColor = .lightGray
    
    // Cores das bordas em cada state do Botao
    @IBInspectable public var borderColorSelected: UIColor = .purple
    @IBInspectable public var borderColorDeselected: UIColor = .purple
    @IBInspectable public var borderColorDisabled: UIColor = .gray
    
    // Tamanho e arredondamento das bordas
    @IBInspectable public var borderWidth: CGFloat = 3.0
    @IBInspectable public var cornerRadius: CGFloat = 10.0
    
    
    // Controla a state de quando o botao esta selecionado
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
    
    // Controla o estado de quando o usuario toca e tira o
    // dedo do botao
    public override var isHighlighted: Bool {
        didSet {
            // Impedindo que ao clicar o fundo do botao fique azul
            self.tintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    
    // Controla o estado do botao quando ele estiver desabilitado
    public override var isEnabled: Bool {
        didSet {
            if oldValue == true {
                setDisabled()
            }
        }
    }
    
    
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
        
        
        // Desabilitando isHighlighted para que o fundo do
        // botao nao fique azul quando estiver no estado de Selected
        self.isHighlighted = false
        
        // Configurando o botao dependendo de qual estado ele esta
        // Verificando se esta ativo
        if isEnabled {
            // Verificando se esta selecionado
            if isSelected {
                setSelected()
            } else {
                setDeselected()
            }
        } else {
            setDisabled()
        }
        
        
        // Add uma resposta ao toque do usuario no botao
        addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    // Configurando o botao para quando ele estiver selecionado
    private func setSelected() {
        // Mudando o estilo da borda
        border.lineDashPattern = nil
        border.strokeColor = borderColorSelected.cgColor
        
        // Mudando o estilo do texto
//        self.tintColor = .clear
        self.setTitle(selectedText, for: .selected)
        self.setTitleColor(textColorSelected, for: .selected)
    }
    
    // Configurando o botao para quando ele nao estiver selecionado
    private func setDeselected() {
        // Mudando o estilo da borda
        border.lineDashPattern = [4, 4]
        border.strokeColor = borderColorDeselected.cgColor
        
        // Mudando o estilo do texto
        self.setTitle(deselectedText, for: .normal)
        self.setTitleColor(textColorDeselected, for: .normal)
    }
    
    private func setDisabled() {
        // Mudando o estilo da borda
        border.lineDashPattern = nil
        border.strokeColor = borderColorDisabled.cgColor

        
        // Mudando o estilo do texto
        self.setTitle(disabledText, for: .disabled)
        self.setTitleColor(textColorDisabled, for: .disabled)
    }
    
    
    // MARK: - Actions
    @objc private func onPress() {
        print("Button pressed")
        
        // Mundando o state atual do botao
        isSelected = !isSelected
    }
}

