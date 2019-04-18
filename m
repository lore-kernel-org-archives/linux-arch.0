Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33927 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388426AbfDRJHM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 05:07:12 -0400
Message-ID: <20190418084253.811477032@linutronix.de>
Date: Thu, 18 Apr 2019 10:41:27 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 08/29] mm/kmemleak: Simplify stacktrace handling
References: <20190418084119.056416939@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418084127.jXRwtzWa1BNt7sAvbNAiG1ZnYYOqjZWcTeDkRyZeL3U@z>

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org
---
 mm/kmemleak.c |   24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -410,11 +410,6 @@ static void print_unreferenced(struct se
  */
 static void dump_object_info(struct kmemleak_object *object)
 {
-	struct stack_trace trace;
-
-	trace.nr_entries = object->trace_len;
-	trace.entries = object->trace;
-
 	pr_notice("Object 0x%08lx (size %zu):\n",
 		  object->pointer, object->size);
 	pr_notice("  comm \"%s\", pid %d, jiffies %lu\n",
@@ -424,7 +419,7 @@ static void dump_object_info(struct kmem
 	pr_notice("  flags = 0x%x\n", object->flags);
 	pr_notice("  checksum = %u\n", object->checksum);
 	pr_notice("  backtrace:\n");
-	print_stack_trace(&trace, 4);
+	stack_trace_print(object->trace, object->trace_len, 4);
 }
 
 /*
@@ -553,15 +548,7 @@ static struct kmemleak_object *find_and_
  */
 static int __save_stack_trace(unsigned long *trace)
 {
-	struct stack_trace stack_trace;
-
-	stack_trace.max_entries = MAX_TRACE;
-	stack_trace.nr_entries = 0;
-	stack_trace.entries = trace;
-	stack_trace.skip = 2;
-	save_stack_trace(&stack_trace);
-
-	return stack_trace.nr_entries;
+	return stack_trace_save(trace, MAX_TRACE, 2);
 }
 
 /*
@@ -2019,13 +2006,8 @@ early_param("kmemleak", kmemleak_boot_co
 
 static void __init print_log_trace(struct early_log *log)
 {
-	struct stack_trace trace;
-
-	trace.nr_entries = log->trace_len;
-	trace.entries = log->trace;
-
 	pr_notice("Early log backtrace:\n");
-	print_stack_trace(&trace, 2);
+	stack_trace_print(log->trace, log->trace_len, 2);
 }
 
 /*
