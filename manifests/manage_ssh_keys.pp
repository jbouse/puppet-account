#
# manage ssh keys for user
#
define account::manage_ssh_keys(
  $user,
  $key_file,
  $ensure = present,
) {

  $key_array   = split($name, ' ')
  $key_type    = $key_array[0] # ssh-rsa|ssh-dss
  $key_data    = $key_array[1] # Actual public key data
  $key_comment = $key_array[2] # Comment/name for key

  ssh_authorized_key {
    "${user}_${key_type}_${key_comment}":
      ensure => $ensure,
      user   => $user,
      name   => $key_comment,
      key    => $key_data,
      type   => $key_type,
      target => $key_file
  }
}
