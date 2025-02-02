// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Functional {
    // 函数选择器
    // 通过对函数签名进行Keccak256哈希计算，并截取前四个字符生成唯一标识符
    // 用于识别和调用特定函数
    // bytes4 selector = bytes4(keccak256("functionName(uint256)"));
    // Solidity内置获取函数选择器的方法
    // bytes4 selector = this.functionName.selector;

    // 函数类型变量的声明与使用
    // 函数类变量可以存储合约内函数变量的指针
    function a(uint) external returns (uint) {}
    // 函数类变量的传递可能受ABI编码器的限制，通常使用函数选择器替代
    
    // 虽然函数类变量可以作为参数传递，但为了避免ABI限制，通常使用函数选择器间接调用
    // 函数类型变量不能直接作为参数进行传递和返回，通常需要配合低级call来实现动态调用
    function select(bytes4 selector, uint x) external returns (uint) {
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success, "Function call failed.");
        uint z;
        z = abi.decode(data, (uint));
        return z;
    }

    // 函数类型作为返回值
    // Solidity不支持直接返回函数类型，但可以通过返回函数选择器或接口实现类似效果
    function getSelector() external pure returns (bytes4) {
        return this.a.selector;
    }

    // eg
    function execute(bytes4 selector, uint x) external returns (uint z) {
        // call会改变函数状态，不能使用view或pure等关键字
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success, "Call failed");
        z = abi.decode(data, (uint));
    }
}