Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:2225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfGLIMP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Jul 2019 04:12:15 -0400
Subject: Re: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <CAEiAFz238Ywgn6iDAz9gM_3PgPhs-YuAVDptehUBv7MRRPx8Cw@mail.gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <95683b80-f694-cf34-73fc-e6ec05462ee0@huawei.com>
Date: Fri, 12 Jul 2019 16:12:05 +0800
MIME-Version: 1.0
In-Reply-To: <CAEiAFz238Ywgn6iDAz9gM_3PgPhs-YuAVDptehUBv7MRRPx8Cw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Glauber <jglauber@marvell.com>, Alex Kogan <alex.kogan@oracle.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, "longman@redhat.com" <longman@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>, "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>, "dave.dice@oracle.com" <dave.dice@oracle.com>, "rahul.x.yadav@oracle.com" <rahul.x.yadav@oracle.com>
Message-ID: <20190712081205.XNLKCqLxn4X3njht99yEGk-OzQz4ZCEsj3Bp68j85z0@z>

On 2019/7/3 19:58, Jan Glauber wrote:
> Hi Alex,
> I've tried this series on arm64 (ThunderX2 with up to SMT=4  and 224 CPUs)
> with the borderline testcase of accessing a single file from all
> threads. With that
> testcase the qspinlock slowpath is the top spot in the kernel.
> 
> The results look really promising:
> 
> CPUs    normal    numa-qspinlocks
> ---------------------------------------------
> 56        149.41          73.90
> 224      576.95          290.31
> 
> Also frontend-stalls are reduced to 50% and interconnect traffic is
> greatly reduced.
> Tested-by: Jan Glauber <jglauber@marvell.com>

Tested this patchset on Kunpeng920 ARM64 server (96 cores,
4 NUMA nodes), and with the same test case from Jan, I can
see 150%+ boost! (Need to add a patch below [1].)

For the real workload such as Nginx I can see about 10%
performance improvement as well.

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Please cc me for new versions and I'm willing to test it.

Thanks
Hanjun

[1]
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 657bbc5..72c1346 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -792,6 +792,20 @@ config NODES_SHIFT
          Specify the maximum number of NUMA Nodes available on the target
          system.  Increases memory reserved to accommodate various tables.

+config NUMA_AWARE_SPINLOCKS
+ bool "Numa-aware spinlocks"
+ depends on NUMA
+ default y
+ help
+   Introduce NUMA (Non Uniform Memory Access) awareness into
+   the slow path of spinlocks.
+
+   The kernel will try to keep the lock on the same node,
+   thus reducing the number of remote cache misses, while
+   trading some of the short term fairness for better performance.
+
+   Say N if you want absolute first come first serve fairness.
+
 config USE_PERCPU_NUMA_NODE_ID
        def_bool y
        depends on NUMA
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 2994167..be5dd44 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -4,7 +4,7 @@
 #endif

 #include <linux/random.h>
-
+#include <linux/topology.h>
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
  *
@@ -170,7 +170,7 @@ static __always_inline void cna_init_node(struct mcs_spinlock *node, int cpuid,
                                          u32 tail)
 {
        if (decode_numa_node(node->node_and_count) == -1)
-           store_numa_node(node, numa_cpu_node(cpuid));
+         store_numa_node(node, cpu_to_node(cpuid));
        node->encoded_tail = tail;
 }
