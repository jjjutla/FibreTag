import React from 'react';
import { Alert, Spin } from 'antd';
import { useAccount } from '@vechain.energy/use-vechain'
import LoggedOut from './LoggedOut/Routing';
import LoggedIn from './LoggedIn/Routing';

export function App() {
  const { account, error, isLoading } = useAccount()
  return (
    <Spin spinning={isLoading}>
      {!!error && <Alert message={error.message} type="error" />}
      {!account && <LoggedOut />}
      {!!account && <LoggedIn />}
    </Spin>
  )
}