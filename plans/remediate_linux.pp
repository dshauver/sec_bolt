plan sec_bolt::remediate_linux(
  TargetSpec $nodes,
) {
    run_task('sec_bolt::disable_nix_user', $nodes)
    run_task('sec_bolt::remove_admin_nix', $nodes)
    run_command('yum remove telnet -y', $nodes)
}
