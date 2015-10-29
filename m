From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/2] printk: Only unregister boot consoles when necessary
Date: Thu, 29 Oct 2015 09:26:07 +0100
Message-ID: <1446107167-7001-2-git-send-email-thierry.reding@gmail.com>
References: <1446107167-7001-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446107167-7001-1-git-send-email-thierry.reding@gmail.com>
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
 kernel/printk/printk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b16f35487b67..6164b6f48930 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -48,6 +48,7 @@
 #include <linux/uio.h>
 
 #include <asm/uaccess.h>
+#include <asm-generic/sections.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/printk.h>
@@ -2661,7 +2662,8 @@ static int __init printk_late_init(void)
 
 	for_each_console(con) {
 		if (!keep_bootcon && con->flags & CON_BOOT) {
-			unregister_console(con);
+			if (init_section_contains(con, sizeof(*con)))
+				unregister_console(con);
 		}
 	}
 	hotcpu_notifier(console_cpu_notify, 0);
-- 
2.5.0
