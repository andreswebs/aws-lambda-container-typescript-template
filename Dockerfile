# Dependencies
FROM node:18-buster-slim AS deps
WORKDIR /app
ENV NODE_ENV=production
COPY package.json package-lock.json /app/
RUN \
  npm ci --only=production

# Build
FROM node:18-buster-slim AS build
WORKDIR /app
COPY package.json package-lock.json tsconfig.json /app/
COPY ./src /app/src
RUN \
  npm install && \
  npm run build

# Release
FROM public.ecr.aws/lambda/nodejs:18
ENV NODE_ENV=production
COPY --from=deps /app/node_modules "${LAMBDA_TASK_ROOT}/node_modules"
COPY --from=build /app/dist/ "${LAMBDA_TASK_ROOT}/"
CMD ["app.handler"]
