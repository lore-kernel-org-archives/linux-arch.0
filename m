Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34090 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388571AbfDRJHj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 05:07:39 -0400
Message-ID: <20190418084255.561045203@linutronix.de>
Date: Thu, 18 Apr 2019 10:41:46 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 27/29] lib/stackdepot: Remove obsolete functions
References: <20190418084119.056416939@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418084146.ubeQZlAeIDNIx3GzWKjyjfNB9us6ZuF6FNtJSJ7QJ8s@z>

No more users of the struct stack_trace based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexander Potapenko <glider@google.com>
---
 include/linux/stackdepot.h |    4 ----
 lib/stackdepot.c           |   20 --------------------
 2 files changed, 24 deletions(-)

--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -23,13 +23,9 @@
 
 typedef u32 depot_stack_handle_t;
 
-struct stack_trace;
-
-depot_stack_handle_t depot_save_stack(struct stack_trace *trace, gfp_t flags);
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace);
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -212,14 +212,6 @@ unsigned int stack_depot_fetch(depot_sta
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
-{
-	unsigned int nent = stack_depot_fetch(handle, &trace->entries);
-
-	trace->max_entries = trace->nr_entries = nent;
-}
-EXPORT_SYMBOL_GPL(depot_fetch_stack);
-
 /**
  * stack_depot_save - Save a stack trace from an array
  *
@@ -314,15 +306,3 @@ depot_stack_handle_t stack_depot_save(un
 	return retval;
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
-
-/**
- * depot_save_stack - save stack in a stack depot.
- * @trace - the stacktrace to save.
- * @alloc_flags - flags for allocating additional memory if required.
- */
-depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
-				      gfp_t alloc_flags)
-{
-	return stack_depot_save(trace->entries, trace->nr_entries, alloc_flags);
-}
-EXPORT_SYMBOL_GPL(depot_save_stack);
