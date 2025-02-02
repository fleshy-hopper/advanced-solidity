// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 在Solidity中，引用类型包括结构体（struct）、数组（array）和映射（mapping）
// 与值类型不同，引用类型在赋值时不会直接复制值，而是创建一个指向原数据的引用，这样可以避免对大型数据的多次拷贝，节省 Gas

// memory（内存）数据仅在函数调用期间存在，函数调用结束后自动释放，用于局部变量，不能用于外部调用
// storage（存储）数据存储在合约的持久化存储中，状态变量默认存储在这里，只要合约存在，数据就一直保存在区块链上
// calldata（调用数据）用于存储函数参数的特殊数据位置，是一个不可修改的、非持久的存储区域，通常用于外部函数调用时的参数传递

// 如果可能，尽量使用calldata来存储数据，因为它既节省Gas，又确保数据不可修改
// 使用memory来存储临时数据，以减少合约的持久化存储开销
// 使用storage来存储需要长期保存的数据，但要注意其较高的Gas消耗

contract ReferenceType {
    uint[] public data;

    function updateData(uint[] memory newData) public {
        data = newData;
    }

    function getData() public view returns (uint[] memory) {
        return data;
    }

    function modifyStorageData(uint index, uint value) public {
        require(index < data.length, "Index out of length");
        data[index] = value;
    }

    function modifyMemoryData(uint[] memory memData) public pure returns (uint[] memory) {
        if (memData.length > 0) {
            memData[0] = 999;
        }
        return memData;
    }
}