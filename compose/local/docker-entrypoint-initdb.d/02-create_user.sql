create user writer@'%' identified by 'asdf';
grant select,update,delete,insert on *.* to writer@'%';

create user reader@'%' identified by 'asdf';
grant select on *.* to reader@'%';



