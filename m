Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 20:15:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050225201538.B27842@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston> <20050222090741.B16786@flint.arm.linux.org.uk> <20050222100858.27d05a86.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20050222100858.27d05a86.davem@davemloft.net>; from davem@davemloft.net on Tue, Feb 22, 2005 at 10:08:58AM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 22, 2005 at 10:08:58AM -0800, David S. Miller wrote:
> On Tue, 22 Feb 2005 09:07:41 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > On Tue, Feb 22, 2005 at 03:53:17PM +1100, Benjamin Herrenschmidt wrote:
> > > Is that ok with everybody ?
> > 
> > On the grounds that I can't get my MM changes past Linus which I need
> > for newer ARM CPUs, so I don't see why this change which adds extra code
> > (which is the complaint against my changes) should be considered.
> 
> It doesn't add extra code:
> 
> 1) the pte gets deref'd currently anyways
> 2) platforms not using the pte pointer arg will simply get that
>    argument optimized away
> 
> Russell, send me what you're having trouble merging under seperate
> cover and I'll give you a hand, from one old man to another :-)

Sorry David, I've been off doing other things for the last week or
so due to them being more personally interesting and productive than
chasing kernel stuff at the moment.

The item I was referring to was my flush_cache_page() changes from
January 11th (attached), posted to both linux-arch and lkml, and
previous to that in November some time, along with Linus' reply,
and my somewhat later reply.

To be completely honest, because it has been such a long time since
the solution was first developed, I no longer even know if this
solution still works.  I also suspect, since I don't follow VM
progress, that my knowledge of the VM is now rather out of date.

On the plus side, a couple of architecture people have come forward
to say that it could be beneficial to their architecture as well.

I just find it extremely hard to do these architecture-wide changes
and get them past Linus with little or no help from any other
architecture people, especially when I'm then asked to prove that
the changes do not hurt other architectures.

I'm not really expecting anyone to do lots of hard work on this
though... maybe just enough satisfaction feedback to from architecture
people to Linus will be sufficient.

The problem I now face is that we're almost at 2.6.11, and its been
almost three months, so I think it's safe to assume that Linus will
have forgotten everything about this, and will probably hate the
patch next time around.  But maybe I'm underestimating Linus.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

--SLDf9lqlvOQaIe6s
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <linux-arch-owner+rmk=40arm.linux.org.uk-S262919AbVAKWi0@vger.kernel.org>
Envelope-to: rmk@arm.linux.org.uk
Delivery-date: Tue, 11 Jan 2005 22:38:34 +0000
Received: from caramon.arm.linux.org.uk ([2002:d412:e8ba:1:a00:2bff:fe95:1d7b])
	by flint.arm.linux.org.uk with asmtp (Exim 4.41)
	id 1CoUeo-0003MJ-0g
	for rmk@arm.linux.org.uk; Tue, 11 Jan 2005 22:38:34 +0000
Received: from vger.kernel.org ([12.107.209.244])
	by caramon.arm.linux.org.uk with esmtp (Exim 4.41)
	id 1CoUel-0003gi-G8
	for rmk@arm.linux.org.uk; Tue, 11 Jan 2005 22:38:32 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbVAKWi0 (ORCPT <rfc822;rmk@arm.linux.org.uk>);
	Tue, 11 Jan 2005 17:38:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17930 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262882AbVAKWg7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Jan 2005 17:36:59 -0500
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CoUdB-0003gY-Sv; Tue, 11 Jan 2005 22:36:54 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1CoUdA-0003M3-QK; Tue, 11 Jan 2005 22:36:52 +0000
Date: Tue, 11 Jan 2005 22:36:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: Re: flush_cache_page()
Message-ID: <20050111223652.D30946@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: Russell King <rmk@arm.linux.org.uk>

Any responses on this?  Didn't get any last time I mailed this out.

I guess we're now at a point where we can start considering whether
to merge this or not.

However, since it's been rather a long time, I will need to go
back and redo this patch, along with all the other patches which
get ARMv6 VIPT aliasing caches working, and then confirm that this
does indeed end up with something which works.

I just don't want to go chasing my tail on something which essentially
is unacceptable.

----- Forwarded message from Russell King <rmk@arm.linux.org.uk> -----
Date:	Mon, 15 Nov 2004 20:37:44 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-arch@vger.kernel.org
Subject: Re: flush_cache_page()

