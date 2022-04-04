import './ProvidingLiquidity.sol';

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
}

contract TestUniswapLiquidity{
     address private constant FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private constant ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    
    event Log(string message, uint256 val);

    function addLiquidity(address _tokenA, address _tokenB, uint256 _amountA, uint256 _amountB) external {
        IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
        IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);

        IERC20(_tokenA).approve(ROUTER, _amountA);
        IERC20(_tokenB).approve(ROUTER, _amountB);

         (uint amountA, uint amountB, uint liquidity) = IUniswapV2Router(ROUTER).addLiquidity(_tokenA, _tokenB, _amountA, _amountB, 1, 1, address(this), block.timestamp);

         emit Log("amountA", amountA);
         emit Log("amountB", amountB);
         emit Log("liquidity",liquidity);
    }

    function removeLiquidity(address _tokenA, address _tokenB) external {
       address pair = IUniswapV2Factory(FACTORY).getPair(_tokenA, _tokenB);

       uint256 liquidity = IERC20(pair).balanceOf(address(this));

       IERC20(pair).approve(ROUTER, liquidity);

      (uint256 amountA, uint256 amountB) = IUniswapV2Router(ROUTER).removeLiquidity(_tokenA, _tokenB, liquidity, 1, 1, address(this), block.timestamp);
      
       emit Log("amountA", amountA);
       emit Log("amountB", amountB);
    }

   

}



interface IUniswapV2Factory {
    function getPair(address token0, address token1) external view returns (address);
}