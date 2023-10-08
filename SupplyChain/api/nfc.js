const { getHistory } = require('../interact.js');

app.post('/nfc', async (req, res) => {
    try {
        const Serial = req.body.serial; 
        
        if (!Serial || typeof Serial !== 'string') {
            return res.status(400).send('Invalid Serial provided.');
        }

        if (Serial === "04:56:BB:8F:78:00:00") {
            const history = await getHistory(6);
            res.send({ message: history });
        }
        else {
            res.send({ success: true, message: 'NFC tag no recognised!' });
        }
        
    } catch (error) {
        console.error("Error in /nfc:", error);
        res.status(500).send('Error reading NFC.');
    }
});