<?php

function add_commas ($string) {
    return str_replace(
        ',', ', ', preg_replace('/(?<=\d)\s/', ',', trim($string))
    );
}

function convert_cg ($string) {
    $command = $string[0];
    $commands = [
        'M' => 'CGContextMoveToPoint',
        'C' => 'CGContextAddCurveToPoint',
        'Z' => 'CGContextClosePath',
        'L' => 'CGContextAddLineToPoint'
    ];
    
    $command = isset($commands[$command]) ? $commands[$command] : '';
    $args = substr($string, 2);
    $args = $args ? ", $args" : '';
    
    if ($command) {
        return "$command(ctx$args)";
    }
    else {
        return '';
    }
}

function format ($data) {
    return trim(preg_replace('/([A-Z])/', "\n\$1", $data));
}

$data = 'M 10,40 C 11.108,40 12,40.892 12,42 L 12,98 C 12,99.108 11.108,100 10,100 C 8.892,100 8,99.108 8,98 L 8,42 C 8,40.892 8.892,40 10,40 Z';
$data = format($data);

$lines = explode("\n", $data);
$lines = array_map('add_commas', $lines);
$lines = array_map('convert_cg', $lines);

echo implode("\n", $lines);