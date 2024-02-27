import React, { useEffect, useState } from 'react'
import { useParams, Link } from 'react-router-dom'
import { Row, Col, Alert, Spin, Result, Button } from 'antd'
import idToTokenId from '../../modules/idToTokenId'
import { useContract, useChainState } from '@vechain.energy/use-vechain'
import { ContractAddress, ABI } from '../../modules/constants'

export default function paymentsPending() {
  const params = useParams()
  const [tokenId, setTokenId] = useState<string>('')
  const [tokenExists, setTokenExists] = useState<boolean>(false)
  const [error, setError] = useState<string>('')
  const { ownerOf } = useContract(ContractAddress, ABI)
  const { head } = useChainState()

  useEffect(() => {
    if (params?.paymentId === undefined) {
      return setError('Missing paymentId')
    }

    idToTokenId(params.paymentId)
      .then(tokenId => setTokenId(tokenId))
      .catch(() => { })
  }, [params?.paymentId])

  useEffect(() => {
    if (!tokenExists && ownerOf) {
      ownerOf(tokenId)
        .then(owner => setTokenExists(!!owner))
        .catch(() => { })
    }
  }, [head, tokenExists, ownerOf])

  return (
    <Row gutter={[32, 32]}>
      {!!error && <Col span={24}><Alert message={error} type="error" /></Col>}
      <Col span={24} align='center'>
        {tokenExists &&
          <Result
            status="success"
            title="payment Activated"
            subTitle={<>Your payment with id {params.paymentId} has been activated.</>}
            extra={[
              <Link to='/'><Button type="primary" key="list">Go to your payments</Button></Link>
            ]}
          />
        }

        {!tokenExists &&
          <Result
            status="info"
            title="payment Pending"
            subTitle={<>Your payment with id {params.paymentId} is currently been processed, please wait a moment.</>}
          />}
        <Spin spinning={!tokenExists} tip='Processing Payment...' />
      </Col>
    </Row>
  )
}