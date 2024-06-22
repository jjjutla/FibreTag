import express, { Request, Response, NextFunction } from 'express';
import bodyParser from 'body-parser';
import jwt from 'jsonwebtoken';
import { updateItemStage, getItemHistory } from './blockchainMethods';
import https from 'https';
import fs from 'fs';
import { check, validationResult } from 'express-validator';

const app = express();
const port = process.env.PORT || 3000;

// Middleware for validating JWT
const authenticateJWT = (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;

  if (authHeader) {
    const token = authHeader.split(' ')[1];

    jwt.verify(token, SKEY, (err: any, user: any) => {
      if (err) {
        return res.sendStatus(403);
      }

      req.user = user;
      next();
    });
  } else {
    res.sendStatus(401);
  }
};

// Enable HTTPS
const privateKey = fs.readFileSync('path/to/your/private-key.pem', 'utf8');
const certificate = fs.readFileSync('path/to/your/certificate.pem', 'utf8');
const ca = fs.readFileSync('path/to/your/ca.pem', 'utf8');

const credentials = {
  key: privateKey,
  cert: certificate,
  ca: ca,
};

app.use(bodyParser.json());

interface Item {
  itemID: string;
  nfcUID: string;
  itemName: string;
  description: string;
  history: Array<any>;
}

let items: Item[] = [];

// API to register an item with validation and JWT authentication
app.post('/items/register', authenticateJWT, [
  check('nfcUID').isLength({ min: 1 }).withMessage('nfcUID is required'),
  check('itemName').isLength({ min: 1 }).withMessage('itemName is required'),
  check('description').isLength({ min: 1 }).withMessage('description is required'),
], (req: Request, res: Response) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

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

// API to update item stage with JWT authentication
app.post('/items/updateStage', authenticateJWT, [
  check('itemID').isLength({ min: 1 }).withMessage('itemID is required'),
  check('stage').isLength({ min: 1 }).withMessage('stage is required'),
  check('action').isLength({ min: 1 }).withMessage('action is required'),
  check('workerID').isLength({ min: 1 }).withMessage('workerID is required'),
  check('timestamp').isISO8601().withMessage('timestamp must be a valid ISO8601 date string'),
], async (req: Request, res: Response) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { itemID, stage, action, workerID, timestamp } = req.body;
  try {
    await updateItemStage(itemID, stage, action, workerID, timestamp);
    res.json({ success: true, message: 'Stage updated successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Failed to update stage', error: error.message });
  }
});

// API to get item history with JWT authentication
app.get('/items/:itemID/history', authenticateJWT, async (req: Request, res: Response) => {
  const { itemID } = req.params;
  try {
    const history = await getItemHistory(itemID);

    res.json({ success: true, itemID: itemID, history: history });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Failed to retrieve history', error: error.message });
  }
});

https.createServer(credentials, app).listen(port, () => {
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
