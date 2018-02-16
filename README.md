# simple-erlang-rest

## Compilar

```javascript
rebar3 compile
```

## Release

```javascript
rebar3 release
```

## Iniciar componente

```javascript
simple-erlang-rest\_build\default\rel\simple_erlang_rest\bin\simple_erlang_rest console
```

## Servicio home

```javascript
curl -H "Content-Type: application/json" -X GET http://localhost:7701/simple_erlang_rest
```

```javascript
{"status":200,"result":"home"}
```

## Servicio no existente

```javascript
curl -H "Content-Type: application/json" -X GET http://localhost:7701/not_found
```

```javascript
{"status":200,"result":"home"}
```

## Suma

```javascript
curl -X POST http://localhost:7701/simple_erlang_rest/add -H "Content-Type:application/json" -d "{'left':5,'right':3}"
```

```javascript
{"status":200,"result":8}
```

## Resta

```javascript
curl -X POST http://localhost:7701/simple_erlang_rest/subtract -H "Content-Type:application/json" -d "{'left':5,'right':3}"
```

```javascript
{"status":200,"result":2}
```

## Multiplicacióm

```javascript
curl -X POST http://localhost:7701/simple_erlang_rest/multiply -H "Content-Type:application/json" -d "{'left':5,'right':3}"
```

```javascript
{"status":200,"result":15}
```

## División

```javascript
curl -X POST http://localhost:7701/simple_erlang_rest/divide -H "Content-Type:application/json" -d "{'left':5,'right':3}"
```

```javascript
{"status":200,"result":1.6666666666666667}
```
