import React from "react";
import { Row, Col, Grid, Divider } from 'antd';
import { Routes, Route, useLocation } from "react-router-dom";
import paymentsList from '../../payments/List';
import paymentsPending from '../../payments/Pending';
import Menu from './Menu';
import Test from './Admin'; 

const { useBreakpoint } = Grid;

export default function LoggedIn() {
  const screens = useBreakpoint();
  const location = useLocation();

  const isTestRoute = location.pathname === '/dashboard';

  if (isTestRoute) {
    return <Test />;
  }

  return (
    <div style={{ maxWidth: 1200, margin: 'auto' }}>
      <Row gutter={[0, 64]} style={{ marginTop: screens.lg ? 96 : 0 }}>
        <Col xs={0} lg={8} align='right' style={{ marginTop: screens.lg ? 96 : 0, paddingRight: screens.lg ? 64 : 0 }}>
          <Menu />
        </Col>

        <Col xs={24} lg={16}>
          <Routes>
            <Route path="/" element={<paymentsList />} />
            <Route path="/success/:paymentId" element={<paymentsPending />} />
          </Routes>
        </Col>

        <Col xs={24} lg={0} align='center'>
          <Divider />
          <Menu />
        </Col>

      </Row>
    </div>
  )
}