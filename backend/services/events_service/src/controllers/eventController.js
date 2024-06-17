const Event = require('../models/event');
const logger = require('../logger');

exports.createEvent = async (req, res) => {
  try {
    const event = await Event.create(req.body);
    logger.info(`Event created: ${event.title}`);
    res.status(201).json(event);
  } catch (error) {
    logger.error(`Event creation failed: ${error.message}`);
    res.status(400).json({ error: error.message });
  }
};

exports.getAllEvents = async (req, res) => {
  try {
    const events = await Event.findAll();
    logger.info('Retrieved all events');
    res.status(200).json(events);
  } catch (error) {
    logger.error(`Failed to retrieve events: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

exports.getEventById = async (req, res) => {
  try {
    const event = await Event.findByPk(req.params.id);
    if (event) {
      logger.info(`Retrieved event: ${event.title}`);
      res.status(200).json(event);
    } else {
      logger.warn(`Event not found: ${req.params.id}`);
      res.status(404).json({ error: 'Event not found' });
    }
  } catch (error) {
    logger.error(`Failed to retrieve event: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

exports.updateEvent = async (req, res) => {
  try {
    const event = await Event.findByPk(req.params.id);
    if (event) {
      await event.update(req.body);
      logger.info(`Event updated: ${event.title}`);
      res.status(200).json(event);
    } else {
      logger.warn(`Event not found: ${req.params.id}`);
      res.status(404).json({ error: 'Event not found' });
    }
  } catch (error) {
    logger.error(`Event update failed: ${error.message}`);
    res.status(400).json({ error: error.message });
  }
};

exports.deleteEvent = async (req, res) => {
  try {
    const event = await Event.findByPk(req.params.id);
    if (event) {
      await event.destroy();
      logger.info(`Event deleted: ${event.title}`);
      res.status(200).json({ message: 'Event deleted' });
    } else {
      logger.warn(`Event not found: ${req.params.id}`);
      res.status(404).json({ error: 'Event not found' });
    }
  } catch (error) {
    logger.error(`Event deletion failed: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};
