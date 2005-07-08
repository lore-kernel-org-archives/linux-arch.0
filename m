Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 8 Jul 2005 00:38:32 +0000
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 1/2] net: add a top-level Networking menu to *config
Message-ID: <20050708003831.GB9883@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>
List-ID: <linux-arch.vger.kernel.org>

Create a new top-level menu named "Networking" thus moving
net related options and protocol selection way from the drivers
menu and up on the top-level where they belong.

To implement this all architectures has to source "net/Kconfig" before
drivers/*/Kconfig in their Kconfig file. This change has been
implemented for all architectures.

Device drivers for ordinary NIC's are still to be found
in the Device Drivers section, but Bluetooth, IrDA and ax25
are located with their corresponding menu entries under the new
networking menu item.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This patch is sent to linux-arch for information because it touches
all arch/*/Kconfig files.
I expect the netdev people to apply it.

	Sam


 arch/alpha/Kconfig     |    2 ++
 arch/arm/Kconfig       |    4 +++-
 arch/arm26/Kconfig     |    4 +++-
 arch/cris/Kconfig      |    4 +++-
 arch/frv/Kconfig       |    2 ++
 arch/h8300/Kconfig     |    4 +++-
 arch/i386/Kconfig      |    2 ++
 arch/ia64/Kconfig      |    2 ++
 arch/m32r/Kconfig      |    2 ++
 arch/m68k/Kconfig      |    2 ++
 arch/m68knommu/Kconfig |    2 ++
 arch/mips/Kconfig      |    2 ++
 arch/parisc/Kconfig    |    2 ++
 arch/ppc/Kconfig       |    2 ++
 arch/ppc64/Kconfig     |    2 ++
 arch/s390/Kconfig      |    4 +++-
 arch/sh/Kconfig        |    2 ++
 arch/sh64/Kconfig      |    2 ++
 arch/sparc/Kconfig     |    2 ++
 arch/sparc64/Kconfig   |    4 +++-
 arch/um/Kconfig        |    4 +++-
 arch/v850/Kconfig      |    4 +++-
 arch/x86_64/Kconfig    |    2 ++
 arch/xtensa/Kconfig    |    2 ++
 drivers/Kconfig        |    2 +-
 drivers/net/Kconfig    |    3 +++
 net/Kconfig            |   10 +++++-----
 27 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -596,6 +596,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -698,6 +698,8 @@ config APM
 
 endmenu
 
+source "net/Kconfig"
+
 menu "Device Drivers"
 
 source "drivers/base/Kconfig"
@@ -730,7 +732,7 @@ source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff --git a/arch/arm26/Kconfig b/arch/arm26/Kconfig
--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -183,6 +183,8 @@ source "mm/Kconfig"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/base/Kconfig"
 
 source "drivers/parport/Kconfig"
@@ -193,7 +195,7 @@ source "drivers/block/Kconfig"
 
 source "drivers/md/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/ide/Kconfig"
 
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -122,6 +122,8 @@ source arch/cris/arch-v10/Kconfig
 
 endmenu
 
+source "net/Kconfig"
+
 # bring in ETRAX built-in drivers
 menu "Drivers for built-in interfaces"
 source arch/cris/arch-v10/drivers/Kconfig
@@ -149,7 +151,7 @@ source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -346,6 +346,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -55,6 +55,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/base/Kconfig"
 
 source "drivers/mtd/Kconfig"
@@ -65,7 +67,7 @@ source "drivers/ide/Kconfig"
 
 source "arch/h8300/Kconfig.ide"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 #
 # input - input/joystick depends on it. As does USB.
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1285,6 +1285,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -423,6 +423,8 @@ endmenu
 
 endif
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -359,6 +359,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -450,6 +450,8 @@ source "drivers/zorro/Kconfig"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 menu "Character devices"
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -575,6 +575,8 @@ config PM
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1640,6 +1640,8 @@ config PM
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -190,6 +190,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1355,6 +1355,8 @@ config PIN_TLB
 	depends on ADVANCED_OPTIONS && 8xx
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig
+++ b/arch/ppc64/Kconfig
@@ -429,6 +429,8 @@ config CMDLINE
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -465,6 +465,8 @@ config KEXEC
 
 endmenu
 
+source "net/Kconfig"
+
 config PCMCIA
 	bool
 	default n
@@ -475,7 +477,7 @@ source "drivers/scsi/Kconfig"
 
 source "drivers/s390/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "fs/Kconfig"
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -784,6 +784,8 @@ config EMBEDDED_RAMDISK_IMAGE
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/sh64/Kconfig b/arch/sh64/Kconfig
--- a/arch/sh64/Kconfig
+++ b/arch/sh64/Kconfig
@@ -268,6 +268,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -268,6 +268,8 @@ source "mm/Kconfig"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 if !SUN4
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -506,6 +506,8 @@ source "mm/Kconfig"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/base/Kconfig"
 
 source "drivers/video/Kconfig"
@@ -532,7 +534,7 @@ endif
 
 source "drivers/ieee1394/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -275,6 +275,8 @@ endmenu
 
 source "init/Kconfig"
 
+source "net/Kconfig"
+
 source "drivers/base/Kconfig"
 
 source "arch/um/Kconfig_char"
@@ -287,7 +289,7 @@ config NETDEVICES
 
 source "arch/um/Kconfig_net"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "fs/Kconfig"
 
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -250,6 +250,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 #############################################################################
 
 source "drivers/base/Kconfig"
@@ -283,7 +285,7 @@ source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -515,6 +515,8 @@ config UID16
 
 endmenu
 
+source "net/Kconfig"
+
 source drivers/Kconfig
 
 source "drivers/firmware/Kconfig"
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -228,6 +228,8 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
+source "net/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -28,7 +28,7 @@ source "drivers/message/i2o/Kconfig"
 
 source "drivers/macintosh/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -3,6 +3,8 @@
 # Network device configuration
 #
 
+menu "Network device support"
+
 config NETDEVICES
 	depends on NET
 	bool "Network device support"
@@ -2547,3 +2549,4 @@ config NETCONSOLE
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.
 
+endmenu
diff --git a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -2,7 +2,7 @@
 # Network configuration
 #
 
-menu "Networking support"
+menu "Networking"
 
 config NET
 	bool "Networking support"
@@ -10,7 +10,9 @@ config NET
 	  Unless you really know what you are doing, you should say Y here.
 	  The reason is that some programs need kernel networking support even
 	  when running on a stand-alone machine that isn't connected to any
-	  other computer. If you are upgrading from an older kernel, you
+	  other computer.
+	  
+	  If you are upgrading from an older kernel, you
 	  should consider updating your networking tools too because changes
 	  in the kernel and the tools often go hand in hand. The tools are
 	  contained in the package net-tools, the location and version number
@@ -640,7 +642,5 @@ source "net/irda/Kconfig"
 
 source "net/bluetooth/Kconfig"
 
-source "drivers/net/Kconfig"
-
-endmenu
+endmenu # Networking
 
