Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:44460 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751734AbWHSMZT
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 19 Aug 2006 08:25:19 -0400
Received: from localhost.localdomain ([127.0.0.1]:53891 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038455AbWHSMZQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 19 Aug 2006 13:25:16 +0100
Date: Sat, 19 Aug 2006 13:25:20 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Cache alias handling in copy_user_page / copy_user_highpage
Message-ID: <20060819122520.GA18180@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

The problem:

There is a dcache aliasing problem on preempt kernel (or SMP kernel,
perhaps) when a multi-threaded program calls fork().

1. Now there is a process containing two thread (T1 and T2).  The
   thread T1 call fork().  dup_mmap() function called on T1 context.

static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
{
	...
	flush_cache_mm(current->mm);
	/* A */
	...
	(write-protect all Copy-On-Write pages)
	...
	/* B */
	flush_tlb_mm(current->mm);
	...
}

2. When preemption happens between A and B (or on SMP kernel), the
   thread T2 can run and modify data on COW pages without page fault
   (modified data will stay in cache).

3. Some time after fork() completed, the thread T2 may cause page
   fault by write-protect on COW pages .

4. Then data of the COW page will be copied to newly allocated
   physical page in cow_user_page() which calls copy_user_highpage which
   in turn calls copy_user_page.  copy_user_highpage is mapping source and
   destination page using kmap_atomic(), then calls copy_user_page to
   perform the actual copy operation.
   The kernel mapping can have a different 'color' than the user space
   mapping of thread T2, resulting in dcache aliasing.  Therefore
   copy_cow_page() will copy stale data.  Then the modified data in cache
   will be lost.

A common implementation of copy_user_page performs a copy_page and a
cacheflush operation and this implementation is suspect to above problem.
I know MIPS and PARISC suffer from the problem.  ARM and m68k look suspect
to me at which point I stopped looking at further architectures.

The only sane solution I can see is setting up temporary kernel mappings
for source and destination pages with virtual addresses choosen to be
congruent to userspace addresses.  cachetlb.txt's wording describes this
as if it was an optional fancy implementation.

Now that I've described the problem, the last thing that is left to
explain is why copy_user_page is an insufficient interface, that's the
most trivial one.  copy_user_highpage() uses kmap_atomic which will
create atomic mappings without consideration for cache aliasing.  So
copy_user_page() will be invoked with the virtual address of these
mappings and the struct page pointer for the destination page.  on a
machine with aliases copy_user_page has no choice but to ignore the
destination address and map the pag itself again - wasted time.  And it
doesn't receive a struct page * for the source page ...

So here are two alterantive fixes for the API:

1) Move copy_user_highpage into the arch code.  This will allow the arch code
to create any sort of crazy mapping it wants.  The old copy_user_page as
kernel API is only called from copy_user_highpage and would therefore be
obsoleted.

2) Introduce a new kmap_atomic variant to create a congruent mapping.
copy_user_highpage would change into something like this:

static inline void copy_user_highpage(struct page *to, struct page *from,
	unsigned long vaddr)
{
        char *vfrom, *vto;

        vfrom = kmap_coherent(from, KM_USER0, vaddr);
        vto = kmap_coherent(to, KM_USER1, vaddr);
        copy_page(vto, vfrom);
        kunmap_coherent(vfrom, KM_USER0, vaddr);
        kunmap_coherent(vto, KM_USER1, vaddr);
        /* Make sure this page is cleared on other CPU's too before using it */
        smp_wmb();
}

I lean toward 2) since kmap_coherent is a more versatile interface.

clear_user_page / clear_user_highpage are not affected by the same kind of
bug but they should be changed similarly for consistency.

  Ralf
