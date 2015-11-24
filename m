From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Date: Mon, 23 Nov 2015 16:06:04 -0800
Message-ID: <20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37076 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbbKXAGd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Nov 2015 19:06:33 -0500
In-Reply-To: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

This effectively promotes IORESOURCE_BUSY to IORESOURCE_EXCLUSIVE
semantics by default.  If userspace really believes it is safe to access
the memory region it can also perform the extra step of disabling an
active driver.  This protects device address ranges with read side
effects and otherwise directs userspace to use the driver.

Persistent memory presents a large "mistake surface" to /dev/mem as now
accidental writes can corrupt a filesystem.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c |   11 +++++++++--
 lib/Kconfig.debug |   23 ++++++++++++++++++++---
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index f150dbbe6f62..09c0597840b0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1498,8 +1498,15 @@ int iomem_is_exclusive(u64 addr)
 			break;
 		if (p->end < addr)
 			continue;
-		if (p->flags & IORESOURCE_BUSY &&
-		     p->flags & IORESOURCE_EXCLUSIVE) {
+		/*
+		 * A resource is exclusive if IORESOURCE_EXCLUSIVE is set
+		 * or CONFIG_IO_STRICT_DEVMEM is enabled and the
+		 * resource is busy.
+		 */
+		if ((p->flags & IORESOURCE_BUSY) == 0)
+			continue;
+		if (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM)
+				|| p->flags & IORESOURCE_EXCLUSIVE) {
 			err = 1;
 			break;
 		}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 289dfcbc14eb..073496dea848 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1869,9 +1869,26 @@ config STRICT_DEVMEM
 	  enabled, even in this case there are restrictions on /dev/mem
 	  use due to the cache aliasing requirements.
 
+	  If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
+	  file only allows userspace access to PCI space and the BIOS code and
+	  data regions.  This is sufficient for dosemu and X and all common
+	  users of /dev/mem.
+
+	  If in doubt, say Y.
+
+config IO_STRICT_DEVMEM
+	bool "Filter I/O access to /dev/mem"
+	depends on STRICT_DEVMEM
+	default STRICT_DEVMEM
+	---help---
+	  If this option is disabled, you allow userspace (root) access to all
+	  io-memory regardless of whether a driver is actively using that
+	  range.  Accidental access to this is obviously disastrous, but
+	  specific access can be used by people debugging kernel drivers.
+
 	  If this option is switched on, the /dev/mem file only allows
-	  userspace access to PCI space and the BIOS code and data regions.
-	  This is sufficient for dosemu and X and all common users of
-	  /dev/mem.
+	  userspace access to *idle* io-memory ranges (see /proc/iomem) This
+	  may break traditional users of /dev/mem (dosemu, legacy X, etc...)
+	  if the driver using a given range cannot be disabled.
 
 	  If in doubt, say Y.
