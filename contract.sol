// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

// Solidity中使用contract关键字定义合约，类似于其他语言中的类
contract Hello {
    function sayHi() public {
        // 合约中的成员函数
    }

    // 在合约内部可以使用this关键字表示当前合约
    // 并可以将其显示转换为address类型
    function getAddress() public view returns (address) {
        return  address(this); // 返回当前合约地址
    }

    // 使用selfdestruct函数销毁合约，并同事将以太币发送到指定地址
    function destoryContract(address payable recipient) public {
        // 销毁合约并发送以太币
        selfdestruct(recipient);
    }

    //  Solidity 0.6版本开始，可以通过type(C)获取合约的类型信息
    function getContractInfo() public pure returns (string memory, bytes memory, bytes memory) {
        // type(Hello).name: 获取合约的名字
        // type(Hello).creationCode: 获取创建合约的字节码
        // type(Hello).runtimeCode: 获取合约运行时的字节码
        return (type(Hello).name, type(Hello).creationCode, type(Hello).runtimeCode);
    }

    receive() external payable {
        // 可支付退回函数
    }
}

// 区分合约地址与外部账号地址
contract AddressChecker {
    // 使用EVM操作码EXTCODESIZE
    // 通过extcodesize操作码判断一个地址是否为合约地址
    function isContract(address addr) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(addr) }
        return  size > 0;
    }
}