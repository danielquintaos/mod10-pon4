const { createLogger, format, transports } = require('winston');
const APILoggingTransport = require('./apiTransport');

const logger = createLogger({
  level: 'info',
  format: format.combine(
    format.timestamp(),
    format.json()
  ),
  defaultMeta: { service: 'events-service' },
  transports: [
    new transports.File({ filename: 'events-service.log' }),
    new transports.Console(),
    new APILoggingTransport({ apiUrl: 'http://localhost:8002/logs/' })
  ],
});

module.exports = logger;
