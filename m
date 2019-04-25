Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57664 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfDYJ7o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 05:59:44 -0400
Message-ID: <20190425094801.771410441@linutronix.de>
Date: Thu, 25 Apr 2019 11:45:00 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 07/29] mm/slub: Simplify stack trace retrieval
References: <20190425094453.875139013@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, Miroslav Benes <mbenes@suse.cz>, linux-arch@vger.kernel.org
Message-ID: <20190425094500.-j1axc5yb3_bwPvTFTlN9avy_pFrqxoz1Mch3qR4r-g@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
---
 mm/slub.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -552,18 +552,14 @@ static void set_track(struct kmem_cache
 
 	if (addr) {
 #ifdef CONFIG_STACKTRACE
-		struct stack_trace trace;
+		unsigned int nr_entries;
 
-		trace.nr_entries = 0;
-		trace.max_entries = TRACK_ADDRS_COUNT;
-		trace.entries = p->addrs;
-		trace.skip = 3;
 		metadata_access_enable();
-		save_stack_trace(&trace);
+		nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
 		metadata_access_disable();
 
-		if (trace.nr_entries < TRACK_ADDRS_COUNT)
-			p->addrs[trace.nr_entries] = 0;
+		if (nr_entries < TRACK_ADDRS_COUNT)
+			p->addrs[nr_entries] = 0;
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
