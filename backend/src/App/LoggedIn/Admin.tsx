import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Table } from 'antd';
import { Line } from '@ant-design/charts';
import { MapContainer, TileLayer, Circle } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';

const Admin = () => {
  const [data, setData] = useState([]); 
  const [chartData, setChartData] = useState([]);
  const [locations, setLocations] = useState([]); 

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get('API_ENDPOINT');
        const processedData = processResponseData(response.data);
        setData(processedData.tableData);
        setChartData(processedData.chartData);
        setLocations(processedData.mapLocations);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  const processResponseData = (responseData) => {
    return {
      tableData: responseData.items, 
      chartData: generateChartData(responseData.items), 
      mapLocations: generateMapLocations(responseData.items),
    };
  };

  const generateChartData = (items) => {
    return items.map(item => ({
      date: item.date, 
      value: item.transactions
    }));
  };
  
  const generateMapLocations = (items) => {
    return items.map(item => ({
      lat: item.latitude, 
      lng: item.longitude, 
      productName: item.name 
    }));
  };
  
  const columns = [
    {
      title: 'Product Name',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: 'Store',
      dataIndex: 'store',
      key: 'store',
    },
    {
      title: 'Order Received',
      dataIndex: 'order_recieved',
      key: 'order_recieved',
    },
    {
      title: 'Garments Produced',
      dataIndex: 'garments_produced',
      key: 'garments_produced',
    },
    {
      title: 'Prepared for Delivery',
      dataIndex: 'prepared_for_delivery',
      key: 'prepared_for_delivery',
    },
    {
      title: 'Out for Delivery',
      dataIndex: 'out_for_delivery',
      key: 'out_for_delivery',
    },
    {
      title: 'Verified by FibreTag',
      dataIndex: 'verified_by_fibretag',
      key: 'verified_by_fibretag',
    },
    {
      title: 'Status',
      dataIndex: 'status',
      key: 'status',
    },
  ];

  const config = {
    data: chartData,
    xField: 'date',
    yField: 'transactions',
    point: {
      size: 5,
      shape: 'diamond',
    },
  };

  const mapCenter = [51.505, -0.09];
  const zoomLevel = 2; 

  return (
    <div>
      <h2>Transaction Data</h2>
      <Table columns={columns} dataSource={data} />

      <div style={{ display: 'flex', justifyContent: 'space-between', margin: '20px 0' }}>
        <div style={{ width: '48%' }}>
          <h2>Transactions Over Time</h2>
          <Line {...config} style={{ height: '400px' }} />
        </div>

        <div style={{ width: '48%' }}>
          <h2>World Map</h2>
          <MapContainer center={mapCenter} zoom={zoomLevel} style={{ height: '400px', width: '100%' }}>
            <TileLayer
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
              attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            />
            {locations.map(location => (
              <Circle
                key={location.productName}
                center={[location.lat, location.lng]}
                radius={50000}
                color="red"
              />
            ))}
          </MapContainer>
        </div>
      </div>
    </div>
  );
};

export default Admin;
