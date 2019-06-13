plan sec_bolt::remediate_windows(
  TargetSpec $nodes,
) {
    run_task('sec_bolt::disable_win_user', $nodes)
    run_task('sec_bolt::remove_admin_win', $nodes)
    run_command('Remove-WindowsFeature -name Telnet-Client', $nodes)
}
