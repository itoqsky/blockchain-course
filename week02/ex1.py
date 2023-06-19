from flask import Flask, request, jsonify
import hashlib
import time

app = Flask(__name__)

max_nonce = 2 ** 32  # 4 billion

def proof_of_work(header, difficulty_bits):
    target = 2 ** (256 - difficulty_bits)
    for nonce in range(max_nonce):
        hash_result = hashlib.sha256((str(header) + str(nonce)).encode()).hexdigest()

        if int(hash_result, 16) < target:
            return hash_result, nonce

    return None

@app.route('/pow', methods=['POST'])
def perform_pow():
    difficulty_bits = request.json.get('difficulty_bits')

    nonce = 0
    hash_result = ''

    start_time = time.time()
    new_block = 'test block with transactions' + hash_result
    result = proof_of_work(new_block, difficulty_bits)
    end_time = time.time()

    elapsed_time = end_time - start_time

    response = {
        'hash_result': result[0] if result else None,
        'nonce': result[1] if result else None,
        'elapsed_time': elapsed_time
    }

    return jsonify(response)

if __name__ == '__main__':
    app.run()

# 2) difficulty_bits, max_nonce, hash algorithm.