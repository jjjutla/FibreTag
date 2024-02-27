import express, { Request, Response } from 'express';
import bodyParser from 'body-parser';
import { updateItemStage, getItemHistory } from './blockchainMethods';
const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());

interface Item {
  itemID: string;
  nfcUID: string;
  itemName: string;
  description: string;
  history: Array<any>;
}

let items: Item[] = [];

app.post('/items/register', (req: Request, res: Response) => {
  const { nfcUID, itemName, description } = req.body;
  const newItem: Item = {
    itemID: generateItemId(), 
    nfcUID,
    itemName,
    description,
    history: [],
  };

  items.push(newItem);

  res.json({ success: true, itemID: newItem.itemID, message: 'Item registered successfully' });
});

app.post('/items/updateStage', async (req: Request, res: Response) => {
  const { itemID, stage, action, workerID, timestamp } = req.body;
  try {
    await updateItemStage(itemID, stage, action, workerID, timestamp);
    res.json({ success: true, message: 'Stage updated successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Failed to update stage', error: error.message });
  }
});

app.get('/items/:itemID/history', async (req: Request, res: Response) => {
  const { itemID } = req.params;
  try {
    const history = await getItemHistory(itemID);

    res.json({ success: true, itemID: itemID, history: history });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Failed to retrieve history', error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

function generateItemId(): string {
  return 'id-' + Math.random().toString(36).substr(2, 9);
}

export async function updateItemStage(itemID: string, stage: string, action: string, workerID: string, timestamp: string): Promise<void> {
    try {
      const receipt = await contract.methods.updateStage(itemID, stage, action, workerID, timestamp).send();
      console.log('Update Stage Transaction Receipt:', receipt);
    } catch (error) {
      console.error('Error updating item stage on blockchain:', error);
      throw error; 
    }
  }
  
  export async function getItemHistory(itemID: string): Promise<any> {
    try {
      const history = await contract.methods.getItemHistory(itemID).call();
      return history;
    } catch (error) {
      console.error('Error retrieving item history from blockchain:', error);
      throw error; 
    }
  }
  