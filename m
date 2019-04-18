Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34070 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388519AbfDRJHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 05:07:32 -0400
Message-ID: <20190418084254.082820685@linutronix.de>
Date: Thu, 18 Apr 2019 10:41:30 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 11/29] fault-inject: Simplify stacktrace retrieval
References: <20190418084119.056416939@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Akinobu Mita <akinobu.mita@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418084130.Yxu9ePN7Gv3blwqgs8tE5BQlCu4e8wsvSAB6g99H7WM@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 lib/fault-inject.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -65,22 +65,16 @@ static bool fail_task(struct fault_attr
 
 static bool fail_stacktrace(struct fault_attr *attr)
 {
-	struct stack_trace trace;
 	int depth = attr->stacktrace_depth;
 	unsigned long entries[MAX_STACK_TRACE_DEPTH];
-	int n;
+	int n, nr_entries;
 	bool found = (attr->require_start == 0 && attr->require_end == ULONG_MAX);
 
 	if (depth == 0)
 		return found;
 
-	trace.nr_entries = 0;
-	trace.entries = entries;
-	trace.max_entries = depth;
-	trace.skip = 1;
-
-	save_stack_trace(&trace);
-	for (n = 0; n < trace.nr_entries; n++) {
+	nr_entries = stack_trace_save(entries, depth, 1);
+	for (n = 0; n < nr_entries; n++) {
 		if (attr->reject_start <= entries[n] &&
 			       entries[n] < attr->reject_end)
 			return false;