On Thu, Aug 26, 2004 at 11:18:54AM -0700, Linus Torvalds wrote:
> On Thu, 26 Aug 2004, Russell King wrote:
> > 
> > Not quite.  Take an example of, say, two binaries mapped at 0x8000. With
> > one set of page tables, lets say physical address 0x1000 is mapped.  
> > The other process has physical address 0x2000 mapped there.
> 
> I'd have assumed that a virtual flush would just flush _all_ entries with 
> that virtual tag.
> 
> But if not, then I guess passing in the physical page wouldn't be too bad.
> 
> What do we have there? I assume it can't be "struct page *", since you
> might have mapped IO pages etc that don't have a "struct page" associated
> with them. So it would either have to be the PFN of the page, or the PTE
> entry. Are those available (or can they be made available easily?) in the
> routines that need this?
> 
> If the generic code would need to do a page table walk anyway to get the 
> information, then I'd just ask that you do it by hand.

It's been a while for this thread, but unfortunately other stuff took
precidence. 8(

I wish to widen the audience and include a patch for people to *think*
about and definitely _NOT_ (underlined in triplicate) for applying!

This merely changes all callsites of flush_cache_page to take the PFN
in addition to other stuff, so we know which alias of a VIPT write-back
cached system to flush - which newer ARM CPUs have.

I believe that there is an invariant that the page being flushed by
flush_cache_page() will also be mapped (someone who knows this stuff
better than me needs to confirm that), so I suspect this may be a win
for those who are walking page tables.

sh and sh64 people may like to note that this saves them walking the
page table - from the PFN they can derive the physical address directly.

Why a PFN ?  It seems to be the only data within easy reach for all
flush_cache_page callers... unless people don't object to finding
some way to pass a PTE from places like fs/binfmt_elf.c and
include/asm-*/cacheflush.h for copy_*_user_page().

TBH, I'm no longer convinced that this actually benefits anyone except
ARM VIPT CPUs, where knowing which alias to kick seems to be the right
thing to do... rather than the alternative of mapping all four aliases
and just flushing each 32 byte cache line in 16K just for the hell of
it for every 4K page.

Comments?

(PS, there is another way which jejb pointed out, and wants to implement
for PA-RISC, if given the chance.  However, although it sounded like a
good idea, it seems to be a fair amount of work to achieve it, and I'm
not entirely sure that it's appropriate at this time in the 2.6
lifecycle.)

===== arch/arm/mm/fault-armv.c 1.35 vs edited =====
--- 1.35/arch/arm/mm/fault-armv.c	2004-09-07 14:36:20 +01:00
+++ edited/arch/arm/mm/fault-armv.c	2004-11-15 19:43:50 +00:00
@@ -54,7 +54,7 @@
 	 * fault (ie, is old), we can safely ignore any issues.
 	 */
 	if (pte_present(entry) && pte_val(entry) & shared_pte_mask) {
-		flush_cache_page(vma, address);
+		flush_cache_page(vma, address, pte_pfn(entry));
 		pte_val(entry) &= ~shared_pte_mask;
 		set_pte(pte, entry);
 		flush_tlb_page(vma, address);
@@ -115,7 +115,7 @@
 	if (aliases)
 		adjust_pte(vma, addr);
 	else
-		flush_cache_page(vma, addr);
+		flush_cache_page(vma, addr, page_to_pfn(page));
 }
 
 /*
===== arch/arm/mm/flush.c 1.3 vs edited =====
--- 1.3/arch/arm/mm/flush.c	2004-09-07 14:36:20 +01:00
+++ edited/arch/arm/mm/flush.c	2004-11-15 19:43:50 +00:00
@@ -56,7 +56,7 @@
 		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		flush_cache_page(mpnt, mpnt->vm_start + offset);
+		flush_cache_page(mpnt, mpnt->vm_start + offset, page_to_pfn(page));
 		if (cache_is_vipt())
 			break;
 	}
===== arch/mips/mm/c-r3k.c 1.3 vs edited =====
--- 1.3/arch/mips/mm/c-r3k.c	2004-04-20 07:53:22 +01:00
+++ edited/arch/mips/mm/c-r3k.c	2004-11-15 20:00:12 +00:00
@@ -255,7 +255,7 @@
 }
 
 static void r3k_flush_cache_page(struct vm_area_struct *vma,
-	unsigned long page)
+	unsigned long page, unsigned long pfn)
 {
 }
 
===== arch/mips/mm/c-r4k.c 1.4 vs edited =====
--- 1.4/arch/mips/mm/c-r4k.c	2004-04-20 07:53:22 +01:00
+++ edited/arch/mips/mm/c-r4k.c	2004-11-15 20:00:12 +00:00
@@ -317,7 +317,7 @@
 }
 
 static void r4k_flush_cache_page(struct vm_area_struct *vma,
-					unsigned long page)
+				 unsigned long page, unsigned long pfn)
 {
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
===== arch/mips/mm/c-sb1.c 1.4 vs edited =====
--- 1.4/arch/mips/mm/c-sb1.c	2004-04-20 07:53:22 +01:00
+++ edited/arch/mips/mm/c-sb1.c	2004-11-15 20:00:12 +00:00
@@ -158,7 +158,7 @@
  * executable, nothing is required.
  */
 static void local_sb1_flush_cache_page(struct vm_area_struct *vma,
-	unsigned long addr)
+	unsigned long addr, unsigned long pfn)
 {
 	int cpu = smp_processor_id();
 
@@ -180,17 +180,18 @@
 struct flush_cache_page_args {
 	struct vm_area_struct *vma;
 	unsigned long addr;
+	unsigned long pfn;
 };
 
 static void sb1_flush_cache_page_ipi(void *info)
 {
 	struct flush_cache_page_args *args = info;
 
-	local_sb1_flush_cache_page(args->vma, args->addr);
+	local_sb1_flush_cache_page(args->vma, args->addr, args->pfn);
 }
 
 /* Dirty dcache could be on another CPU, so do the IPIs */
-static void sb1_flush_cache_page(struct vm_area_struct *vma, unsigned long addr)
+static void sb1_flush_cache_page(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
 {
 	struct flush_cache_page_args args;
 
@@ -200,10 +201,11 @@
 	addr &= PAGE_MASK;
 	args.vma = vma;
 	args.addr = addr;
+	args.pfn = pfn;
 	on_each_cpu(sb1_flush_cache_page_ipi, (void *) &args, 1, 1);
 }
 #else
-void sb1_flush_cache_page(struct vm_area_struct *vma, unsigned long addr)
+void sb1_flush_cache_page(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
 	__attribute__((alias("local_sb1_flush_cache_page")));
 #endif
 
===== arch/mips/mm/c-tx39.c 1.4 vs edited =====
--- 1.4/arch/mips/mm/c-tx39.c	2004-04-20 07:53:22 +01:00
+++ edited/arch/mips/mm/c-tx39.c	2004-11-15 20:00:12 +00:00
@@ -179,7 +179,7 @@
 }
 
 static void tx39_flush_cache_page(struct vm_area_struct *vma,
-				   unsigned long page)
+				   unsigned long page, unsigned long pfn)
 {
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
===== arch/mips/mm/cache.c 1.6 vs edited =====
--- 1.6/arch/mips/mm/cache.c	2004-04-20 07:53:22 +01:00
+++ edited/arch/mips/mm/cache.c	2004-11-15 19:57:04 +00:00
@@ -23,7 +23,8 @@
 void (*flush_cache_mm)(struct mm_struct *mm);
 void (*flush_cache_range)(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end);
-void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page);
+void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page,
+	unsigned long pfn);
 void (*flush_icache_range)(unsigned long start, unsigned long end);
 void (*flush_icache_page)(struct vm_area_struct *vma, struct page *page);
 
