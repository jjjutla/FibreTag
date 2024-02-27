import React from "react";
import { createRoot } from "react-dom/client";
import { App } from "./App";
import { BrowserRouter } from "react-router-dom";
import { VeChainProvider } from '@vechain.energy/use-vechain'

const container = document.getElementById("app");
if (container !== null) {
  const root = createRoot(container)

  root.render(
    <VeChainProvider
      config={{
        node: process.env.NETWORK_NODE,
        network: process.env.NETWORK_TYPE
      }}
      options={{
        delegate: process.env.VEN_DELEGATE_URL,
        delegateTest: String(process.env.VEN_DELEGATE_URL).concat('/test')
      }}
    >
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </VeChainProvider>
  )
}