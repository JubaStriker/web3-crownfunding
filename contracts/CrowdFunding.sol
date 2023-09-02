// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function createCampaign(
        address _owner,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        string memory _image
    ) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];
        // Check a condition before stepping forward
        require(
            campaign.deadline < block.timestamp,
            "The deadline should be date in fututre"
        );

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.deadline = _deadline;
        campaign.image = _image;
        campaign.description = _description;
        campaign.amountCollected = 0;
        campaign.target = _target;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donations.push(amount);
        campaign.donators.push(msg.sender);
    }

    function getDonators() {}

    function getCampaigns() {}
}
