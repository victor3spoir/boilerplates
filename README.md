# DockerApps


## Portainer

user: ryuk
password: RohLId(o]N4S2J$n3?q,*r9\2X-!Q9,!

## Authentik
email: admin@gmail.com
pass: RohLId(o)N4S2J$n3?q,*r9\2X-!Q9,!

email: kvruntime@proton.me
email: ryuk@gmail.com
password: RohLId(o)N4S2J$n3?q,*r9\2X-!Q9,!


## Mattermost
email: ryuk@gmail.com
user: ryuk
password: RohLId(o)N4S2J$n3?q,*r9\2X-!Q9,!
## Appsmith
email: ryuk@gmail.com
user: ryuk
password: RohLId(o)N4S2J$n3?q,*r9\2X-!Q9,!







## Generate self certificate
```bash
openssl genrsa -out private.key 2048

openssl req -new -key private.key -out csr.pem

openssl x509 -req -days 365 -in csr.pem -signkey private.key -out certificate.crt

openssl x509 -text -noout -in certificate.crt

```