===== arch/sh/mm/cache-sh4.c 1.9 vs edited =====
--- 1.9/arch/sh/mm/cache-sh4.c	2004-10-19 06:26:44 +01:00
+++ edited/arch/sh/mm/cache-sh4.c	2004-11-15 20:04:20 +00:00
@@ -346,7 +346,7 @@
  *
  * ADDR: Virtual Address (U0 address)
  */
-void flush_cache_page(struct vm_area_struct *vma, unsigned long address)
+void flush_cache_page(struct vm_area_struct *vma, unsigned long address, unsigned long pfn)
 {
 	pgd_t *dir;
 	pmd_t *pmd;
===== arch/sh/mm/cache-sh7705.c 1.1 vs edited =====
--- 1.1/arch/sh/mm/cache-sh7705.c	2004-10-19 06:26:41 +01:00
+++ edited/arch/sh/mm/cache-sh7705.c	2004-11-15 20:04:19 +00:00
@@ -186,7 +186,7 @@
  *
  * ADDRESS: Virtual Address (U0 address)
  */
-void flush_cache_page(struct vm_area_struct *vma, unsigned long address)
+void flush_cache_page(struct vm_area_struct *vma, unsigned long address, unsigned long pfn)
 {
 	pgd_t *dir;
 	pmd_t *pmd;
===== arch/sh64/mm/cache.c 1.1 vs edited =====
--- 1.1/arch/sh64/mm/cache.c	2004-06-29 15:44:46 +01:00
+++ edited/arch/sh64/mm/cache.c	2004-11-15 20:03:28 +00:00
@@ -904,7 +904,7 @@
 
 /****************************************************************************/
 
-void flush_cache_page(struct vm_area_struct *vma, unsigned long eaddr)
+void flush_cache_page(struct vm_area_struct *vma, unsigned long eaddr, unsigned long pfn)
 {
 	/* Invalidate any entries in either cache for the vma within the user
 	   address space vma->vm_mm for the page starting at virtual address
===== fs/binfmt_elf.c 1.91 vs edited =====
--- 1.91/fs/binfmt_elf.c	2004-11-10 17:45:38 +00:00
+++ edited/fs/binfmt_elf.c	2004-11-15 19:43:50 +00:00
@@ -1533,7 +1533,7 @@
 					DUMP_SEEK (file->f_pos + PAGE_SIZE);
 				} else {
 					void *kaddr;
-					flush_cache_page(vma, addr);
+					flush_cache_page(vma, addr, page_to_pfn(page));
 					kaddr = kmap(page);
 					if ((size += PAGE_SIZE) > limit ||
 					    !dump_write(file, kaddr,
===== include/asm-alpha/cacheflush.h 1.4 vs edited =====
--- 1.4/include/asm-alpha/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-alpha/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -8,7 +8,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== include/asm-arm/cacheflush.h 1.18 vs edited =====
--- 1.18/include/asm-arm/cacheflush.h	2004-11-05 10:53:14 +00:00
+++ edited/include/asm-arm/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -237,16 +237,16 @@
  * space" model to handle this.
  */
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
-		flush_dcache_page(page);	\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
+		flush_dcache_page(page);			\
 	} while (0)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
 	} while (0)
 
 /*
@@ -269,7 +269,7 @@
 }
 
 static inline void
-flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr)
+flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
 	if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask)) {
 		unsigned long addr = user_addr & PAGE_MASK;
===== include/asm-arm26/cacheflush.h 1.3 vs edited =====
--- 1.3/include/asm-arm26/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-arm26/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -23,7 +23,7 @@
 #define flush_cache_all()                       do { } while (0)
 #define flush_cache_mm(mm)                      do { } while (0)
 #define flush_cache_range(vma,start,end)        do { } while (0)
-#define flush_cache_page(vma,vmaddr)            do { } while (0)
+#define flush_cache_page(vma,vmaddr,pfn)        do { } while (0)
 #define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
===== include/asm-cris/cacheflush.h 1.3 vs edited =====
--- 1.3/include/asm-cris/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-cris/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -10,7 +10,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== include/asm-h8300/cacheflush.h 1.3 vs edited =====
--- 1.3/include/asm-h8300/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-h8300/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -13,7 +13,7 @@
 #define flush_cache_all()
 #define	flush_cache_mm(mm)
 #define	flush_cache_range(vma,a,b)
-#define	flush_cache_page(vma,p)
+#define	flush_cache_page(vma,p,pfn)
 #define	flush_dcache_page(page)
 #define	flush_dcache_mmap_lock(mapping)
 #define	flush_dcache_mmap_unlock(mapping)
===== include/asm-i386/cacheflush.h 1.6 vs edited =====
--- 1.6/include/asm-i386/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-i386/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -8,7 +8,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== include/asm-ia64/cacheflush.h 1.6 vs edited =====
--- 1.6/include/asm-ia64/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-ia64/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -19,7 +19,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_icache_page(vma,page)		do { } while (0)
 #define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
===== include/asm-m32r/cacheflush.h 1.1 vs edited =====
--- 1.1/include/asm-m32r/cacheflush.h	2004-09-17 08:06:56 +01:00
+++ edited/include/asm-m32r/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -11,7 +11,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
@@ -31,7 +31,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
@@ -43,7 +43,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== include/asm-m68k/cacheflush.h 1.10 vs edited =====
--- 1.10/include/asm-m68k/cacheflush.h	2004-09-17 15:15:21 +01:00
+++ edited/include/asm-m68k/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -100,7 +100,8 @@
 }
 
 static inline void flush_cache_page(struct vm_area_struct *vma,
-				    unsigned long vmaddr)
+				    unsigned long vmaddr,
+				    unsigned long pfn)
 {
 	if (vma->vm_mm == current->mm)
 	        __flush_cache_030();
@@ -134,15 +135,15 @@
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
 	} while (0)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
 	} while (0)
 
 extern void flush_icache_range(unsigned long address, unsigned long endaddr);
===== include/asm-m68knommu/cacheflush.h 1.7 vs edited =====
--- 1.7/include/asm-m68knommu/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-m68knommu/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -9,7 +9,7 @@
 #define flush_cache_all()			__flush_cache_all()
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_range(start,len)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
===== include/asm-mips/cacheflush.h 1.6 vs edited =====
--- 1.6/include/asm-mips/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-mips/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -17,7 +17,7 @@
  *
  *  - flush_cache_all() flushes entire cache
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
- *  - flush_cache_page(mm, vmaddr) flushes a single page
+ *  - flush_cache_page(mm, vmaddr, pfn) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *  - flush_icache_range(start, end) flush a range of instructions
  *  - flush_dcache_page(pg) flushes(wback&invalidates) a page for dcache
@@ -35,7 +35,7 @@
 extern void (*flush_cache_range)(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma,
-	unsigned long page);
+	unsigned long page, unsigned long pfn);
 extern void __flush_dcache_page(struct page *page);
 
 static inline void flush_dcache_page(struct page *page)
===== include/asm-parisc/cacheflush.h 1.12 vs edited =====
--- 1.12/include/asm-parisc/cacheflush.h	2004-09-17 16:04:02 +01:00
+++ edited/include/asm-parisc/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -78,14 +78,14 @@
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do { \
-	flush_cache_page(vma, vaddr); \
+	flush_cache_page(vma, vaddr, page_to_pfn(page)); \
 	memcpy(dst, src, len); \
 	flush_kernel_dcache_range_asm((unsigned long)dst, (unsigned long)dst + len); \
 } while (0)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 do { \
-	flush_cache_page(vma, vaddr); \
+	flush_cache_page(vma, vaddr, page_to_pfn(page)); \
 	memcpy(dst, src, len); \
 } while (0)
 
@@ -181,7 +181,8 @@
 }
 
 static inline void
-flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr)
+flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
+		 unsigned long pfn)
 {
 	BUG_ON(!vma->vm_mm->context);
 
===== include/asm-ppc/cacheflush.h 1.8 vs edited =====
--- 1.8/include/asm-ppc/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-ppc/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -22,7 +22,7 @@
 #define flush_cache_all()		do { } while (0)
 #define flush_cache_mm(mm)		do { } while (0)
 #define flush_cache_range(vma, a, b)	do { } while (0)
-#define flush_cache_page(vma, p)	do { } while (0)
+#define flush_cache_page(vma, p, pfn)	do { } while (0)
 #define flush_icache_page(vma, page)	do { } while (0)
 #define flush_cache_vmap(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)	do { } while (0)
===== include/asm-ppc64/cacheflush.h 1.8 vs edited =====
--- 1.8/include/asm-ppc64/cacheflush.h	2004-05-30 20:50:14 +01:00
+++ edited/include/asm-ppc64/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -12,7 +12,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_icache_page(vma, page)		do { } while (0)
 #define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
===== include/asm-s390/cacheflush.h 1.4 vs edited =====
--- 1.4/include/asm-s390/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-s390/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -8,7 +8,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== include/asm-sh/cacheflush.h 1.3 vs edited =====
--- 1.3/include/asm-sh/cacheflush.h	2004-09-17 15:29:45 +01:00
+++ edited/include/asm-sh/cacheflush.h	2004-11-15 19:52:27 +00:00
@@ -15,14 +15,14 @@
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
-		flush_cache_page(vma, vaddr);			\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
 		memcpy(dst, src, len);				\
 		flush_icache_user_range(vma, page, vaddr, len);	\
 	} while (0)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
-		flush_cache_page(vma, vaddr);			\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
 		memcpy(dst, src, len);				\
 	} while (0)
 
===== include/asm-sh/cpu-sh2/cacheflush.h 1.2 vs edited =====
--- 1.2/include/asm-sh/cpu-sh2/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-sh/cpu-sh2/cacheflush.h	2004-11-15 19:56:22 +00:00
@@ -28,7 +28,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== include/asm-sh/cpu-sh3/cacheflush.h 1.4 vs edited =====
--- 1.4/include/asm-sh/cpu-sh3/cacheflush.h	2004-10-19 06:26:41 +01:00
+++ edited/include/asm-sh/cpu-sh3/cacheflush.h	2004-11-15 19:56:22 +00:00
@@ -15,7 +15,7 @@
  *
  *  - flush_cache_all() flushes entire cache
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
- *  - flush_cache_page(mm, vmaddr) flushes a single page
+ *  - flush_cache_page(mm, vmaddr, pfn) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *
  *  - flush_dcache_page(pg) flushes(wback&invalidates) a page for dcache
@@ -43,7 +43,8 @@
 extern void flush_cache_mm(struct mm_struct *mm);
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
                               unsigned long end);
-extern void flush_cache_page(struct vm_area_struct *vma, unsigned long addr);
+extern void flush_cache_page(struct vm_area_struct *vma, unsigned long addr,
+			     unsigned long pfn);
 extern void flush_dcache_page(struct page *pg);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void flush_icache_page(struct vm_area_struct *vma, struct page *page);
@@ -68,7 +69,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== include/asm-sh/cpu-sh4/cacheflush.h 1.2 vs edited =====
--- 1.2/include/asm-sh/cpu-sh4/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-sh/cpu-sh4/cacheflush.h	2004-11-15 19:56:22 +00:00
@@ -28,7 +28,8 @@
 extern void flush_cache_mm(struct mm_struct *mm);
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end);
-extern void flush_cache_page(struct vm_area_struct *vma, unsigned long addr);
+extern void flush_cache_page(struct vm_area_struct *vma, unsigned long addr,
+			     unsigned long pfn);
 extern void flush_dcache_page(struct page *pg);
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
===== include/asm-sh64/cacheflush.h 1.2 vs edited =====
--- 1.2/include/asm-sh64/cacheflush.h	2004-09-17 15:31:42 +01:00
+++ edited/include/asm-sh64/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -14,7 +14,7 @@
 extern void flush_cache_sigtramp(unsigned long start, unsigned long end);
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end);
-extern void flush_cache_page(struct vm_area_struct *vma, unsigned long addr);
+extern void flush_cache_page(struct vm_area_struct *vma, unsigned long addr, pfn);
 extern void flush_dcache_page(struct page *pg);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
@@ -31,14 +31,14 @@
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
-		flush_cache_page(vma, vaddr);			\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
 		memcpy(dst, src, len);				\
 		flush_icache_user_range(vma, page, vaddr, len);	\
 	} while (0)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
-		flush_cache_page(vma, vaddr);			\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
 		memcpy(dst, src, len);				\
 	} while (0)
 
===== include/asm-sparc/cacheflush.h 1.6 vs edited =====
--- 1.6/include/asm-sparc/cacheflush.h	2004-09-17 15:57:49 +01:00
+++ edited/include/asm-sparc/cacheflush.h	2004-11-15 20:06:35 +00:00
@@ -50,21 +50,21 @@
 #define flush_cache_all() BTFIXUP_CALL(flush_cache_all)()
 #define flush_cache_mm(mm) BTFIXUP_CALL(flush_cache_mm)(mm)
 #define flush_cache_range(vma,start,end) BTFIXUP_CALL(flush_cache_range)(vma,start,end)
-#define flush_cache_page(vma,addr) BTFIXUP_CALL(flush_cache_page)(vma,addr)
+#define flush_cache_page(vma,addr,pfn) BTFIXUP_CALL(flush_cache_page)(vma,addr)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma, pg)		do { } while (0)
 
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
 	} while (0)
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
 	} while (0)
 
 BTFIXUPDEF_CALL(void, __flush_page_to_ram, unsigned long)
===== include/asm-sparc64/cacheflush.h 1.7 vs edited =====
--- 1.7/include/asm-sparc64/cacheflush.h	2004-09-17 15:58:35 +01:00
+++ edited/include/asm-sparc64/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -11,7 +11,7 @@
 	do { if ((__mm) == current->mm) flushw_user(); } while(0)
 #define flush_cache_range(vma, start, end) \
 	flush_cache_mm((vma)->vm_mm)
-#define flush_cache_page(vma, page) \
+#define flush_cache_page(vma, page, pfn) \
 	flush_cache_mm((vma)->vm_mm)
 
 /* 
@@ -38,15 +38,15 @@
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
 	} while (0)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	do {					\
-		flush_cache_page(vma, vaddr);	\
-		memcpy(dst, src, len);		\
+	do {							\
+		flush_cache_page(vma, vaddr, page_to_pfn(page));\
+		memcpy(dst, src, len);				\
 	} while (0)
 
 extern void flush_dcache_page(struct page *page);
===== include/asm-v850/cacheflush.h 1.6 vs edited =====
--- 1.6/include/asm-v850/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-v850/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -25,7 +25,7 @@
 #define flush_cache_all()			((void)0)
 #define flush_cache_mm(mm)			((void)0)
 #define flush_cache_range(vma, start, end)	((void)0)
-#define flush_cache_page(vma, vmaddr)		((void)0)
+#define flush_cache_page(vma, vmaddr, pfn)	((void)0)
 #define flush_dcache_page(page)			((void)0)
 #define flush_dcache_mmap_lock(mapping)		((void)0)
 #define flush_dcache_mmap_unlock(mapping)	((void)0)
===== include/asm-x86_64/cacheflush.h 1.6 vs edited =====
--- 1.6/include/asm-x86_64/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-x86_64/cacheflush.h	2004-11-15 19:55:13 +00:00
@@ -8,7 +8,7 @@
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
===== mm/fremap.c 1.29 vs edited =====
--- 1.29/mm/fremap.c	2004-10-19 06:26:38 +01:00
+++ edited/mm/fremap.c	2004-11-15 19:43:50 +00:00
@@ -30,7 +30,7 @@
 	if (pte_present(pte)) {
 		unsigned long pfn = pte_pfn(pte);
 
-		flush_cache_page(vma, addr);
+		flush_cache_page(vma, addr, pfn);
 		pte = ptep_clear_flush(vma, addr, ptep);
 		if (pfn_valid(pfn)) {
 			struct page *page = pfn_to_page(pfn);
===== mm/memory.c 1.197 vs edited =====
--- 1.197/mm/memory.c	2004-10-28 08:39:54 +01:00
+++ edited/mm/memory.c	2004-11-15 19:43:50 +00:00
@@ -1029,7 +1029,6 @@
 {
 	pte_t entry;
 
-	flush_cache_page(vma, address);
 	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
 			      vma);
 	ptep_establish(vma, address, page_table, entry);
@@ -1081,7 +1080,7 @@
 		int reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
 		if (reuse) {
-			flush_cache_page(vma, address);
+			flush_cache_page(vma, address, pfn);
 			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
 					      vma);
 			ptep_set_access_flags(vma, address, page_table, entry, 1);
@@ -1119,6 +1118,7 @@
 			++mm->rss;
 		else
 			page_remove_rmap(old_page);
+		flush_cache_page(vma, address, pfn);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
===== mm/rmap.c 1.80 vs edited =====
--- 1.80/mm/rmap.c	2004-10-28 08:39:47 +01:00
+++ edited/mm/rmap.c	2004-11-15 19:43:50 +00:00
@@ -564,7 +564,7 @@
 	}
 
 	/* Nuke the page table entry. */
-	flush_cache_page(vma, address);
+	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
 
 	/* Move the dirty bit to the physical page now the pte is gone. */
@@ -676,7 +676,7 @@
 			continue;
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address);
+		flush_cache_page(vma, address, pfn);
 		pteval = ptep_clear_flush(vma, address, pte);
 
 		/* If nonlinear, store the file page offset in the pte. */


