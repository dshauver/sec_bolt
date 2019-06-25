plan sec_bolt::remediate_linux(
  TargetSpec $nodes,
) {
    run_plan(facts, nodes => $nodes)
    $centos_nodes = get_targets($nodes).filter |$n| { $n.facts['os']['name'] == 'CentOS'

    run_task('sec_bolt::disable_nix_user', $centos_nodes)
    run_task('sec_bolt::remove_admin_nix', $centos_nodes)
    run_command('yum remove telnet -y', $centos_nodes)
}
