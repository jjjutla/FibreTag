export default async function idToTokenId(id: string): Promise<string> {
  const encodedText = new TextEncoder().encode(id)
  const digest = await crypto.subtle.digest({ name: 'SHA-256' }, encodedText)
  const hashArray = Array.from(new Uint8Array(digest));
  const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('')

  return BigInt(`0x${hashHex}`).toString()
}