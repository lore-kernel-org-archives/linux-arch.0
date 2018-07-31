From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/10] um: create a proper drivers Kconfig
Date: Tue, 31 Jul 2018 13:39:28 +0200
Message-ID: <20180731113935.6105-4-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Merge arch/um/Kconfig.char and arch/um/Kconfig.net into a new
arch/um/drivers/Kconfig.  This fits the way Kconfig files are placed
elsewhere in the kernel tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig                          |   4 +-
 arch/um/Kconfig.char                     | 124 ----------------------
 arch/um/{Kconfig.net => drivers/Kconfig} | 125 ++++++++++++++++++++++-
 3 files changed, 125 insertions(+), 128 deletions(-)
 delete mode 100644 arch/um/Kconfig.char
 rename arch/um/{Kconfig.net => drivers/Kconfig} (66%)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 69fa01a4a81b..ea35bf91fc0f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -194,14 +194,12 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-source "arch/um/Kconfig.char"
+source "arch/um/drivers/Kconfig"
 
 source "drivers/Kconfig"
 
 source "net/Kconfig"
 
-source "arch/um/Kconfig.net"
-
 source "fs/Kconfig"
 
 source "security/Kconfig"
diff --git a/arch/um/Kconfig.char b/arch/um/Kconfig.char
deleted file mode 100644
index f184bde7030e..000000000000
--- a/arch/um/Kconfig.char
+++ /dev/null
@@ -1,124 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-menu "UML Character Devices"
-
-config STDERR_CONSOLE
-	bool "stderr console"
-	default y
-	help
-	  console driver which dumps all printk messages to stderr.
-
-config SSL
-	bool "Virtual serial line"
-	help
-          The User-Mode Linux environment allows you to create virtual serial
-          lines on the UML that are usually made to show up on the host as
-          ttys or ptys.
-
-          See <http://user-mode-linux.sourceforge.net/old/input.html> for more
-          information and command line examples of how to use this facility.
-
-          Unless you have a specific reason for disabling this, say Y.
-
-config NULL_CHAN
-	bool "null channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to a device similar to /dev/null.  Data written to it disappears
-          and there is never any data to be read.
-
-config PORT_CHAN
-	bool "port channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to host portals.  They may be accessed with 'telnet <host>
-          <port number>'.  Any number of consoles and serial lines may be
-          attached to a single portal, although what UML device you get when
-          you telnet to that portal will be unpredictable.
-          It is safe to say 'Y' here.
-
-config PTY_CHAN
-	bool "pty channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to host pseudo-terminals.  Access to both traditional
-          pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
-          with this option.  The assignment of UML devices to host devices
-          will be announced in the kernel message log.
-          It is safe to say 'Y' here.
-
-config TTY_CHAN
-	bool "tty channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to host terminals.  Access to both virtual consoles
-          (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
-          /dev/pts/*) are controlled by this option.
-          It is safe to say 'Y' here.
-
-config XTERM_CHAN
-	bool "xterm channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to xterms.  Each UML device so assigned will be brought up in
-          its own xterm.
-          It is safe to say 'Y' here.
-
-config NOCONFIG_CHAN
-	bool
-	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && NULL_CHAN)
-
-config CON_ZERO_CHAN
-	string "Default main console channel initialization"
-	default "fd:0,fd:1"
-	help
-          This is the string describing the channel to which the main console
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "fd:0,fd:1", which attaches the
-          main console to stdin and stdout.
-          It is safe to leave this unchanged.
-
-config CON_CHAN
-	string "Default console channel initialization"
-	default "xterm"
-	help
-          This is the string describing the channel to which all consoles
-          except the main console will be attached by default.  This value can
-          be overridden from the command line.  The default value is "xterm",
-          which brings them up in xterms.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have X or xterm available.
-
-config SSL_CHAN
-	string "Default serial line channel initialization"
-	default "pty"
-	help
-          This is the string describing the channel to which the serial lines
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "pty", which attaches them to
-          traditional pseudo-terminals.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have a set of /dev/pty* devices.
-
-config UML_SOUND
-	tristate "Sound support"
-	help
-          This option enables UML sound support.  If enabled, it will pull in
-          soundcore and the UML hostaudio relay, which acts as a intermediary
-          between the host's dsp and mixer devices and the UML sound system.
-          It is safe to say 'Y' here.
-
-config SOUND
-	tristate
-	default UML_SOUND
-
-config SOUND_OSS_CORE
-	bool
-	default UML_SOUND
-
-config HOSTAUDIO
-	tristate
-	default UML_SOUND
-
-endmenu
diff --git a/arch/um/Kconfig.net b/arch/um/drivers/Kconfig
similarity index 66%
rename from arch/um/Kconfig.net
rename to arch/um/drivers/Kconfig
index c390f3deb0dc..2b1aaf7755aa 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/drivers/Kconfig
@@ -1,5 +1,129 @@
 # SPDX-License-Identifier: GPL-2.0
 
+menu "UML Character Devices"
+
+config STDERR_CONSOLE
+	bool "stderr console"
+	default y
+	help
+	  console driver which dumps all printk messages to stderr.
+
+config SSL
+	bool "Virtual serial line"
+	help
+          The User-Mode Linux environment allows you to create virtual serial
+          lines on the UML that are usually made to show up on the host as
+          ttys or ptys.
+
+          See <http://user-mode-linux.sourceforge.net/old/input.html> for more
+          information and command line examples of how to use this facility.
+
+          Unless you have a specific reason for disabling this, say Y.
+
+config NULL_CHAN
+	bool "null channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to a device similar to /dev/null.  Data written to it disappears
+          and there is never any data to be read.
+
+config PORT_CHAN
+	bool "port channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to host portals.  They may be accessed with 'telnet <host>
+          <port number>'.  Any number of consoles and serial lines may be
+          attached to a single portal, although what UML device you get when
+          you telnet to that portal will be unpredictable.
+          It is safe to say 'Y' here.
+
+config PTY_CHAN
+	bool "pty channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to host pseudo-terminals.  Access to both traditional
+          pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
+          with this option.  The assignment of UML devices to host devices
+          will be announced in the kernel message log.
+          It is safe to say 'Y' here.
+
+config TTY_CHAN
+	bool "tty channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to host terminals.  Access to both virtual consoles
+          (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
+          /dev/pts/*) are controlled by this option.
+          It is safe to say 'Y' here.
+
+config XTERM_CHAN
+	bool "xterm channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to xterms.  Each UML device so assigned will be brought up in
+          its own xterm.
+          It is safe to say 'Y' here.
+
+config NOCONFIG_CHAN
+	bool
+	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && NULL_CHAN)
+
+config CON_ZERO_CHAN
+	string "Default main console channel initialization"
+	default "fd:0,fd:1"
+	help
+          This is the string describing the channel to which the main console
+          will be attached by default.  This value can be overridden from the
+          command line.  The default value is "fd:0,fd:1", which attaches the
+          main console to stdin and stdout.
+          It is safe to leave this unchanged.
+
+config CON_CHAN
+	string "Default console channel initialization"
+	default "xterm"
+	help
+          This is the string describing the channel to which all consoles
+          except the main console will be attached by default.  This value can
+          be overridden from the command line.  The default value is "xterm",
+          which brings them up in xterms.
+          It is safe to leave this unchanged, although you may wish to change
+          this if you expect the UML that you build to be run in environments
+          which don't have X or xterm available.
+
+config SSL_CHAN
+	string "Default serial line channel initialization"
+	default "pty"
+	help
+          This is the string describing the channel to which the serial lines
+          will be attached by default.  This value can be overridden from the
+          command line.  The default value is "pty", which attaches them to
+          traditional pseudo-terminals.
+          It is safe to leave this unchanged, although you may wish to change
+          this if you expect the UML that you build to be run in environments
+          which don't have a set of /dev/pty* devices.
+
+config UML_SOUND
+	tristate "Sound support"
+	help
+          This option enables UML sound support.  If enabled, it will pull in
+          soundcore and the UML hostaudio relay, which acts as a intermediary
+          between the host's dsp and mixer devices and the UML sound system.
+          It is safe to say 'Y' here.
+
+config SOUND
+	tristate
+	default UML_SOUND
+
+config SOUND_OSS_CORE
+	bool
+	default UML_SOUND
+
+config HOSTAUDIO
+	tristate
+	default UML_SOUND
+
+endmenu
+
 menu "UML Network Devices"
 	depends on NET
 
@@ -211,4 +335,3 @@ config UML_NET_SLIRP
         Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
 
 endmenu
-
-- 
2.18.0
