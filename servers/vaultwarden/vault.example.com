client_max_body_size 128M;

location /notifications/hub/ {
	proxy_pass http://vault.example.com;
}
location /notifications/hub {
	proxy_pass http://vault.example.com-ws;
}

