export NAMESPACE=objectworld

alias k='kubectl'
alias ku='kubectl -n ${NAMESPACE}'

k create ns objectworld
ku get deploy

ku apply -f ngnix-sample.yaml
ku get deploy
ku get po
ku get svc
ku get all


k delete deploy nginx-deployment
k delete svc nginx-service
