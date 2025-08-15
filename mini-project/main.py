import time
from web3 import Web3

RPC = "https://sei-mainnet.g.alchemy.com/v2/sIRvLRKMQE1CLLuV-HKa4"
POOL_CONFIGURATOR = Web3.to_checksum_address("0xf8157786e3401A7377BECb7Af288b84c8eE614E1")

w3 = Web3(Web3.HTTPProvider(RPC))


def find_init_selector() -> str:
    sig = ("initReserves((address,address,address,uint8,address,address,address,address,string,string,string,string,"
           "string,string,bytes)[])")
    return Web3.keccak(text=sig).hex()[:10]


def scan_block(block_number: int, init_selector: str):
    blk = w3.eth.get_block(block_number, full_transactions=True)
    hits = []
    for tx in blk.transactions:
        if not tx.to:
            continue
        if tx.to.lower() != POOL_CONFIGURATOR.lower():
            continue
        ipt = tx.input or ""
        if ipt.startswith(init_selector):
            hits.append({
                "txHash": tx.hash.hex(),
                "block": block_number,
                "from": tx["from"],
                "to": tx["to"],
            })
    return hits


if __name__ == "__main__":
    assert w3.is_connected(), "Web3 connection failed"

    init_selector = find_init_selector()
    print(f"[i] initReserves selector: {init_selector}")
    print(f"[i] Monitoring PoolConfigurator: {POOL_CONFIGURATOR}")

    N = 200
    tip = 118133645
    start = 117130643
    print(f"[i] Backfill scan from {start} to {tip}")
    for n in range(start, tip + 1):
        print(f"[i] Scanning block {n}...")
        for hit in scan_block(n, init_selector):
            print("[DETECTED initReserves]", hit)
