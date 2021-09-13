import { APIGatewayEvent } from 'aws-lambda';

type Event = APIGatewayEvent;

async function handler(event: Event) {
  const {
    requestContext: { connectionId, routeKey },
  } = event;

  if (routeKey === '$connect') {
    // handle new connection
    console.log(connectionId);
    return {
      statusCode: 200,
    };
  }

  if (routeKey === '$disconnect') {
    // handle disconnection
    return {
      statusCode: 200,
    };
  }

  // $default handler
  return {
    statusCode: 200,
  };
}

export { handler };
