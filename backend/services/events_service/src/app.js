const express = require('express');
const bodyParser = require('body-parser');
const eventRoutes = require('./routes/eventRoutes');
const logger = require('./logger');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use('/events', eventRoutes);

app.listen(PORT, () => {
  logger.info(`Events service is running on port ${PORT}`);
});

module.exports = app;
