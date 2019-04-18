Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbfDRJHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 05:07:31 -0400
Message-ID: <20190418084255.275696472@linutronix.de>
Date: Thu, 18 Apr 2019 10:41:43 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 24/29] tracing: Remove the last struct stack_trace usage
References: <20190418084119.056416939@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418084143.uS7JE1NDBwm_2JPePJ1_nMwCpQEIBTH1JLoH2Gwm_xk@z>

Simplify the stack retrieval code by using the storage array based
interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/trace/trace_stack.c |   42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -23,16 +23,7 @@
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES];
 static unsigned stack_trace_index[STACK_TRACE_ENTRIES];
 
-/*
- * Reserve one entry for the passed in ip. This will allow
- * us to remove most or all of the stack size overhead
- * added by the stack tracer itself.
- */
-struct stack_trace stack_trace_max = {
-	.max_entries		= STACK_TRACE_ENTRIES - 1,
-	.entries		= &stack_dump_trace[0],
-};
-
+static unsigned int stack_trace_entries;
 static unsigned long stack_trace_max_size;
 static arch_spinlock_t stack_trace_max_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
@@ -49,10 +40,10 @@ static void print_max_stack(void)
 
 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   stack_trace_max.nr_entries);
+			   stack_trace_entries);
 
-	for (i = 0; i < stack_trace_max.nr_entries; i++) {
-		if (i + 1 == stack_trace_max.nr_entries)
+	for (i = 0; i < stack_trace_entries; i++) {
+		if (i + 1 == stack_trace_entries)
 			size = stack_trace_index[i];
 		else
 			size = stack_trace_index[i] - stack_trace_index[i+1];
@@ -98,13 +89,12 @@ static void check_stack(unsigned long ip
 
 	stack_trace_max_size = this_size;
 
-	stack_trace_max.nr_entries = 0;
-	stack_trace_max.skip = 0;
-
-	save_stack_trace(&stack_trace_max);
+	stack_trace_entries = stack_trace_save(stack_dump_trace,
+					       ARRAY_SIZE(stack_dump_trace) - 1,
+					       0);
 
 	/* Skip over the overhead of the stack tracer itself */
-	for (i = 0; i < stack_trace_max.nr_entries; i++) {
+	for (i = 0; i < stack_trace_entries; i++) {
 		if (stack_dump_trace[i] == ip)
 			break;
 	}
@@ -113,7 +103,7 @@ static void check_stack(unsigned long ip
 	 * Some archs may not have the passed in ip in the dump.
 	 * If that happens, we need to show everything.
 	 */
-	if (i == stack_trace_max.nr_entries)
+	if (i == stack_trace_entries)
 		i = 0;
 
 	/*
@@ -131,13 +121,13 @@ static void check_stack(unsigned long ip
 	 * loop will only happen once. This code only takes place
 	 * on a new max, so it is far from a fast path.
 	 */
-	while (i < stack_trace_max.nr_entries) {
+	while (i < stack_trace_entries) {
 		int found = 0;
 
 		stack_trace_index[x] = this_size;
 		p = start;
 
-		for (; p < top && i < stack_trace_max.nr_entries; p++) {
+		for (; p < top && i < stack_trace_entries; p++) {
 			/*
 			 * The READ_ONCE_NOCHECK is used to let KASAN know that
 			 * this is not a stack-out-of-bounds error.
@@ -168,7 +158,7 @@ static void check_stack(unsigned long ip
 			i++;
 	}
 
-	stack_trace_max.nr_entries = x;
+	stack_trace_entries = x;
 
 	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
@@ -270,7 +260,7 @@ static void *
 {
 	long n = *pos - 1;
 
-	if (n >= stack_trace_max.nr_entries)
+	if (n >= stack_trace_entries)
 		return NULL;
 
 	m->private = (void *)n;
@@ -334,7 +324,7 @@ static int t_show(struct seq_file *m, vo
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   stack_trace_max.nr_entries);
+			   stack_trace_entries);
 
 		if (!stack_tracer_enabled && !stack_trace_max_size)
 			print_disabled(m);
@@ -344,10 +334,10 @@ static int t_show(struct seq_file *m, vo
 
 	i = *(long *)v;
 
-	if (i >= stack_trace_max.nr_entries)
+	if (i >= stack_trace_entries)
 		return 0;
 
-	if (i + 1 == stack_trace_max.nr_entries)
+	if (i + 1 == stack_trace_entries)
 		size = stack_trace_index[i];
 	else
 		size = stack_trace_index[i] - stack_trace_index[i+1];
