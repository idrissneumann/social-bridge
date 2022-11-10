#!/usr/bin/env bash

source ./ci/compute-env.sh

ENV_FILE="twitter_slack.env"

echo "" > ${ENV_FILE}
echo "LOG_LEVEL=${LOG_LEVEL}" >> ${ENV_FILE}
echo "WAIT_TIME=${WAIT_TIME}" >> ${ENV_FILE}
echo "KEYWORD_WAIT_TIME=${KEYWORD_WAIT_TIME}" >> ${ENV_FILE}

env|grep -E "^(TWITTER_|DISCORD_|SLACK_|REDIS_|MASTODON_|UPRODIT_)"|while read -r; do
  echo "${REPLY}" >> "${ENV_FILE}"
done

CROSS_ENV_FILE="twitter_cross.env"
echo "" > ${CROSS_ENV_FILE}
echo "TWITTER_CONSUMER_KEY=${TWITTER_CONSUMER_KEY}" >> ${CROSS_ENV_FILE}
echo "TWITTER_CONSUMER_SECRET=${TWITTER_CONSUMER_SECRET}" >> ${CROSS_ENV_FILE}
echo "TWITTER_ACCESS_TOKEN=${TWITTER_ACCESS_TOKEN}" >> ${CROSS_ENV_FILE}
echo "TWITTER_ACCESS_TOKEN_SECRET=${TWITTER_ACCESS_TOKEN_SECRET}" >> ${CROSS_ENV_FILE}
echo "TWITTER_MAX_RESULTS=${TWITTER_MAX_RESULTS}" >> ${CROSS_ENV_FILE}
echo "TWITTER_RETENTION_DAYS=${TWITTER_RETENTION_DAYS}" >> ${CROSS_ENV_FILE}
echo "TWITTER_SLACK_VERSION=${TWITTER_SLACK_VERSION}" >> ${CROSS_ENV_FILE}
echo "LOG_LEVEL=${LOG_LEVEL}" >> ${CROSS_ENV_FILE}
echo "WAIT_TIME=${WAIT_TIME}" >> ${CROSS_ENV_FILE}
echo "KEYWORD_WAIT_TIME=${KEYWORD_WAIT_TIME}" >> ${CROSS_ENV_FILE}

env|grep -E "^(MASTODON_|REDIS_|CROSS_)"|while read -r; do
  echo "${REPLY//CROSS_}" >> "${CROSS_ENV_FILE}"
done

MASTODON_CROSS_ENV_FILE="mastodon_reverse.env"
echo "" > ${MASTODON_CROSS_ENV_FILE}
echo "TWITTER_CONSUMER_KEY=${TWITTER_CONSUMER_KEY}" >> ${MASTODON_CROSS_ENV_FILE}
echo "TWITTER_CONSUMER_SECRET=${TWITTER_CONSUMER_SECRET}" >> ${MASTODON_CROSS_ENV_FILE}
echo "TWITTER_ACCESS_TOKEN=${TWITTER_ACCESS_TOKEN}" >> ${MASTODON_CROSS_ENV_FILE}
echo "TWITTER_ACCESS_TOKEN_SECRET=${TWITTER_ACCESS_TOKEN_SECRET}" >> ${MASTODON_CROSS_ENV_FILE}
echo "TWITTER_MAX_RESULTS=${TWITTER_MAX_RESULTS}" >> ${MASTODON_CROSS_ENV_FILE}
echo "TWITTER_RETENTION_DAYS=${TWITTER_RETENTION_DAYS}" >> ${MASTODON_CROSS_ENV_FILE}
echo "TWITTER_SLACK_VERSION=${TWITTER_SLACK_VERSION}" >> ${MASTODON_CROSS_ENV_FILE}
echo "LOG_LEVEL=${LOG_LEVEL}" >> ${MASTODON_CROSS_ENV_FILE}
echo "WAIT_TIME=${WAIT_TIME}" >> ${MASTODON_CROSS_ENV_FILE}
echo "KEYWORD_WAIT_TIME=${KEYWORD_WAIT_TIME}" >> ${MASTODON_CROSS_ENV_FILE}

env|grep -E "^(MASTODON_|REDIS_|MASTODON_CROSS_)"|while read -r; do
  echo "${REPLY//REVERSE_}" >> "${MASTODON_CROSS_ENV_FILE}"
done

docker rmi -f "comworkio/twitter-slack:${TWITTER_SLACK_VERSION}" || :
docker-compose -f docker-compose-intra.yml up -d --force-recreate
