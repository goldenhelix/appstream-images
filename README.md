
# App Streaming Images
This repository contains several example of desktop and application images.


```
./build_core.sh
./build_varseq.sh
```

Test
```
docker run --rm --shm-size="1gb"   -e VNC_PW=password   -p 6901:6901   registry.goldenhelix.com/public/ghdesktop-office-web:x86_64-<date>

docker run -d --rm -v /home/rudy/dev/Workspace:/home/ghuser/Workspace  --mac-address="02:42:ac:11:00:ff" -e MONITOR_PROCESS="" -e VS_FULLSCREEN=1 --shm-size="1gb"   -e VNC_PW=password   -p 6902:6901   registry.goldenhelix.com/public/ghdesktop-varseq:2.6.2
```

The container is now accessible via a browser : `https://<IP>:6901`

 - **User** : `ghuser`
 - **Password**: `password`

