# encoding: utf-8

##
# Backup Generated: backup_hdd_tos
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup_hdd_tos [-c <path_to_configuration_file>]
#
Backup::Model.new(:backup_hdd_fap, 'extHDD-2TB-fap') do

  sync_with RSync::Local do |rsync|
    rsync.path     = "/run/media/philipp/extHDD-1TB-fap/Backup/"
    rsync.mirror   = true

    rsync.directories do |directory|
      directory.add "~/Dropbox/projects/"
      directory.add "~/Dropbox/NetBeansProjects/"
      directory.add "~/Dropbox/EclipseProjects/"
      directory.add "~/Dropbox/Dokumente/"
      directory.add "~/Dropbox/git-depots/"
      directory.add "~/Dropbox/repos/"
      directory.add "~/Dropbox/.configfiles/"
      directory.add "/srv/philipp/Bilder/"
      directory.add "/srv/philipp/eBooks/"
      directory.add "/srv/philipp/Musik/"
    end
  end
end
