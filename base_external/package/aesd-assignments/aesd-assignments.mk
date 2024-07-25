
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = '2d6433a8b146f5b793754b0f84a230ac915c4844'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-nwpu2013300779.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES
#AESD_ASSIGNMENTS_OVERRIDE_SRCDIR=/mnt/vhd0/assignment/assignments-3-and-later-nwpu2013300779

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0777 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0777 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0777 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
	sed -i -e 's/..\/conf\/assignment.txt/\/etc\/finder-app\/conf\/assignment.txt/g' $(TARGET_DIR)/usr/bin/finder-test.sh
	sed -i -e 's/conf\/username.txt/\/etc\/finder-app\/conf\/username.txt/g' $(TARGET_DIR)/usr/bin/finder-test.sh
	sed -i -e 's/.\/writer/writer/g' $(TARGET_DIR)/usr/bin/finder-test.sh
	sed -i -e 's/.\/finder.sh/finder.sh/g' $(TARGET_DIR)/usr/bin/finder-test.sh
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
endef

$(eval $(generic-package))
