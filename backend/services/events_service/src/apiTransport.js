const Transport = require('winston-transport');
const axios = require('axios');

class APILoggingTransport extends Transport {
  constructor(opts) {
    super(opts);
    this.apiUrl = opts.apiUrl;
  }

  async log(info, callback) {
    setImmediate(() => {
      this.emit('logged', info);
    });

    try {
      await axios.post(this.apiUrl, {
        level: info.level,
        message: info.message,
        timestamp: info.timestamp,
        service: info.service,
      });
    } catch (error) {
      console.error(`Failed to send log to API: ${error.message}`);
    }

    callback();
  }
}

module.exports = APILoggingTransport;
