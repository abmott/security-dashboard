```
mgcc119147:docker grh8dee$ docker build . -t docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-ruby-aws:latest
 ---> 993778732013
Step 2/2 : RUN   apt-get update &&  gem install dogapi --no-ri --no-rdoc &&   rm -rf /var/lib/apt/lists/*
 ---> Using cache
 ---> 599d4b77e98d
Successfully built 599d4b77e98d

Successfully tagged docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi:latest

mgcc119147:docker grh8dee$ docker push docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi
The push refers to repository [docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi]
3644c0429f73: Layer already exists
42b278653656: Layer already exists
24588477873e: Layer already exists
5c3da56f51c2: Layer already exists
2f5b0990636a: Layer already exists
c9748fbf541d: Layer already exists

b3968bc26fbd: Layer already exists
aa4e47c45116: Layer already exists
788ce2310e2f: Layer already exists
latest: digest: sha256:45bdbd9d90dfb62b78cd944ee794850a16dd85763e1a344c3369f988b89b8585 size: 2198
```
