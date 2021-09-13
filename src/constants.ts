const region =
  process.env.AWS_DEFAULT_REGION || process.env.AWS_REGION || 'us-east-1';

export { region };
