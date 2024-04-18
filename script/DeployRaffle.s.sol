// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {HelperConfig} from "./HelperConfig.s.sol";
import {Raffle} from "../src/Raffle.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployRaffle is Script {

    function run() external returns(Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig(); // this comes with our mocks!
        (
             uint64 subscriptionId,
            bytes32 gasLane,
            uint256 automationUpdateInterval,
            uint256 raffleEntranceFee,
            uint32 callbackGasLimit,
            address vrfCoordinatorV2,
            address link,
            uint256 deployerKey
        ) = helperConfig.activeNetworkConfig();

        vm.startBroadcast(deployerKey);
        Raffle raffle = new Raffle(
            subscriptionId,
            gasLane,
            automationUpdateInterval,
            raffleEntranceFee,
            callbackGasLimit,
            vrfCoordinatorV2
        );
        vm.stopBroadcast();

        return (raffle, helperConfig);
    }
}
