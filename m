Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33868 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388406AbfDRJHG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 05:07:06 -0400
Message-ID: <20190418084253.534580989@linutronix.de>
Date: Thu, 18 Apr 2019 10:41:24 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 05/29] proc: Simplify task stack retrieval
References: <20190418084119.056416939@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418084124.-Dr86STmOHUfCiGnYQYb5NGsQrbVF85o5Zfj4_pyUOw@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/base.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -407,7 +407,6 @@ static void unlock_trace(struct task_str
 static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
-	struct stack_trace trace;
 	unsigned long *entries;
 	int err;
 
@@ -430,20 +429,17 @@ static int proc_pid_stack(struct seq_fil
 	if (!entries)
 		return -ENOMEM;
 
-	trace.nr_entries	= 0;
-	trace.max_entries	= MAX_STACK_TRACE_DEPTH;
-	trace.entries		= entries;
-	trace.skip		= 0;
-
 	err = lock_trace(task);
 	if (!err) {
-		unsigned int i;
+		unsigned int i, nr_entries;
 
-		save_stack_trace_tsk(task, &trace);
+		nr_entries = stack_trace_save_tsk(task, entries,
+						  MAX_STACK_TRACE_DEPTH, 0);
 
-		for (i = 0; i < trace.nr_entries; i++) {
+		for (i = 0; i < nr_entries; i++) {
 			seq_printf(m, "[<0>] %pB\n", (void *)entries[i]);
 		}
+
 		unlock_trace(task);
 	}
 	kfree(entries);
