import config from './constants'
const { VEN_API_KEY, VEN_ENDPOINT_URL, CONTRACT_ADDRESS } = config

export async function onRequest({ request }): Promise<Response> {
  const payload = await request.json()

  const tokenId = await idToTokenId(payload.content.subscription.id)
  const address = payload.content.subscription.cf_wallet_address
  console.log({ payload, tokenId, address })


  if ('subscription_created' === payload.event_type) {
    const tokenId = await idToTokenId(payload.content.subscription.id)
    const address = payload.content.subscription.cf_wallet_address
    const result = await mintToken(address, tokenId)
    const text = await result.text()
    return new Response(text)
  }

  if (['subscription_cancelled', 'subscription_deleted'].includes(payload.event_type)) {
    const tokenId = await idToTokenId(payload.content.subscription.id)
    const result = await burnToken(tokenId)
    const text = await result.text()
    return new Response(text)
  }

  return new Response('Not supported', { status: 400 })
}


export async function mintToken(address: string, tokenId: string): Promise<any> {
  return await fetch(VEN_ENDPOINT_URL, {
    method: 'POST',
    headers: {
      'x-api-key': VEN_API_KEY,
      'content-type': 'application/json'
    },
    body: JSON.stringify({
      clauses: [
        {
          "to": CONTRACT_ADDRESS,
          "abi": {
            "inputs": [
              {
                "internalType": "address",
                "name": "to",
                "type": "address"
              },
              {
                "internalType": "uint256",
                "name": "tokenId",
                "type": "uint256"
              }
            ],
            "name": "safeMint",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          "args": [address, tokenId]
        }
      ]
    })
  })
}

export async function burnToken(tokenId: string): Promise<any> {
  return await fetch(VEN_ENDPOINT_URL, {
    method: 'POST',
    headers: {
      'x-api-key': VEN_API_KEY,
      'content-type': 'application/json'
    },
    body: JSON.stringify({
      clauses: [
        {
          "to": CONTRACT_ADDRESS,
          "abi": {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "tokenId",
                "type": "uint256"
              }
            ],
            "name": "burn",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          "args": [tokenId]
        }
      ]
    })
  })
}


export async function idToTokenId(id: string): Promise<string> {
  const encodedText = new TextEncoder().encode(id)
  const digest = await crypto.subtle.digest({ name: 'SHA-256' }, encodedText)
  const hashArray = Array.from(new Uint8Array(digest));
  const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('')

  return BigInt(`0x${hashHex}`).toString()
}
