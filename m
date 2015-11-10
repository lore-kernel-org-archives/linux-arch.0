From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 2/2] printk: Only unregister boot consoles when necessary
Date: Tue, 10 Nov 2015 18:11:57 +0100
Message-ID: <1447175517-10933-2-git-send-email-thierry.reding@gmail.com>
References: <1447175517-10933-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447175517-10933-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Boot consoles are typically replaced by proper consoles during the boot
process. This can be problematic if the boot console data is part of the
init section that is reclaimed late during boot. If the proper console
does not register before this point in time, the boot console will need
to be removed (so that the freed memory is not accessed), leaving the
system without output for some time.

There are various reasons why the proper console may not register early
enough, such as deferred probe or the driver being a loadable module. If
that happens, there is some amount of time where no console messages are
visible to the user, which in turn can mean that they won't see crashes
or other potentially useful information.

To avoid this situation, only remove the boot console when it resides in
the init section. Code exists to replace the boot console by the proper
console when it is registered, keeping a seamless transition between the
boot and proper consoles.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add comments with the rationale for this change
---
 kernel/printk/printk.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2ce8826f1053..0c9f02506169 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -48,6 +48,7 @@
 #include <linux/uio.h>
 
 #include <asm/uaccess.h>
+#include <asm-generic/sections.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/printk.h>
@@ -2658,13 +2659,36 @@ int unregister_console(struct console *console)
 }
 EXPORT_SYMBOL(unregister_console);
 
+/*
+ * Some boot consoles access data that is in the init section and which will
+ * be discarded after the initcalls have been run. To make sure that no code
+ * will access this data, unregister the boot consoles in a late initcall.
+ *
+ * If for some reason, such as deferred probe or the driver being a loadable
+ * module, the real console hasn't registered yet at this point, there will
+ * be a brief interval in which no messages are logged to the console, which
+ * makes it difficult to diagnose problems that occur during this time.
+ *
+ * To mitigate this problem somewhat, only unregister consoles whose memory
+ * intersects with the init section. Note that code exists elsewhere to get
+ * rid of the boot console as soon as the proper console shows up, so there
+ * won't be side-effects from postponing the removal.
+ */
 static int __init printk_late_init(void)
 {
 	struct console *con;
 
 	for_each_console(con) {
 		if (!keep_bootcon && con->flags & CON_BOOT) {
-			unregister_console(con);
+			/*
+			 * Make sure to unregister boot consoles whose data
+			 * resides in the init section before the init section
+			 * is discarded. Boot consoles whose data will stick
+			 * around will automatically be unregistered when the
+			 * proper console replaces them.
+			 */
+			if (init_section_intersects(con, sizeof(*con)))
+				unregister_console(con);
 		}
 	}
 	hotcpu_notifier(console_cpu_notify, 0);
-- 
2.5.0
