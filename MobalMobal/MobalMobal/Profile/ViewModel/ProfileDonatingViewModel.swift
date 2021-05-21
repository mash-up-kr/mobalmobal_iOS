//
//  ProfileDonatingViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Foundation

protocol ProfileDonatingViewModelDelegate: AnyObject {
    func setMyDonationUI(mydonate: Bool)
}
class ProfileDonatingViewModel {
    weak var delegate: ProfileDonatingViewModelDelegate?
    var myDonationData: MydonationPost? {
        didSet {
            delegate?.setMyDonationUI(mydonate: false)
        }
    }
    var myDonateData: Donate? {
        didSet {
            delegate?.setMyDonationUI(mydonate: true)
        }
    }
    func setMyDonationData(_ rowData: MydonationPost) {
        self.myDonationData = rowData
    }
    func setMyDonateData(_ rowData: Donate) {
        self.myDonateData = rowData
    }
    
    func getDonationImg(myDonate: Bool) -> String? {
        myDonate ? myDonateData?.post.postImage : myDonationData?.postImage
    }
    func getGoal(myDonate: Bool) -> Int? {
        myDonate ? myDonateData?.post.goal : myDonationData?.goal
    }
    func getTitle(myDonate: Bool) -> String? {
        myDonate ? makeTitle(myDonate: true) : makeTitle(myDonate: false)
    }
    func getDate(myDonate: Bool) -> Date? {
        myDonate ? myDonateData?.post.endAt : myDonationData?.endAt
    }
    func getCurrentAmount(myDonate: Bool) -> Int? {
        myDonate ? myDonateData?.post.currentAmount : myDonationData?.currentAmount
    }
    func makeTitle(myDonate: Bool) -> String? {
        if myDonate {
            if let description = myDonateData?.post.description,
               let title = myDonateData?.post.title { return "\(title)\n\(description)" }
        } else {
            if let description = myDonationData?.description ,
               let title = myDonationData?.title { return "\(title)\n\(description)" }
        }
        return nil
    }
}
