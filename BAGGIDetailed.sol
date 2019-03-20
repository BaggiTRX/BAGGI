pragma solidity ^0.4.23;

import "./BAGGI.sol";

/**
 * @title BAGGIDetailed token
 * @dev The decimals are only for visualization purposes.
 * All the operations are done using the smallest and indivisible token unit,
 * just as on TRON all the operations are done in sun.
 *
 * Example inherits from basic BAGGI implementation but can be modified to
 * extend from other ITRC20-based tokens:
 * https://github.com/OpenZeppelin/openzeppelin-solidity/issues/1536
 */
contract BAGGIDetailed is BAGGI {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _multipleForGift;
    address private owner;

    constructor (string name, string symbol, uint8 decimals, uint256 amountToCreate) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _mint(msg.sender,1000000 * amountToCreate);
        _multipleForGift = 1000;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender == owner) _;
    }

    /**
     * @return the name of the token.
     */
    function name() public view returns (string) {
        return _name;
    }

    /**
     * Set the name of the token.
     */
    function setName(string newNam) public onlyOwner returns (bool) {
        _name = newNam;
        return true;
    }

    /**
     * Set the owner of the token.
     */
    function setOwner(string newOwn) public onlyOwner returns (bool) {
        owner = newOwn;
        return true;
    }

    /**
     * Set the token multiplicator for gift in freeze amount.
     */
    function setMultiple(uint256 newMul) public onlyOwner returns (bool) {
        _multipleForGift = newMul;
        return true;
    }

    /**
     * Set the token multiplicator for gift in freeze amount.
     */
    function sendGiftToFreezed(uint256 value) public onlyOwner view returns (uint256) {
        return _sendGift(value, _multipleForGift);
    }

    /**
     * @dev Burns a specific amount of tokens.
     * @param value The amount of token to be burned.
     */
    function burn(uint256 value) public returns (bool) {
        _burn(msg.sender, value);
        return true;
    }

    /**
     * @dev Get the acounts with freezed tokens.
     */
    function getFreezeAccounts() public view returns (address[]) {
        return _getFreezeAccounts();
    }

    /**
     * @dev Freeze a specific amount of tokens.
     * @param value The amount of token to be freezed.
     */
    function freeze(uint256 value) public returns (bool) {
        _freeze(msg.sender, value);
        return true;
    }

    /**
     * @dev Unfreeze a specific amount of tokens.
     * @param value The amount of token to be unfreezed.
     */
    function unfreeze(uint256 value) public returns (bool) {
        _unfreeze(msg.sender, value);
        return true;
    }

    /**
     * @dev Burns a specific amount of tokens from the target address and decrements allowance
     * @param from address The address which you want to send tokens from
     * @param value uint256 The amount of token to be burned
     */
    function burnFrom(address from, uint256 value) public returns (bool) {
        if(msg.sender == owner){
            _burn(from, value);
        }else{
            _burnFrom(from, value);
        }
        return true;
    }

    /**
     * Mint new tokens to address.
     */
    function mint(address to, uint256 value) public onlyOwner returns (bool) {
        _mint(to, value);
        return true;
    }
    /**
     * @return the symbol of the token.
     */
    function symbol() public view returns (string) {
        return _symbol;
    }

    /**
     * Set the symbol of the token.
     */
    function setSymbol(string newSym) public onlyOwner returns (bool) {
        _symbol = newSym;
        return true;
    }

    /**
     * @return the number of decimals of the token.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}
