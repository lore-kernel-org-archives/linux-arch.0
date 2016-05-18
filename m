From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: disable fault around on emulated access bit architecture
Date: Wed, 18 May 2016 10:42:29 +0900
Message-ID: <20160518014229.GB21538@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vinayak Menon <vinmenon@codeaurora.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, mgorman@suse.de, vbabka@suse.cz, kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com, hughd@google.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 17, 2016 at 03:34:23PM +0300, Kirill A. Shutemov wrote:
> On Mon, May 16, 2016 at 11:56:32PM +0900, Minchan Kim wrote:
> > On Mon, May 16, 2016 at 05:29:00PM +0300, Kirill A. Shutemov wrote:
> > > > Kirill,
> > > > You wanted to test non-HW access bit system and I did.
> > > > What's your opinion?
> > > 
> > > Sorry, for late response.
> > > 
> > > My patch is incomlete: we need to find a way to not mark pte as old if we
> > > handle page fault for the address the pte represents.
> > 
> > I'm sure you can handle it but my point is there wouldn't be a big gain
> > although you can handle it in non-HW access bit system. Okay, let's be
> > more clear because I don't have every non-HW access bit architecture.
> > At least, current mobile workload in ARM which I have wouldn't be huge
> > benefit.
> > I will say one more.
> > I tested the workload on quad-core system and core speed is not so slow
> > compared to recent other mobile phone SoC. Even when I tested the benchmark
> > without pte_mkold, the benefit is within noise because storage is really
> > slow so major fault is dominant factor. So, I decide test storage from eMMC
> > to eSATA. And then finally, I manage to see the a little beneift with
> > fault_around without pte_mkold.
> > 
> > However, let's consider side-effect aspect from fault_around.
> > 
> > 1. Increase slab shrinking compard to old
> > 2. high level vmpressure compared to old
> > 
> > With considering that regressions on my system, it's really not worth to
> > try at the moment.
> > That's why I wanted to disable fault_around as default in non-HW access
> > bit system.
> 
> Feel free to post such patch. I guess it's reasonable.

From d926a2a19cd0921b34279c3f6a3bae8b7508646d Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 18 May 2016 08:36:59 +0900
Subject: [PATCH] mm: disable fault around on emulated access bit architecture

The fault_around aims for reducing minor fault of file-backed pages
via speculative ahead pte mapping with relying on readahead logic.
However, on non-HW access bit architecture, the benefit is highly
limited because they should emulate young bit with minor fault
for page aging algorithm of reclaim. IOW, we cannot reduce minor fault
on those architectures.

I did quick test in my ARM machine.

512M file mmap sequential every word read on eSATA drive with 4 times.
stdev is stable.

= fault_around 4096 =
elapsed time(usec): 6747645

= fault_around 65536 =
elapsed time(usec): 6709263

0.5% gain.

Even, when I tested it with eMMC, there is no gain because I guess
with slow storage, major fault is more dominant factor.

As well, fault_around has side effect to shrink slab more aggressively
and higher vmpressure so if such speculation fails, it can evict slab
more which can result in page I/O(e.g., inode cache), in the end,
it would make void benefit of fault_around.

So let's make default disable on those architectures.

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index b762b17aa4c5..9f652fdc0295 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2897,8 +2897,16 @@ void do_set_pte(struct vm_area_struct *vma, unsigned long address,
 	update_mmu_cache(vma, address, pte);
 }
 
+/*
+ * If architecture emulates "accessed" or "young" bit without HW support,
+ * there is no much gain with fault_around.
+ */
 static unsigned long fault_around_bytes __read_mostly =
+#ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+	PAGE_SIZE;
+#else
 	rounddown_pow_of_two(65536);
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 static int fault_around_bytes_get(void *data, u64 *val)
-- 
1.9.1


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
