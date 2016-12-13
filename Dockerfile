FROM node

WORKDIR /tictactoe

COPY package.json .
COPY . .

RUN ls

RUN npm install --silent

RUN ls

EXPOSE 3000

ENV NODE_PATH .

RUN chmod +x runnode.sh 

CMD ["./runnode.sh"]
