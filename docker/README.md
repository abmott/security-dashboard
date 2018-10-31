```
mgcc119147:docker grh8dee$ docker build . -t docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi
Sending build context to Docker daemon  4.096kB
Step 1/2 : FROM docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-ruby-aws:latest
 ---> 993778732013
Step 2/2 : RUN gem install dogapi --no-ri --no-rdoc
 ---> Running in 963a3bc9d670
Successfully installed dogapi-1.28.0
1 gem installed
Removing intermediate container 963a3bc9d670
 ---> eae435a1cfd9
Successfully built eae435a1cfd9
Successfully tagged docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi:latest
mgcc119147:docker grh8dee$ docker push docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi:latest
The push refers to repository [docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-dogapi]
2d9f3c0e2e38: Pushed
42b278653656: Layer already exists
24588477873e: Layer already exists
5c3da56f51c2: Layer already exists
2f5b0990636a: Layer already exists
c9748fbf541d: Layer already exists
b3968bc26fbd: Layer already exists
aa4e47c45116: Layer already exists
788ce2310e2f: Layer already exists
latest: digest: sha256:418498f33913af8b29e6f8a4e9af8c4c5250b44c678105cfb868f89ce4fd6343 size: 2198
```
