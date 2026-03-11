import { Client } from "@discordjs/core";
import { REST } from "@discordjs/rest";
import { WebSocketManager } from "@discordjs/ws";
import {
  GatewayDispatchEvents,
  GatewayIntentBits,
} from "discord-api-types/v10";
import { Kafka } from "kafkajs";

const rest = new REST({ version: 10 }).setToken(process.env.DISCORD_TOKEN);
const gateway = new WebSocketManager({
  token: process.env.DISCORD_TOKEN,
  intents: GatewayIntentBits.GuildMessages | GatewayIntentBits.MessageContent,
  rest,
});

const client = new Client({ rest, gateway });

const kafka = new Kafka({
  clientId: "discord-bot",
  brokers: ["osprey-kafka:29092"],
});

let actionCounter = 0;

const producer = kafka.producer();
await producer.connect();

client.on(
  GatewayDispatchEvents.MessageCreate,
  async ({ data: message, api }) => {
    console.log(message.content);

    const actionId = ++actionCounter;

    const envelope = {
      send_time: new Date().toISOString(),
      data: {
        action_id: actionId,
        action_name: "message_create",
        data: {
          content: message.content,
          author: message.author,
          guild_id: message.guild_id,
          channel_id: message.channel_id,
          event_type: "message_create",
        },
      },
    };

    await producer.send({
      topic: "osprey.actions_input",
      messages: [
        {
          value: JSON.stringify(envelope),
        },
      ],
    });
  },
);

gateway.connect();
