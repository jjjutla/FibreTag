import { Row, Col } from 'antd'
import { Link } from 'react-router-dom'
import { useAccount } from '@vechain.energy/use-vechain'
import React from 'react'

export default function MenuLoggedOut() {
  const { connect } = useAccount()

  const handleConnect = async () => connect()
  
  return (
    <Row gutter={[32, 32]}>
      <Col span={24}>
        <Link to='/'>Home</Link>
      </Col>
      <Col span={24}>
        <Link to='/' onClick={handleConnect}>Sign In</Link>
      </Col>
    </Row>
  )
}