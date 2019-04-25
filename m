Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbfDYKAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 06:00:09 -0400
Message-ID: <20190425094802.338890064@linutronix.de>
Date: Thu, 25 Apr 2019 11:45:06 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 13/29] btrfs: ref-verify: Simplify stack trace retrieval
References: <20190425094453.875139013@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, Miroslav Benes <mbenes@suse.cz>, linux-arch@vger.kernel.org
Message-ID: <20190425094506.r7Z82btjX8wWxBBfa23HoBn3KK8zATt43cSxS9Z0STY@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
---
 fs/btrfs/ref-verify.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -205,28 +205,17 @@ static struct root_entry *lookup_root_en
 #ifdef CONFIG_STACKTRACE
 static void __save_stack_trace(struct ref_action *ra)
 {
-	struct stack_trace stack_trace;
-
-	stack_trace.max_entries = MAX_TRACE;
-	stack_trace.nr_entries = 0;
-	stack_trace.entries = ra->trace;
-	stack_trace.skip = 2;
-	save_stack_trace(&stack_trace);
-	ra->trace_len = stack_trace.nr_entries;
+	ra->trace_len = stack_trace_save(ra->trace, MAX_TRACE, 2);
 }
 
 static void __print_stack_trace(struct btrfs_fs_info *fs_info,
 				struct ref_action *ra)
 {
-	struct stack_trace trace;
-
 	if (ra->trace_len == 0) {
 		btrfs_err(fs_info, "  ref-verify: no stacktrace");
 		return;
 	}
-	trace.nr_entries = ra->trace_len;
-	trace.entries = ra->trace;
-	print_stack_trace(&trace, 2);
+	stack_trace_print(ra->trace, ra->trace_len, 2);
 }
 #else
 static void inline __save_stack_trace(struct ref_action *ra)
