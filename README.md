# ethereum-remix
PizzaFactory/Contorno editor plugin that supports Electrum's Remix 

## How to run on your localhost.

1. Run the container.

```
docker run -it --rm \
  -p 8080:8080 -p 65520:65520
  -v {your local volume path}:/projects \
  pizzafactory0contorno/ethereum-remix:latest
```

2. Open `http://localhost:8080` on your web browser.

