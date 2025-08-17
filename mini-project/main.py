from web3 import Web3
from eth_abi import decode as abi_decode  # (이 예제에선 토픽 2만 쓰므로 없어도 됨)

RPC = "https://<your-sei-evm-rpc>"  # pacific-1 EVM RPC
w3 = Web3(Web3.HTTPProvider(RPC))

TX_HASH = "0xb841865c0aa4146e8f68d4d0f1c31a5ee10fc91c6334e095d82eff19c2d8249f"  # 예시
# (선택) Pool 또는 PoolConfigurator 주소가 있다면 아래로 필터링 가능
POOL_ADDR = 0x80C4cdee95E52a8ad2C57eC3265Bea3A9c91669D

# keccak("ReserveInitialized(address,address,address,address,address)")
RESERVE_INIT_TOPIC0 = Web3.to_hex(
    Web3.keccak(text="ReserveInitialized(address,address,address,address,address)")
)

ERC20_MIN_ABI = [
    {"constant": True, "inputs": [], "name": "totalSupply", "outputs": [{"name": "", "type": "uint256"}],
     "type": "function"},
    {"constant": True, "inputs": [], "name": "decimals", "outputs": [{"name": "", "type": "uint8"}],
     "type": "function"},
]


def to_checksum(addr_hex):
    return Web3.to_checksum_address("0x" + addr_hex[-40:])


def find_a_tokens_from_tx(tx_hash):
    r = w3.eth.get_transaction_receipt(tx_hash)
    a_tokens = []
    for log in r["logs"]:
        # (선택) 특정 컨트랙트에서만 온 로그만 보려면:
        if POOL_ADDR and log["address"].lower() != POOL_ADDR:
            continue
        if len(log["topics"]) >= 3 and Web3.to_hex(log["topics"][0]) == RESERVE_INIT_TOPIC0:
            # topics[1] = asset (indexed), topics[2] = aToken (indexed)
            a_tok = to_checksum(log["topics"][2].hex())
            a_tokens.append(a_tok)
    return a_tokens


def read_total_supply(addr):
    c = w3.eth.contract(address=addr, abi=ERC20_MIN_ABI)
    supply = c.functions.totalSupply().call()
    try:
        dec = c.functions.decimals().call()
    except Exception:
        dec = 18  # fallback
    return supply, dec


def main():
    a_tokens = find_a_tokens_from_tx(TX_HASH)
    if not a_tokens:
        print("[!] No ReserveInitialized events found in this tx")
        return

    print(f"[+] Found {len(a_tokens)} aToken(s) in tx:")
    for a in a_tokens:
        supply, dec = read_total_supply(a)
        human = supply / (10 ** dec)
        print(f"  - aToken: {a} | totalSupply(raw)={supply} | decimals={dec} | totalSupply={human:g}")

        # ---- 임계값 체크 (예: 사람이 읽는 값 기준 100 이하) ----
        THRESHOLD_HUMAN = 100.0
        if human <= THRESHOLD_HUMAN:
            print(f"    -> ALERT: totalSupply <= {THRESHOLD_HUMAN}")
        else:
            print("    -> OK")


if __name__ == "__main__":
    main()
