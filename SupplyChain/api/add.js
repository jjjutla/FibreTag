const { addManufacturingStage } = require('../interact.js');

module.exports = async (req, res) => {
    try {
        const stageName = req.body.name; 
        
        if (!stageName || typeof stageName !== 'string') {
            return res.status(400).send('Invalid name provided.');
        }

        await addManufacturingStage(6, stageName);
        res.send({ success: true, message: 'Stage added successfully!' });
    } catch (error) {
        console.error("Error in /add:", error);
        res.status(500).send('Error adding stage.');
    }
};
