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
let lastTimestamp = 0;

function generateActionId() {
  const now = Date.now();
  if (now === lastTimestamp) {
    actionCounter++;
  } else {
    lastTimestamp = now;
    actionCounter = 0;
  }
  // Shift timestamp left by 10 bits to leave room for up to 1024 actions per ms
  return now * 1024 + actionCounter;
}

const producer = kafka.producer();
await producer.connect();

async function kafkaSend(actionName, data) {
  await producer.send({
    topic: "osprey.actions_input",
    messages: [
      {
        value: JSON.stringify({
          send_time: new Date().toISOString(),
          data: {
            action_id: generateActionId(),
            action_name: actionName,
            data,
          },
        }),
      },
    ],
  });
}

client.on(GatewayDispatchEvents.MessageCreate, async ({ data: message }) => {
  console.log(message.content);

  await kafkaSend("message_create", message);
});

client.on(GatewayDispatchEvents.MessageDelete, async ({ data }) => {
  await kafkaSend("message_delete", data);
});

client.on(GatewayDispatchEvents.MessageDeleteBulk, async ({ data }) => {
  const { ids, channel_id, guild_id } = data;
  for (const id of ids) {
    await kafkaSend("message_delete", { id, channel_id, guild_id });
  }
});

client.on(GatewayDispatchEvents.MessageUpdate, async ({ data: message }) => {
  await kafkaSend("message_update", message);
});

gateway.connect();
