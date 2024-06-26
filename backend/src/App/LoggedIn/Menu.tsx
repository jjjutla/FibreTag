import React from 'react'
import { Row, Col, Typography } from 'antd'
import { Link, useNavigate } from 'react-router-dom'
import { useAccount } from '@vechain.energy/use-vechain'

export default function MenuLoggedIn() {
  const { disconnect } = useAccount()
  const navigateTo = useNavigate()

  const handleDisconnect = async () => {
    await disconnect()
    navigateTo('/')
  }

  const handleManagepayment = async () => {
    let cbInstance = Chargebee.getInstance();
    var chargebeePortalInstance = cbInstance.createChargebeePortal()
    chargebeePortalInstance.open()
  }

  return (
    <Row gutter={[0, 10]}>
      <Col span={24}>
        <Link to='/'>My Payments</Link>
      </Col>
      <Col span={24}>
        <Link onClick={handleManagepayment} to='/'>Manage Payments</Link>
      </Col>
      <Col span={24}>
        <Link to='/' onClick={handleDisconnect}>Sign Out</Link><br />
      </Col>
    </Row >
  )
}