-- 
Russell King


----- End forwarded message -----

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

--SLDf9lqlvOQaIe6s
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <torvalds@osdl.org>
Envelope-to: rmk+lkml@arm.linux.org.uk
Delivery-date: Wed, 12 Jan 2005 00:07:22 +0000
Received: from caramon.arm.linux.org.uk ([2002:d412:e8ba:1:a00:2bff:fe95:1d7b])
	by flint.arm.linux.org.uk with asmtp (Exim 4.41)
	id 1CoW2i-0004Lj-Dj
	for rmk+lkml@arm.linux.org.uk; Wed, 12 Jan 2005 00:07:21 +0000
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by caramon.arm.linux.org.uk with esmtp (Exim 4.41)
	id 1CoW2f-0003mX-UO
	for rmk+lkml@arm.linux.org.uk; Wed, 12 Jan 2005 00:07:18 +0000
Received: from localhost (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id j0C07AY30105;
	Tue, 11 Jan 2005 16:07:10 -0800
Date: Tue, 11 Jan 2005 16:07:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
   Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: flush_cache_page()
In-Reply-To: <20050111223652.D30946@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org>
References: <20050111223652.D30946@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Tue, 11 Jan 2005, Russell King wrote:
>
> Any responses on this?  Didn't get any last time I mailed this out.

I don't have any real objections. I'd like it verified that gcc can
compile away all the overhead on the architectures that don't use the pfn, 
since "page_to_pfn()" can be a bit expensive otherwise.. But I don't see 
anything wrong with the approach.

		Linus

--SLDf9lqlvOQaIe6s
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <linux-arch-owner@vger.kernel.org>
Envelope-to: rmk@arm.linux.org.uk
Delivery-date: Sat, 29 Jan 2005 11:37:44 +0000
Received: from caramon.arm.linux.org.uk ([2002:d412:e8ba:1:a00:2bff:fe95:1d7b])
	by flint.arm.linux.org.uk with asmtp (Exim 4.41)
	id 1Cuqv2-0001Th-Rh
	for rmk@arm.linux.org.uk; Sat, 29 Jan 2005 11:37:41 +0000
Received: from vger.kernel.org ([12.107.209.244])
	by caramon.arm.linux.org.uk with esmtp (Exim 4.41)
	id 1Cuqus-0001P4-43
	for rmk@arm.linux.org.uk; Sat, 29 Jan 2005 11:37:27 +0000
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44555 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262901AbVA2LhW (ORCPT <rfc822;rmk@arm.linux.org.uk>);
	Sat, 29 Jan 2005 06:37:22 -0500
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Cuquj-0001Ov-BV; Sat, 29 Jan 2005 11:37:18 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1Cuquc-0001TB-Gu; Sat, 29 Jan 2005 11:37:10 +0000
Date: Sat, 29 Jan 2005 11:37:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
	Philippe Robin <Philippe.Robin@arm.com>
Cc: Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: flush_cache_page()
Message-ID: <20050129113707.B2233@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Philippe Robin <Philippe.Robin@arm.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050111223652.D30946@flint.arm.linux.org.uk> <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org>; from torvalds@osdl.org on Tue, Jan 11, 2005 at 04:07:09PM -0800
Sender: Russell King <rmk@arm.linux.org.uk>

On Tue, Jan 11, 2005 at 04:07:09PM -0800, Linus Torvalds wrote:
> On Tue, 11 Jan 2005, Russell King wrote:
> > Any responses on this?  Didn't get any last time I mailed this out.
> 
> I don't have any real objections. I'd like it verified that gcc can
> compile away all the overhead on the architectures that don't use the pfn, 
> since "page_to_pfn()" can be a bit expensive otherwise.. But I don't see 
> anything wrong with the approach.

Thanks for the response.  However, apart from Ralph, Paul and yourself,
it seems none of the other architecture maintainers care about this
patch - the original mail was BCC'd to the architecture list.  Maybe
that's an implicit acceptance of this patch, I don't know.

I do know that page_to_pfn() will generate code on some platforms which
don't require it due to them declaring flush_cache_page() as a function.
However, I assert that if they don't need this overhead, that's for them
to fix up.  I don't know all their quirks so it isn't something I can
tackle.

In other words, unless I actually receive some real help from the other
architecture maintainers on this to address your concerns, ARM version 6
CPUs with aliasing L1 caches (== >16K) will remain a dead dodo with
mainline Linux kernels.

(This mail BCC'd to the architecture list again in the vain hope that
someone will offer assistance.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

--SLDf9lqlvOQaIe6s--
