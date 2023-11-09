# Spigot Minecraft Docker Image

## Build Image

Pull this repository and run the following command.

```sh
docker build -t minecraft-spigot-server:1.0.0 -f dockerfile .
```

```sh
# Environment variables
EULA=true # The default is false 
MEMORY=2048 # The default is 1024
# Volumes that should be mapped
/server # Here the server and the server data is located (i.e. the World)
# Ports that should be mapped
25565 # The server listen on the default minecraft server port
```

## Run Image

To run the image execute the following command.

```sh
docker run -v /home/$USER/minecraft/server/data:/server -p 25565:25565  minecraft-spigot-server:1.0.0
```

To accept the EULA use the environment variable `-e EULA=true`.
By changing the setting to true you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).

```sh
docker run -v /home/$USER/minecraft/server/data:/server -e EULA=true -p 25565:25565 minecraft-spigot-server:1.0.0
```

Register the server as a demon with 3GB memory, accepting the eula (https://aka.ms/MinecraftEULA) and set the start type to always up.

```sh
docker run -d -v /home/$USER/minecraft/server/data:/server -e EULA=true -e MEMORY=3072 -p 25565:25565 --restart=always minecraft-spigot-server:1.0.0
```

## Tuning Server

After the first start the server.properties will be created.
Here you can change the following settings:

- The maximum number of milliseconds a single tick may take before the server watchdog stops the server with the message: `max-tick-time=-1`
- This allows you to set the cap for the size of a packet before the server attempts to compress it:`network-compression-threshold=-1`
- Simulation Distance sets the number of chunks that will run in-game processes (even if they’re not visible): load entities, grow crops, run automatic contraptions, etc: `simulation-distance=6`
- View Distance sets the number of chunks that are visible in all directions around a player: `view-distance=6`

Download and install the StackMob.jar (Current version StackMob-5.8.8.jar). You need to change the access right in the `data` directory: `sudo chmod -R 777 data`.

- [https://ci.codemc.io/job/Nathat23/job/StackMob-5/](https://ci.codemc.io/job/Nathat23/job/StackMob-5/)
- [https://ci.codemc.io/job/Nathat23/job/StackMob-5/lastSuccessfulBuild/artifact/target/StackMob-5.8.8.jar](https://ci.codemc.io/job/Nathat23/job/StackMob-5/lastSuccessfulBuild/artifact/target/StackMob-5.8.8.jar)

You can also increase the memory which can be used by the server with the MEMORY environment variable. The value is the size im MB (1024 = 1 GB, 4096 = 4GB).
