From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2 25/25] SMP, trivial: remove unused code from smp_boot.h
Date: Thu, 12 Sep 2013 00:07:29 +0800
Message-ID: <1378915649-16395-26-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

Function smpboot_thread_schedule() is never defined or used,
so remove it from smp_boot.h.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
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
