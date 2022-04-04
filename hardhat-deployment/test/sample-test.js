const { expect } = require("chai");
const { ethers } = require("hardhat");
const BN = require('bn.js');

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

// describe('Swap', () => {
//  const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
//  const WBTC = "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599";
//  const DAI_WHALE = "0x73264d8be9eddfcd25e4d54bf1b69828c9631a1c";
//  const AMOUNT_IN = '100000000';
//  const AMOUNT_OUT_MIN = '1';
//  const TOKEN_IN = DAI;
//  const TOKEN_OUT = WBTC;
//  account_one = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
//  account_two = "0x70997970c51812dc3a010c7d01b50e0d17dc79c8";

//   beforeEach(async () => {
//     tokenIn = await IERC20.at(TOKEN_IN);
//     tokenOut = await IERC20.at(TOKEN_OUT);
//     const TestUniswap = await ethers.getContractFactory("TestUniswap");
//     const testUniswapSwap = await TestUniswap.deploy();
//     await testUniswapSwap.deployed();
//     // make sure WHALE has enough ETH to send tx
//     // await sendEther(web3, accounts[0], WHALE, 1);
//     await tokenIn.approve(testUniswap.address, AMOUNT_IN, { from: account_one });
//   });

//  it('should swap', async() => {
//   const [owner, addr1, addr2, addr3] = await ethers.getSigners();
//   await testUniswap.swap(tokenIn.address, tokenOut.address, AMOUNT_IN, AMOUNT_OUT_MIN, account_two, {from: account_one});
//   expect(account_two)
//  })
// })

const sleep = (milliseconds) => {
  return new Promise(resolve => setTimeout(resolve, milliseconds))
}

describe("Vulnerable", function () {
  it("Bob should be able to hack Alice", async function () {
       let Vulnerable,
         vulnerable,
         Attack,
         attack,
         signers,
         Alice,
         Bob,
         overrides,
         AliceBalance,
         BobBalance;
     signers = await ethers.getSigners();
     Alice = signers[0];
     Bob = signers[1];

     console.log('I am poor Alice and I am deploying my vulnerable contract')
     Vulnerable = await ethers.getContractFactory("Vulnerable")
     overrides = { value: ethers.utils.parseEther("0.000000001") };
     vulnerable = await Vulnerable.deploy(overrides)
      console.log(
        "The vulnerable contract was deployed to " + vulnerable.address
      );
      console.log("-----------------------------------------------");
      
        console.log("I am malicious Bob and I am deploying my attack contract:")
        Attack = await ethers.getContractFactory("Attack");
        attack = await Attack.connect(Bob).deploy(vulnerable.address)
         console.log("The attack contract was deployed to " + attack.address);
         console.log("-----------------------------------------------");

         AliceBalance = await vulnerable.getBalance()
         BobBalance = await attack.getBalance();
         console.log("Alice has " + AliceBalance + " MATICs");
         console.log("Bob has " + BobBalance + " MATICs");
         console.log("-----------------------------------------------");

         console.log("Bob is about to hack(), he convinced Alice to call this function!")
         await attack.connect(Alice).hack()
         console.log("-----------------------------------------------");

         console.log("The hack is over.")
         await sleep(20000)
         AliceBalance = await vulnerable.getBalance()
         BobBalance = await attack.getBalance()
         console.log("Alice has " + AliceBalance + " MATICs")
         console.log("Bob has " + BobBalance + " MATICs")
  });
});