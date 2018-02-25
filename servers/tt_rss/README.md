= Mobile Support =

If the server is rss.example.com and the mobile site is hosted from m.rss.example.com, then you'll need to configure CORS.  In
the vhost/$host file, add:

    location /api {
            add_header Access-Control-Allow-Origin "https://m.$host";
            proxy_pass http://<host_name>/api;
    }
