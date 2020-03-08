From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v2 01/12] task_isolation: vmstat: add quiet_vmstat_sync
 function
Date: Sun, 8 Mar 2020 03:44:11 +0000
Message-ID: <3118206b99e862d4c163eefd086af14dd12fe305.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Content-Language: en-US
Content-ID: <34D5BF63C3F7774795D2B302FE3EC1E3@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, Prasun Kapoor <pkapoor@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

From: Chris Metcalf <cmetcalf@mellanox.com>

In commit f01f17d3705b ("mm, vmstat: make quiet_vmstat lighter")
the quiet_vmstat() function became asynchronous, in the sense that
the vmstat work was still scheduled to run on the core when the
function returned.  For task isolation, we need a synchronous
version of the function that guarantees that the vmstat worker
will not run on the core on return from the function.  Add a
quiet_vmstat_sync() function with that semantic.

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
Signed-off-by: Alex Belits <abelits@marvell.com>
---
 include/linux/vmstat.h | 2 ++
 mm/vmstat.c            | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 292485f3d24d..2bc5e85f2514 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -270,6 +270,7 @@ extern void __dec_zone_state(struct zone *, enum zone_stat_item);
 extern void __dec_node_state(struct pglist_data *, enum node_stat_item);
 
 void quiet_vmstat(void);
+void quiet_vmstat_sync(void);
 void cpu_vm_stats_fold(int cpu);
 void refresh_zone_stat_thresholds(void);
 
@@ -372,6 +373,7 @@ static inline void __dec_node_page_state(struct page *page,
 static inline void refresh_zone_stat_thresholds(void) { }
 static inline void cpu_vm_stats_fold(int cpu) { }
 static inline void quiet_vmstat(void) { }
+static inline void quiet_vmstat_sync(void) { }
 
 static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_pageset *pset) { }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..1fa0b2d04afa 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1870,6 +1870,15 @@ void quiet_vmstat(void)
 	refresh_cpu_vm_stats(false);
 }
 
+/*
+ * Synchronously quiet vmstat so the work is guaranteed not to run on return.
+ */
+void quiet_vmstat_sync(void)
+{
+	cancel_delayed_work_sync(this_cpu_ptr(&vmstat_work));
+	refresh_cpu_vm_stats(false);
+}
+
 /*
  * Shepherd worker thread that checks the
  * differentials of processors that have their worker
-- 
2.20.1
