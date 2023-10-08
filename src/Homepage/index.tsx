import React from 'react'
import { Row, Col, Button } from 'antd'
import { useAccount } from '@vechain.energy/use-vechain'

export default function Page() {
  const { connect } = useAccount()
  const handleConnect = async () => connect()

  return (
    <Row gutter={[0, 32]}>
      <Col span={24}>
        <Button size='large' type='primary' block onClick={handleConnect}>sign in to subscribe</Button>
      </Col>
    </ Row>
  )
}