----
Friðjón Sigvaldason
181285-2309
----
Game URL (AWS)
	http://ec2-35-165-33-243.us-west-2.compute.amazonaws.com/


## Scripts

I created the following scripts

- Docker build

- Docker compose

- Other scripts


## Testing & logic

- The "GameJoined" test was successful, but the "FullGameJoinAttempted" did not.

- No more test were created

-The game is not playable.


## Data migration

I created a migrate file "add-col"

migration up to add the aggregate_id columt to event-log an migration down to remove said column. 

It took me 5 days to get this working properly

## Jenkins

In jenkins I have:

- Commit-Stage
	- This stage pulls all the code from github and creates docker images.

- Deployment-Stage
	- in this stage I copy the "docker-compose.yml" and the ".env" files to the ec2 machine and run docker-compose up.

- I created a build trigger on my Commit-Stage so that every time I pushed on github, jenkins built the new version.

- If the Commit-Stage finishes successfully the Deployment-Stage runs automatically.

## Monitoring

-No monitoring

## Other

Anything else you did to improve you deployment pipeline of the project itself?
 

 
