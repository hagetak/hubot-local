# hubot/Dockerfile
FROM node:latest

RUN npm install -g yo generator-hubot coffeescript hubot-slack --save

ENV ENTRYKIT_VERSION 0.4.0

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

RUN useradd hubot -m

USER hubot
RUN chown hubot.hubot /home/hubot
WORKDIR /home/hubot

ENTRYPOINT [ \
  "prehook", "npm install", "--"]
