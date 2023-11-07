# Spigot Minecraft Docker Image

## Build Image

Pull this repository and run the following command.

```sh
docker build -t minecraft-spigot-server:1.0.0 -f dockerfile .
```

## Run Image

To run the image execute the following command.

```sh
docker run -v /home/$USER/minecraft/server/data:/server  minecraft-spigot-server:1.0.0
```

To accept the EULA use the environment variable `-e EULA=true`.
By changing the setting to true you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).

```sh
docker run -v /home/$USER/minecraft/server/data:/server -e EULA=true minecraft-spigot-server:1.0.0
```
