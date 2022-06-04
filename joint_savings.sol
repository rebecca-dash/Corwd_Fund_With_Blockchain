pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    function withdraw(uint amount, address payable recipient) public {

        /*
        check validity of account
        */
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        /*
        check for insufficient funds
        */
        require(contractBalance > amount, "Insufficient funds!");

        /*
        check last withdraw
        */
        if (lastToWithdraw != recipient)
        {
            lastToWithdraw = recipient;
        }
        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
         recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        //reflects the new balance of the contract
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {

        contractBalance = address(this).balance;
    }

    function setAccounts(address payable account1, address payable account2) public{

        // Set the account values
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    function() external payable {}
}
