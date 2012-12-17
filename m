From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [PATCH 1/7] move debugfs to filesystems menu (fs/Kconfig)
Date: Mon, 17 Dec 2012 13:22:07 -0500
Message-ID: <20121217182207.4CF51258@kernel.stglabs.ibm.com>
References: <20121217182206.91AA150A@kernel.stglabs.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:45512 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412Ab2LQSXS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Dec 2012 13:23:18 -0500
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dave@linux.vnet.ibm.com>;
	Mon, 17 Dec 2012 13:23:18 -0500
In-Reply-To: <20121217182206.91AA150A@kernel.stglabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>


debugfs may have started out as a kernel hacking kind of option.  But,
today, it is an integral part of lots of facilities like tracing that
are far from kernel hacking.  Let's move it out of the very cluttered
"Kernel Hacking" menu and but it next to its real family: other
filesystems like sysfs, configfs, or /proc.

Also, "Debug filesystem" sounds like a debugging option _for_
filesystems code, not a filesystem for debugging.  We also never call
it "the debug filesystem."  We always say "debugfs", so reflect the
fact that we _call_ it debugfs in the menu text.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/fs/Kconfig        |   12 ++++++++++++
 linux-2.6.git-dave/lib/Kconfig.debug |   12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff -puN fs/Kconfig~be-clear-about-debugfs fs/Kconfig
--- linux-2.6.git/fs/Kconfig~be-clear-about-debugfs	2012-12-17 12:34:03.955929278 -0500
+++ linux-2.6.git-dave/fs/Kconfig	2012-12-17 12:34:03.963929345 -0500
@@ -176,6 +176,18 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config DEBUG_FS
+	bool "Debug Filesystem (debugfs)"
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  For detailed documentation on the debugfs API, see
+	  Documentation/DocBook/filesystems.
+
+	  If unsure, say N.
+
 source "fs/configfs/Kconfig"
 
 endmenu
diff -puN lib/Kconfig.debug~be-clear-about-debugfs lib/Kconfig.debug
--- linux-2.6.git/lib/Kconfig.debug~be-clear-about-debugfs	2012-12-17 12:34:03.959929312 -0500
+++ linux-2.6.git-dave/lib/Kconfig.debug	2012-12-17 12:34:03.963929345 -0500
@@ -99,18 +99,6 @@ config UNUSED_SYMBOLS
 	  you really need it, and what the merge plan to the mainline kernel for
 	  your module is.
 
-config DEBUG_FS
-	bool "Debug Filesystem"
-	help
-	  debugfs is a virtual file system that kernel developers use to put
-	  debugging files into.  Enable this option to be able to read and
-	  write to these files.
-
-	  For detailed documentation on the debugfs API, see
-	  Documentation/DocBook/filesystems.
-
-	  If unsure, say N.
-
 config HEADERS_CHECK
 	bool "Run 'make headers_check' when building vmlinux"
 	depends on !UML
_
