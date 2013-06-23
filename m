Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:42959 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab3FWNnV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 23 Jun 2013 09:43:21 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sun, 23 Jun 2013 23:28:55 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 08/45] CPU hotplug: Convert preprocessor macros to static
 inline functions
Date: Sun, 23 Jun 2013 19:09:55 +0530
Message-ID: <20130623133951.19094.35173.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com, vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, fweisbec@gmail.com, zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Message-ID: <20130623133955.UH0x_vh4Se_v5gVO0i1-mTRlB2xcl7atWJKeJrlwQiI@z>

Convert the macros in the CPU hotplug code to static inline C functions.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/cpu.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index e06c3ad..d91919b 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -200,10 +200,8 @@ static inline void cpu_hotplug_driver_unlock(void)
 
 #else		/* CONFIG_HOTPLUG_CPU */
 
-#define get_online_cpus()	do { } while (0)
-#define put_online_cpus()	do { } while (0)
-#define cpu_hotplug_disable()	do { } while (0)
-#define cpu_hotplug_enable()	do { } while (0)
+static inline void get_online_cpus(void) {}
+static inline void put_online_cpus(void) {}
 
 static inline unsigned int get_online_cpus_atomic(void)
 {
@@ -220,6 +218,9 @@ static inline void put_online_cpus_atomic(void)
 	preempt_enable();
 }
 
+static inline void cpu_hotplug_disable(void) {}
+static inline void cpu_hotplug_enable(void) {}
+
 #define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 /* These aren't inline functions due to a GCC bug. */
 #define register_hotcpu_notifier(nb)	({ (void)(nb); 0; })

