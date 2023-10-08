const { sellProduct } = require('../interact.js');

module.exports = async (req, res) => {
    try {
        const newAddress = req.body.address; 
        
        if (!newAddress || typeof newAddress !== 'string') {
            return res.status(400).send('Invalid address provided.');
        }

        await sellProduct(6, newAddress);
        res.send({ success: true, message: ' Sold!' });
    } catch (error) {
        console.error("Error in /sell:", error);
        res.status(500).send('Error selling.');
    }
};