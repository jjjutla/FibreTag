import React from "react"
import { Routes, Route } from "react-router-dom"
import paymentsPending from '../../payments/Pending'
import Homepage from '../../Homepage'

export default function LoggedIn() {
  return (
    <Routes>
      <Route path="/" element={<Homepage />} />
      <Route path="/success/:paymentId" element={<paymentsPending />} />
    </Routes>
  )
}

