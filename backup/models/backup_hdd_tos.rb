# encoding: utf-8

##
# Backup Generated: backup_hdd_tos
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup_hdd_tos [-c <path_to_configuration_file>]
#
Backup::Model.new(:backup_hdd_tos, 'Backup for the extHDD-2TB-tos') do

  sync_with RSync::Local do |rsync|
    rsync.path     = "~/Desktop/backup/"
    rsync.mirror   = true

    rsync.directories do |directory|
      directory.add "/home/philipp/Dropbox/projects/"
    end
  end
end
