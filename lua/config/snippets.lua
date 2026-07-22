return {
  function(context)
    if context.lang ~= 'php' then return {} end
    local namespace = 'namespace XXX;'
    return {
      {
        prefix = 'class',
        body = '<?php\n\ndeclare(strict_types=1);\n\n' .. namespace .. '\n\nclass $1\n{}\n',
      },
      {
        prefix = 'interface',
        body = '<?php\n\ndeclare(strict_types=1);\n\n' .. namespace .. '\n\ninterface $1\n{}\n',
      },
      {
        prefix = 'pubf',
        body = 'public function $1()\n{}\n',
      },
      {
        prefix = 'pubsf',
        body = 'public static function $1()\n{}\n',
      }
    }
  end,
}
