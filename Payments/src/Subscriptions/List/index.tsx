import React, { useEffect, useState, useCallback } from 'react'
import { Link } from 'react-router-dom'
import { Row, Col, Alert, Spin, Button, Typography, Descriptions, Modal, Form, Input } from 'antd'
import { WalletOutlined as IconTransfer } from '@ant-design/icons'
import { useContract, useAccount } from '@vechain.energy/use-vechain'
import { ContractAddress, ABI } from '../../modules/constants'

type Token = {
  tokenId: string
  owner: string
}

const { Text, Paragraph } = Typography

export default function SubscriptionsList() {
  const [tokens, setTokens] = useState<Token[]>([])
  const [error, setError] = useState<string>('')
  const [loading, setLoading] = useState<boolean>(false)
  const [transferring, setTransferring] = useState<boolean>(false)
  const [displayTransfer, setDisplayTransfer] = useState<boolean>(false)
  const [selectedTokenId, setSelectedTokenId] = useState<string>('')
  const { account } = useAccount()
  const { balanceOf, tokenOfOwnerByIndex, ownerOf, transferFrom } = useContract(ContractAddress, ABI)

  const showTransfer = (tokenId: string) => () => {
    setDisplayTransfer(true)
    setSelectedTokenId(tokenId)
  }
  const hideTransfer = () => {
    setError('')
    setDisplayTransfer(false)
  }

  const updateTokenList = useCallback(async () => {
    if (!balanceOf || !tokenOfOwnerByIndex || !account) { return }

    setLoading(true)
    setError('')
    try {
      const tokenCount = await balanceOf(account)
      const tokens: Token[] = []
      for (let index = 0; index < tokenCount; index++) {
        const tokenId: string = await tokenOfOwnerByIndex(account, index)
        const owner: string = await ownerOf(tokenId)
        tokens.push({ tokenId, owner })
      }

      setTokens(tokens)
    }
    catch (err) {
      setError(err.message)
    }
    finally {
      setLoading(false)
    }
  }, [balanceOf, tokenOfOwnerByIndex])


  const handleTransfer = useCallback(async ({ address }) => {
    setTransferring(true)
    setError('')
    try {
      await transferFrom(account, address, selectedTokenId)
      await updateTokenList()
      hideTransfer()
    }
    catch (err) {
      setError(err.message)
    }
    finally {
      setTransferring(false)
    }
  }, [selectedTokenId, updateTokenList, transferFrom])



  useEffect(() => {
    updateTokenList()
  }, [updateTokenList])

  return (
    <Row gutter={[0, 32]}>
      {!!error && <Col span={24}><Alert message={error} type="error" /></Col>}

      <Col span={24}>
        <Spin spinning={loading}>
          {!tokens.length &&
            <div style={{ textAlign: 'center' }}>
              <Paragraph>
                <Link to={`https://${process.env.CHARGEBEE_HOSTED_ID}.chargebee.com/hosted_pages/checkout?subscription_items[item_price_id][0]=${process.env.CHARGEBEE_SUBSCRIPTION_ID}&subscription[cf_wallet_address]=${account}`}>
                  <Button size='large' type="primary">Subscribe Now</Button>
                </Link>
              </Paragraph>
              <Paragraph>
                Use <Text code>4111 1111 1111 1111</Text> as credit card number.
              </Paragraph>
            </div>
          }

          {tokens.length > 0 &&
            <Row gutter={[0, 32]}>
              {tokens.map(({ tokenId, owner }) => (
                <Col span={24} key={tokenId}>
                  <Descriptions column={1} labelStyle={{ minWidth: 148 }} size='small'>
                    <Descriptions.Item label="Subscription">{tokenId.slice(0, 8)}…{tokenId.slice(-8)}</Descriptions.Item>
                    <Descriptions.Item label="Paid by"><Typography.Link ellipsis href={`${process.env.NETWORK_EXPLORER_URL}/accounts/${owner}`} target="_blank" rel="noopener noreferrer">{owner.slice(0, 8)}…{owner.slice(-8)}</Typography.Link></Descriptions.Item>
                    <Descriptions.Item label="Options">
                      <Button style={{ opacity: 0.5 }} size='small' type='default' onClick={showTransfer(tokenId)}>transfer</Button>
                    </Descriptions.Item>
                  </Descriptions>
                </Col>
              ))
              }
            </Row >
          }


          <Modal
            open={displayTransfer}
            onCancel={hideTransfer}
            title='Transfer Subscription'
            footer={null}
            width={640}
          >
            <Form labelCol={{ span: 4, offset: 2 }} wrapperCol={{ span: 18 }} layout='horizontal' onFinish={handleTransfer}>
              <Form.Item name='address' label='Address' rules={[{ required: true, message: 'Please provide the new owner' }]}>
                <Input />
              </Form.Item>

              <Form.Item wrapperCol={{ span: 22, offset: 2 }}>
                <Button type='primary' htmlType='submit' loading={transferring} icon={<IconTransfer />}>Transfer Ownership</Button>
              </Form.Item>

              {!!error && <Col span={24}><Alert message={error} type="error" /></Col>}

            </Form>
          </Modal>
        </Spin>
      </Col>
    </Row>
  )
}