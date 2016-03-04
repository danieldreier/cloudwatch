# == Define cloudwatch::log
#
define cloudwatch::log (
  String[1] $file = $name,
  String[1] $datetime_format = '%b %d %H:%M:%S',
  Variant[Integer, String[1]] $buffer_duration = 5000,
  String[1] $log_stream_name = '{hostname}',
  String[1] $initial_position = 'start_of_file',
  Optional[Hash[String[1], String[1]]] $extra_settings = undef,
){
  # replace special characters with underscores to avoid trying to create invalid file names
  $munged_name = inline_template("logfile<%= @name.gsub(/[^0-9A-Za-z]/, '_') %>")

  file { "${cloudwatch::conf_path}/${munged_name}.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => inline_epp(@(EOF)
      [<%= $file %>]
      datetime_format = <%= $datetime_format %>
      file = <%= $file %>
      buffer_duration = <%= $buffer_duration %>
      log_stream_name = <%= $log_stream_name %>
      initial_position = <%= $initial_position %>
      log_group_name = <%= $file %>
      <% if $extra_settings =~ Hash[String[1], String[1]] { -%>
      <%   $extra_settings.each |$key,$value| { -%>
      <%= $key %> = <%= $value %>
      <%   } -%>
      <% } -%>
      |- EOF
    ),
    notify  => Service['awslogs'],
  }
}
