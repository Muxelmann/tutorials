<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hallo, Welt!</title>
</head>
<body>
    <h1>Hallo, Welt: apache/php</h1>
    <?php $load = sys_getloadavg(); ?>
    <p>
        Serverzeit: <?php echo date("c"); ?> <br>
        Serverauslastung: <?php echo $load[0]; ?>
    </p>
</body>
</html>