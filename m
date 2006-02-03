Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:27095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932155AbWBCJUF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2006 04:20:05 -0500
Date: Fri, 3 Feb 2006 01:18:35 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: percpu data changes
Message-Id: <20060203011835.556f5199.akpm@osdl.org>
In-Reply-To: <20060203011748.6fe3fee3.akpm@osdl.org>
References: <20060203011748.6fe3fee3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: starvik@axis.com, dhowells@redhat.com, kyle@parisc-linux.org, anton@samba.org, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, wli@holomorphy.com, ak@muc.de, chris@zankel.net, phil.el@wanadoo.fr, nathans@sgi.com, axboe@suse.de, linux-arch@vger.kernel.org, dada1@cosmosbay.com
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@osdl.org> wrote:
>
> I have a patch queued up (for 2.6.16) which fixes most users of percpu
>  data.  Make them use for_each_cpu().  I'll send that in a moment.


From: Eric Dumazet <dada1@cosmosbay.com>

percpu_data blindly allocates bootmem memory to store NR_CPUS instances of
cpudata, instead of allocating memory only for possible cpus.

As a preparation for changing that, we need to convert various 0 -> NR_CPUS
loops to use for_each_cpu().

(The above only applies to users of asm-generic/percpu.h.  powerpc has gone it
alone and is presently only allocating memory for present CPUs, so t's
currently corrupting memory).

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jens Axboe <axboe@suse.de>
Acked-by: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>
Cc: Anton Blanchard <anton@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/nmi.c |    2 +-
 block/ll_rw_blk.c      |    2 +-
 drivers/scsi/scsi.c    |    2 +-
 fs/file.c              |    3 +--
 kernel/sched.c         |    2 +-
 net/core/utils.c       |    2 +-
 net/ipv4/proc.c        |    2 +-
 net/ipv6/proc.c        |    2 +-
 net/socket.c           |    2 +-
 main.c                 |    0 
 10 files changed, 9 insertions(+), 10 deletions(-)

diff -puN arch/i386/kernel/nmi.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject arch/i386/kernel/nmi.c
--- devel/arch/i386/kernel/nmi.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/arch/i386/kernel/nmi.c	2006-02-02 23:53:35.000000000 -0800
@@ -138,7 +138,7 @@ static int __init check_nmi_watchdog(voi
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
diff -puN block/ll_rw_blk.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject block/ll_rw_blk.c
--- devel/block/ll_rw_blk.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/block/ll_rw_blk.c	2006-02-02 23:53:34.000000000 -0800
@@ -3453,7 +3453,7 @@ int __init blk_dev_init(void)
 	iocontext_cachep = kmem_cache_create("blkdev_ioc",
 			sizeof(struct io_context), 0, SLAB_PANIC, NULL, NULL);
 
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
 
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq, NULL);
diff -puN drivers/scsi/scsi.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject drivers/scsi/scsi.c
--- devel/drivers/scsi/scsi.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/drivers/scsi/scsi.c	2006-02-02 23:53:34.000000000 -0800
@@ -1245,7 +1245,7 @@ static int __init init_scsi(void)
 	if (error)
 		goto cleanup_sysctl;
 
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		INIT_LIST_HEAD(&per_cpu(scsi_done_q, i));
 
 	devfs_mk_dir("scsi");
diff -puN fs/file.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject fs/file.c
--- devel/fs/file.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/fs/file.c	2006-02-02 23:53:35.000000000 -0800
@@ -379,7 +379,6 @@ static void __devinit fdtable_defer_list
 void __init files_defer_init(void)
 {
 	int i;
-	/* Really early - can't use for_each_cpu */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		fdtable_defer_list_init(i);
 }
diff -puN init/main.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject init/main.c
diff -puN kernel/sched.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject kernel/sched.c
--- devel/kernel/sched.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/kernel/sched.c	2006-02-02 23:53:35.000000000 -0800
@@ -6109,7 +6109,7 @@ void __init sched_init(void)
 	runqueue_t *rq;
 	int i, j, k;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
diff -puN net/core/utils.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject net/core/utils.c
--- devel/net/core/utils.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/net/core/utils.c	2006-02-02 23:53:34.000000000 -0800
@@ -121,7 +121,7 @@ void __init net_random_init(void)
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
 		__net_srandom(state, i+jiffies);
 	}
diff -puN net/ipv4/proc.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject net/ipv4/proc.c
--- devel/net/ipv4/proc.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/net/ipv4/proc.c	2006-02-02 23:53:34.000000000 -0800
@@ -49,7 +49,7 @@ static int fold_prot_inuse(struct proto 
 	int res = 0;
 	int cpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		res += proto->stats[cpu].inuse;
 
 	return res;
diff -puN net/ipv6/proc.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject net/ipv6/proc.c
--- devel/net/ipv6/proc.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/net/ipv6/proc.c	2006-02-02 23:53:34.000000000 -0800
@@ -38,7 +38,7 @@ static int fold_prot_inuse(struct proto 
 	int res = 0;
 	int cpu;
 
-	for (cpu=0; cpu<NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		res += proto->stats[cpu].inuse;
 
 	return res;
diff -puN net/socket.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject net/socket.c
--- devel/net/socket.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-02 23:53:34.000000000 -0800
+++ devel-akpm/net/socket.c	2006-02-02 23:53:34.000000000 -0800
@@ -2078,7 +2078,7 @@ void socket_seq_show(struct seq_file *se
 	int cpu;
 	int counter = 0;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		counter += per_cpu(sockets_in_use, cpu);
 
 	/* It can be negative, by the way. 8) */
_

