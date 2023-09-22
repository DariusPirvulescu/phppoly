# Proof of concept

A simple PHP server to demonstrate how the polyglot files work, JPG+PHP polyglot in this case.

Run the server with:
```
php -S 127.0.0.1:8000
```

After adding the files `avatar.jpg` & `avatar.php` to this directory, they will be picked up and read by the interpreter. We can trigger remote shell by requesting the `avatar.php` file with the `cmd` query. 

Example, `127.0.0.1:8000/avatar.php?cmd=ls .` will print all the files in this directory.

<!-- Run the PHP web server with: php -S 127.0.0.1:8000 -->
