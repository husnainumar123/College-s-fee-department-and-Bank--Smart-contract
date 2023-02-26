
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0< 0.9.0;

contract FeeSection
{
 mapping(address=>uint)public students; ////To store the addresses and ethers of individuals who have submitted fee
 uint totalfee;  ////total fee collection
 address manager;


   constructor()////As manager will perform specific tasks so it is wise to declare it initially
{
    manager=msg.sender;
}
 function CheckManager()public view returns(address)
 {
     return manager;
 }


function SubmitFee()public payable ///function to collect fee one by one from different addresses
{
    require(msg.value>=10 ether,"minimum fee is 10 ethers");       ////minimum fee is 10 Ethers
    students[msg.sender]+=msg.value;
    totalfee+= msg.value;
    
    
}
////Manager will send all the collected money to bank account(other contract) using this function
function sendmoney(address payable _bank) public payable 
 {
        require(msg.sender==manager,"Only Manager is eligible to Transfer the money");
        _bank.transfer(totalfee);
        

    }


function TotalFee()public view returns(uint)
{   
    require(msg.sender==manager,"Only Manager can check total Fee");
    
    return totalfee;
    }

}


contract Bank
{
    address banker;

constructor()
{
   banker=msg.sender;

}
  receive() external payable {}

     function BankBalance()public view returns(uint)
     {   require(msg.sender==banker);                /////only Banker can check the Bank Balance
         return address(this).balance;
     }
     
}