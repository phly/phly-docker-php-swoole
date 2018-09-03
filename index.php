<?php
/**
 * @license http://opensource.org/licenses/BSD-2-Clause BSD-2-Clause
 * @copyright Copyright (c) Matthew Weier O'Phinney
 */

namespace Phly;

use Swoole\Http\Server;

const ADDRESS = '0.0.0.0';
const PORT = 9000;

$http = new server(ADDRESS, PORT);

$http->on('start', function ($server) {
    printf("Swoole HTTP server now listening at %s:%d%s", ADDRESS, PORT, PHP_EOL);
});

$http->on('request', function ($request, $response) {
    $response->header('Content-Type', 'text/plain');
    $response->end("Hello World\n");
});

$http->start();
