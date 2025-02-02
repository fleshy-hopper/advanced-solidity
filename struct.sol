// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 任务 1：创建一个合约，定义一个结构体用于存储产品信息，包括产品 ID、名称、价格和库存，实现增加、修改和查询产品信息的功能
// 任务 2：扩展合约，定义一个结构体用于存储订单信息，并实现订单的创建和查询功能，考虑如何设计结构体以便有效存储和访问订单数据
// 任务 3：设计一个用户管理合约，使用结构体记录用户的个人信息、余额及交易历史，探索如何优化结构体的设计以减少存储成本

contract StructExample {
    struct Product {
        uint id;
        string name;
        uint price;
        uint stock;
    }

    mapping(uint => Product) products;
    uint public productCount;

    function getProduct(uint productId) public view returns (string memory, uint, uint) {
        Product storage product = products[productId];
        return (product.name, product.price, product.stock);
    }

    function addProduct(string memory name, uint price, uint stock) public {
        productCount++;
        products[productCount] = Product(productCount, name, price, stock);
    }

    function updateProductStock(uint _productId, uint newStock) public {
        Product storage currProduct = products[_productId];
        currProduct.stock = newStock;
    }
}