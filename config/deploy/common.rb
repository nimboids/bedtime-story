##########################################################################
#                                                                        #
# This file is part of the nimbus rails template: DO NOT UPDATE MANUALLY #
#                                                                        #
# To update, run 'rake template'                                         #
#                                                                        #
##########################################################################

namespace :deploy do
  task :update_logrotate, :roles => :app do
    # FIXME: make this work with git-deploy (and without multistage)
    sudo "ruby #{release_path}/script/install_logrotate #{shared_path} /etc/logrotate.d/#{application}-#{stage}"
  end
end
