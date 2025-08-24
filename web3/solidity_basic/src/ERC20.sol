pragma solidity ^0.8.13;

contract ERC20 {
    string private _name = "HoYa";
    string private _symbol = "HY";
    uint8 private _decimals = 18;
    uint256 private _totalSupply;
    address private _admin;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    modifier onlyAdmin() {
        require(msg.sender == _admin, "Only admin can call this function");
        _;
    }

    constructor() {
        _admin = msg.sender;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _validateTransfer(to, amount);

        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        _validateTransferFrom(from, to, amount);

        _allowances[from][msg.sender] -= amount;
        _balances[from] -= amount;
        _balances[to] += amount;
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Invalid address");
        _allowances[msg.sender][spender] = amount;
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function mint(address to, uint256 amount) public onlyAdmin {
        require(to != address(0), "Invalid recipient");
        _balances[to] += amount;
        _totalSupply += amount;
    }

    function burn(uint256 amount) public onlyAdmin {
        require(_balances[msg.sender] >= amount, "Insufficient balance to burn");
        _balances[msg.sender] -= amount;
        _totalSupply -= amount;
    }

    function _validateTransfer(address to, uint256 amount) private view {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        require(to != address(0), "Invalid address");
    }

    function _validateTransferFrom(address from, address to, uint256 amount) private view {
        require(_balances[from] >= amount, "Insufficient balance");
        require(_allowances[from][msg.sender] >= amount, "Allowance exceeded");
        require(to != address(0), "Invalid address");
    }
}
