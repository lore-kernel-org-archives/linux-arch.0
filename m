From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 [resend] 18/18] SMP, trivial: remove unused code from smp_boot.h
Date: Mon, 16 Dec 2013 00:36:40 +0800
Message-ID: <1387125400-28849-19-git-send-email-liuj97@gmail.com>
References: <1387125400-28849-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387125400-28849-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Jiri Kosina <trivial@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@huawei.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Wang YanQing <udknight@gmail.com>, linux-arch@vger.kernel.org, Jiang Liu <liuj97@gmail.com>
List-Id: linux-arch.vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

Function smpboot_thread_schedule() is never defined or used,
so remove it from smp_boot.h.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <trivial@kernel.org>
Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 include/linux/smpboot.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 13e9296..d600afb 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -47,6 +47,5 @@ struct smp_hotplug_thread {
 
 int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread);
 void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thread);
-int smpboot_thread_schedule(void);
 
 #endif
-- 
1.8.1.2
