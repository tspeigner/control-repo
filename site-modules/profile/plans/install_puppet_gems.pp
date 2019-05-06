# plan profile::install_puppet_gems (
#   TargetSpec $nodes,
#   $package_name = 'wget',
#   Array $puppet_gems = ['hocon'],
#   Optional $task_args = {'_run_as' => root, '_cath_errors' => true}
# ){
#   # notice($puppet_gems)
#   apply($nodes, $task_args) {
#     $puppet_gems.each |$pgem| {
#       package {"${pgem}": 
#         ensure   => installed,
#         provider => puppet_gem,
#       }
#     }
#   }
#   apply ($nodes, '_run_as' => root){
#     package {"${package_name}":
#       ensure   => present,
#       provider => brew,
#     }
#   }
# }
