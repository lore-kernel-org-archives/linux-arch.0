Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2622 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215AbXFKQAg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jun 2007 12:00:36 -0400
Date: Mon, 11 Jun 2007 17:00:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: [BUG] Fault handlers can deadlock
Message-ID: <20070611160026.GA16265@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

Recently, a bug has been discovered on ARM whereby if futexes are
being used and the system is put under heavy load, a deadlock will
occur.

The deadlock involves mmap_sem having been taken by the futex code
and a page fault occuring in copy_from_user_inatomic().  We then
hit this:

        /*
         * As per x86, we may deadlock here.  However, since the kernel only
         * validly references user space from well defined areas of the code,
         * we can bug out early if this is from code which shouldn't.
         */
        if (!down_read_trylock(&mm->mmap_sem)) {
                if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
                        goto no_context;
                down_read(&mm->mmap_sem);
        }

which is more or less identical across many architectures.  The
problem is that:

1. down_read_trylock() finds contention, so it returns 0.
2. we've been called from kernel mode
3. search_exception_tables() finds an entry in the exception
   tables (see note about "well defined areas of the code") and
   returns *non*-NULL
4. therefore, the second if statement is _false_.
5. we then deadlock on down_read(&mm->mmap_sem).

Note that search_exception_tables() is generic code, and I believe rwsems
are also generic code today.

For reference, he's the x86 version, which will perform in the same
way as the ARM version quoted above:

        /* When running in the kernel we expect faults to occur only to
         * addresses in user space.  All other faults represent errors in the
         * kernel and should generate an OOPS.  Unfortunatly, in the case of an
         * erroneous fault occurring in a code path which already holds mmap_sem
         * we will deadlock attempting to validate the fault against the
         * address space.  Luckily the kernel only validly references user
         * space from well defined areas of code, which are listed in the
         * exceptions table.
         *
         * As the vast majority of faults will be valid we will only perform
         * the source reference check when there is a possibilty of a deadlock.
         * Attempt to lock the address space, if we cannot we then validate the
         * source.  If this is invalid we can skip the address space check,
         * thus avoiding the deadlock.
         */
        if (!down_read_trylock(&mm->mmap_sem)) {
                if ((error_code & 4) == 0 &&
                    !search_exception_tables(regs->eip))
                        goto bad_area_nosemaphore;
                down_read(&mm->mmap_sem);
        }

Clearly, if we are expecting to deal with faults occuring from these "well
defined areas of code, which are listed in the exceptions table" the
sense if the test is wrong.

Therefore, I think the following patch is appropriate (and similar patches
are required for other architectures):

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 75d4914..e41efd9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -238,7 +238,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * we can bug out early if this is from code which shouldn't.
 	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
+		if (!user_mode(regs) && search_exception_tables(regs->ARM_pc))
 			goto no_context;
 		down_read(&mm->mmap_sem);
 	}

Comments?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
