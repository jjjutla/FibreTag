import React from "react"
import { Routes, Route } from "react-router-dom"
import SubscriptionsPending from '../../Subscriptions/Pending'
import Homepage from '../../Homepage'

export default function LoggedIn() {
  return (
    <Routes>
      <Route path="/" element={<Homepage />} />
      <Route path="/success/:subscriptionId" element={<SubscriptionsPending />} />
    </Routes>
  )
}

