From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/16] procfs: remove CONFIG_HARDWALL dependency
Date: Wed, 14 Mar 2018 15:37:37 +0100
Message-ID: <20180314143755.1508262-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Alexey Dobriyan <adobriyan@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Michal Hocko <mhocko@suse.com>
List-Id: linux-arch.vger.kernel.org

Hardwall is a tile specific feature, and with the removal of the
tile architecture, this has become dead code, so let's remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/proc/base.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9298324325ed..d53246863cfb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,9 +94,6 @@
 #include <linux/sched/stat.h>
 #include <linux/flex_array.h>
 #include <linux/posix-timers.h>
-#ifdef CONFIG_HARDWALL
-#include <asm/hardwall.h>
-#endif
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3002,9 +2999,6 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
 #endif
-#ifdef CONFIG_HARDWALL
-	ONE("hardwall",   S_IRUGO, proc_pid_hardwall),
-#endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
@@ -3393,9 +3387,6 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	ONE("io",	S_IRUSR, proc_tid_io_accounting),
 #endif
-#ifdef CONFIG_HARDWALL
-	ONE("hardwall",   S_IRUGO, proc_pid_hardwall),
-#endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
-- 
2.9.0
