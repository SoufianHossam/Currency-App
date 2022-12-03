//
//  CurrencyConverterViewController.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 02/12/2022.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    @IBOutlet weak var fromButton: UIButton!
    
    private let listViewController = ListViewController()
    
    let list = ["HUF", "NOK", "PLN", "VUV", "BWP", "XDR", "UAH", "TZS", "ANG", "BTC", "BIF", "SGD", "XAF", "XAU", "AOA", "TOP", "MWK", "OMR", "ISK", "BOB", "LTL", "AZN", "LSL", "PYG", "IRR", "SDG", "USD", "WST", "HTG", "SLL", "JOD", "STD", "LBP", "PHP", "PEN", "JMD", "BBD", "AUD", "ZMK", "MMK", "KPW", "CHF", "KYD", "FKP", "AWG", "RWF", "TJS", "EGP", "CAD", "KRW", "COP", "BTN", "GIP", "HKD", "MYR", "DZD", "BZD", "CVE", "SLE", "IDR", "TTD", "NPR", "HNL", "BDT", "UZS", "CUC", "INR", "UGX", "NAD", "FJD", "SCR", "AMD", "PAB", "ETB", "MNT", "MZN", "BYR", "TMT", "RON", "GEL", "ILS", "SBD", "TRY", "BYN", "CRC", "PKR", "HRK", "MUR", "ZWL", "ERN", "MXN", "LVL", "AED", "DKK", "LAK", "MAD", "SYP", "RUB", "SRD", "VND", "SAR", "AFN", "NGN", "GMD", "SHP", "BAM", "MVR", "CNY", "UYU", "EUR", "ZAR", "SVC", "CUP", "MRO", "LRD", "ALL", "XPF", "SZL", "THB", "SEK", "NZD", "DJF", "XAG", "GYD", "MKD", "LYD", "IMP", "ZMW", "GTQ", "NIO", "MOP", "CLP", "GGP", "GNF", "GBP", "BSD", "SOS", "KMF", "VEF", "KWD", "RSD", "JPY", "BGN", "KES", "BRL", "ARS", "JEP", "DOP", "KHR", "CZK", "BMD", "YER", "GHS", "KZT", "CDF", "KGS", "TWD", "BND", "IQD", "MGA", "QAR", "LKR", "CLF", "TND", "BHD", "MDL", "XOF", "XCD", "PGK"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewController.items = list.sorted()
        listViewController.didSelectItem = { item in
            print(item)
        }
    }

    @IBAction func fromButtonAction(_ sender: UIButton) {
        
        
        present(listViewController, animated: true)
    }

}

