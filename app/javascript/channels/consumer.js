/**
 * Action Cable Consumer
 *
 * Creates and exports the main Action Cable consumer for WebSocket connections.
 * This consumer is used by all channels to establish and maintain WebSocket
 * connections with the Rails server for real-time functionality.
 *
 * Action Cable Features:
 * - Real-time bidirectional communication
 * - Automatic reconnection on connection loss
 * - Channel-based message routing
 * - Integration with Rails authentication
 *
 * Potential Use Cases for Shop Application:
 * - Real-time cart updates across devices
 * - Live inventory updates
 * - Admin notifications for new orders
 * - Customer support chat
 * - Live product availability updates
 *
 * Usage:
 * Import this consumer in channel files to create subscriptions:
 *
 * import consumer from "./consumer"
 *
 * consumer.subscriptions.create("ChatChannel", {
 *   connected() {
 *     // Called when subscription is ready for use on server
 *   },
 *
 *   disconnected() {
 *     // Called when subscription has been terminated by server
 *   },
 *
 *   received(data) {
 *     // Called when data is received from server
 *   }
 * })
 *
 * Generation Command:
 * To create new channels, use: bin/rails generate channel ChannelName
 */

// Import the createConsumer function from Rails Action Cable
import { createConsumer } from "@rails/actioncable"

// Create and export the default consumer instance
// This will connect to the WebSocket endpoint defined in config/cable.yml
export default createConsumer()
