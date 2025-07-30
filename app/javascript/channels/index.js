/**
 * Action Cable Channels Index
 *
 * Automatically loads and registers all Action Cable channels in this directory.
 * Action Cable provides WebSocket functionality for real-time features like
 * live chat, notifications, and real-time updates.
 *
 * File Naming Convention:
 * - Channel files must be named with the pattern: *_channel.js
 * - Example: chat_channel.js, notifications_channel.js
 *
 * How it works:
 * 1. Uses require.context to find all *_channel.js files
 * 2. Automatically imports and registers each channel
 * 3. Makes channels available for subscription in the application
 *
 * Usage:
 * - Create new channel files following the naming convention
 * - They will be automatically loaded without manual imports
 * - Channels can then be subscribed to from views or other JS files
 *
 * Current Status:
 * - No specific channels implemented yet
 * - Infrastructure ready for real-time features
 * - Consumer setup available in consumer.js
 */

// Use webpack's require.context to find all channel files
// Parameters: directory, use subdirectories, file pattern
const channels = require.context('.', true, /_channel\.js$/)

// Import and register each found channel file
channels.keys().forEach(channels)
