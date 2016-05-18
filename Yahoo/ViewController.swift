//
//  ViewController.swift
//  Yahoo
//
//  Created by Matt Deuschle on 5/17/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var manager = Manager()

    override func viewDidLoad() {
        super.viewDidLoad()

        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "www.yahoo.com": .PinCertificates(
                certificates: ServerTrustPolicy.certificatesInBundle(),
                validateCertificateChain: true,
                validateHost: true
            ),
        ]

        manager = Manager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )

//        withoutCertificate()
        withCertificate()
    }

    func withoutCertificate() {

        let url = NSURL(string: "https://www.yahoo.com")!

        Alamofire.request(.GET, url).response { request, response, data, error in

            guard let data = data where error == nil else {
                let err = error!.description
                print(err)
                return
            }

            let webText = String(data: data, encoding: NSUTF8StringEncoding)!
            print(webText)
        }
    }

    func withCertificate() {

        let url = NSURL(string: "https://www.yahoo.com")!

        manager.request(.GET, url).response { request, response, data, error in

            guard let data = data where error == nil else {
                let err = error!.description
                print(err)
                return
            }

            let webText = String(data: data, encoding: NSUTF8StringEncoding)!
            print(webText)
        }
    }
}

