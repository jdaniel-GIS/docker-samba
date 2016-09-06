FROM ubuntu:14.04

RUN apt-get update && apt-get install -y samba

RUN service smbd stop

COPY ./smb.conf /etc/samba/smb.conf
COPY ./password.txt /tmp

RUN mkdir /data

RUN cat /tmp/password.txt /tmp/password.txt | smbpasswd -sa root
RUN rm /tmp/password.txt

# Expose Samba ports
EXPOSE 137 138 139 445

# Run Samba in the foreground
CMD ["/usr/sbin/smbd", "-FS"]