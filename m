Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfDYKBd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 06:01:33 -0400
Message-ID: <20190425094801.501919093@linutronix.de>
Date: Thu, 25 Apr 2019 11:44:57 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 04/29] backtrace-test: Simplify stack trace handling
References: <20190425094453.875139013@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, Miroslav Benes <mbenes@suse.cz>, linux-arch@vger.kernel.org
Message-ID: <20190425094457.t4PisWZkAiwPfB4RG5rljsc4Kx-GFbCtCVFiOKF1xjY@z>

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/backtracetest.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/kernel/backtracetest.c
+++ b/kernel/backtracetest.c
@@ -48,19 +48,14 @@ static void backtrace_test_irq(void)
 #ifdef CONFIG_STACKTRACE
 static void backtrace_test_saved(void)
 {
-	struct stack_trace trace;
 	unsigned long entries[8];
+	unsigned int nr_entries;
 
 	pr_info("Testing a saved backtrace.\n");
 	pr_info("The following trace is a kernel self test and not a bug!\n");
 
-	trace.nr_entries = 0;
-	trace.max_entries = ARRAY_SIZE(entries);
-	trace.entries = entries;
-	trace.skip = 0;
-
-	save_stack_trace(&trace);
-	print_stack_trace(&trace, 0);
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	stack_trace_print(entries, nr_entries, 0);
 }
 #else
 static void backtrace_test_saved(void)
