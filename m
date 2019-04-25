Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57937 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbfDYKAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 06:00:12 -0400
Message-ID: <20190425094802.533968922@linutronix.de>
Date: Thu, 25 Apr 2019 11:45:08 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 15/29] dm persistent data: Simplify stack trace handling
References: <20190425094453.875139013@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, Miroslav Benes <mbenes@suse.cz>, linux-arch@vger.kernel.org
Message-ID: <20190425094508.hGsT79oKAa-EoyFGWpoxVIxbb2vrFs8HwZI609Jm70s@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface. This results in less storage space and
indirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
---
 drivers/md/persistent-data/dm-block-manager.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -35,7 +35,10 @@
 #define MAX_HOLDERS 4
 #define MAX_STACK 10
 
-typedef unsigned long stack_entries[MAX_STACK];
+struct stack_store {
+	unsigned int	nr_entries;
+	unsigned long	entries[MAX_STACK];
+};
 
 struct block_lock {
 	spinlock_t lock;
@@ -44,8 +47,7 @@ struct block_lock {
 	struct task_struct *holders[MAX_HOLDERS];
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	struct stack_trace traces[MAX_HOLDERS];
-	stack_entries entries[MAX_HOLDERS];
+	struct stack_store traces[MAX_HOLDERS];
 #endif
 };
 
@@ -73,7 +75,7 @@ static void __add_holder(struct block_lo
 {
 	unsigned h = __find_holder(lock, NULL);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	struct stack_trace *t;
+	struct stack_store *t;
 #endif
 
 	get_task_struct(task);
@@ -81,11 +83,7 @@ static void __add_holder(struct block_lo
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 	t = lock->traces + h;
-	t->nr_entries = 0;
-	t->max_entries = MAX_STACK;
-	t->entries = lock->entries[h];
-	t->skip = 2;
-	save_stack_trace(t);
+	t->nr_entries = stack_trace_save(t->entries, MAX_STACK, 2);
 #endif
 }
 
@@ -106,7 +104,8 @@ static int __check_holder(struct block_l
 			DMERR("recursive lock detected in metadata");
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 			DMERR("previously held here:");
-			print_stack_trace(lock->traces + i, 4);
+			stack_trace_print(lock->traces[i].entries,
+					  lock->traces[i].nr_entries, 4);
 
 			DMERR("subsequent acquisition attempted here:");
 			dump_stack();
