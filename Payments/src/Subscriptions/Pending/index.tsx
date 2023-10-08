import React, { useEffect, useState } from 'react'
import { useParams, Link } from 'react-router-dom'
import { Row, Col, Alert, Spin, Result, Button } from 'antd'
import idToTokenId from '../../modules/idToTokenId'
import { useContract, useChainState } from '@vechain.energy/use-vechain'
import { ContractAddress, ABI } from '../../modules/constants'

export default function SubscriptionsPending() {
  const params = useParams()
  const [tokenId, setTokenId] = useState<string>('')
  const [tokenExists, setTokenExists] = useState<boolean>(false)
  const [error, setError] = useState<string>('')
  const { ownerOf } = useContract(ContractAddress, ABI)
  const { head } = useChainState()

  useEffect(() => {
    if (params?.subscriptionId === undefined) {
      return setError('Missing subscriptionId')
    }

    idToTokenId(params.subscriptionId)
      .then(tokenId => setTokenId(tokenId))
      .catch(() => { })
  }, [params?.subscriptionId])

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
            title="Subscription Activated"
            subTitle={<>Your subscription with id {params.subscriptionId} has been activated.</>}
            extra={[
              <Link to='/'><Button type="primary" key="list">Go to your subscriptions</Button></Link>
            ]}
          />
        }

        {!tokenExists &&
          <Result
            status="info"
            title="Subscription Pending"
            subTitle={<>Your subscription with id {params.subscriptionId} is currently been processed, please wait a moment.</>}
          />}
        <Spin spinning={!tokenExists} tip='Processing Subscription…' />
      </Col>
    </Row>
  )
}