const { getHistory } = require('../interact.js');

module.exports = async (req, res) => {
    try {
        const history = await getHistory(6);
        res.send({ message: history }); 
    } catch (error) {
        console.error("Error in /getHistory:", error);
        res.status(500).send('Error getting history.');
    }
};
