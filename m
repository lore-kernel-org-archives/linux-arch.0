Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387540AbfDYKAG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 06:00:06 -0400
Message-ID: <20190425094802.248658135@linutronix.de>
Date: Thu, 25 Apr 2019 11:45:05 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 12/29] dma/debug: Simplify stracktrace retrieval
References: <20190425094453.875139013@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, Miroslav Benes <mbenes@suse.cz>, linux-arch@vger.kernel.org
Message-ID: <20190425094505.uZ1-oFAtqSA4sBN87wxK-sle6SusNjcKgRYUZCPm2ek@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/debug.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -89,8 +89,8 @@ struct dma_debug_entry {
 	int		 sg_mapped_ents;
 	enum map_err_types  map_err_type;
 #ifdef CONFIG_STACKTRACE
-	struct		 stack_trace stacktrace;
-	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
+	unsigned int	stack_len;
+	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
 #endif
 };
 
@@ -174,7 +174,7 @@ static inline void dump_entry_trace(stru
 #ifdef CONFIG_STACKTRACE
 	if (entry) {
 		pr_warning("Mapped at:\n");
-		print_stack_trace(&entry->stacktrace, 0);
+		stack_trace_print(entry->stack_entries, entry->stack_len, 0);
 	}
 #endif
 }
@@ -704,12 +704,10 @@ static struct dma_debug_entry *dma_entry
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
 #ifdef CONFIG_STACKTRACE
-	entry->stacktrace.max_entries = DMA_DEBUG_STACKTRACE_ENTRIES;
-	entry->stacktrace.entries = entry->st_entries;
-	entry->stacktrace.skip = 1;
-	save_stack_trace(&entry->stacktrace);
+	entry->stack_len = stack_trace_save(entry->stack_entries,
+					    ARRAY_SIZE(entry->stack_entries),
+					    1);
 #endif
-
 	return entry;
 }
 
