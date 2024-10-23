# saptarshikar/netdbgtools 

This is the Dockerfile for a Rocky Linux based container with common network debug tools like ping, traceroute, mtr, nmap, iproute, bind-utils etc.

The container can be built with:

```
docker build --no-cache -t saptarshikar/netdbgtools:latest .
```


The container can be launched with the following command:
```
docker run --name netdbgtools -p 127.0.0.1:2222:22 -itd saptarshikar/netdbgtools
```

Connect with: ssh root@127.0.0.1 -p 2222 

