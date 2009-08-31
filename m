From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 0/9] Allow inlined spinlocks again V6
Date: Mon, 31 Aug 2009 14:43:30 +0200
Message-ID: <20090831124330.014480226@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.uk.ibm.com ([195.212.29.140]:47768 "EHLO
	mtagate7.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbZHaMol (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2009 08:44:41 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7VCiRrb105474
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 12:44:32 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7VCiHYY2625618
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 13:44:17 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7VCiF32006656
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 13:44:17 +0100
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

This patch set allows to have inlined spinlocks again.

V2: rewritten from scratch - now also with readable code

V3: removed macro to generate out-of-line spinlock variants since that
    would break ctags. As requested by Arnd Bergmann.

V4: allow architectures to specify for each lock/unlock variant if
    it should be kept out-of-line or inlined.

V5: simplify ifdefs as pointed out by Linus. Fix architecture compile
    breakages caused by this change.

V6: rename __spin_lock_is_small to __always_inline__spin_lock as requested
    by Ingo Molnar. That way it is more consistent with the other methods
    used to force inlining.
    Also simplify inlining by getting rid of the old variants to force
    inlining of the unlock functions.

This is hopefully the final version. I did again run the whole cross
compiles. The patch set applies on top of latest Linus' git tree, but
also applies on top of linux-next.

Ingo, I assume you don't have further objections?

Should this go in via -mm then?

---

The rationale behind this is that function calls on at least s390 are
expensive.

If one considers that server kernels are usually compiled with
!CONFIG_PREEMPT a simple spin_lock is just a compare and swap loop.
The extra overhead for a function call is significant.
With inlined spinlocks overall cpu usage gets reduced by 1%-5% on s390.
These numbers were taken with some network benchmarks. However I expect
any workload that calls frequently into the kernel and which grabs a few
locks to perform better.

The implementation is straight forward: move the function bodies of the
locking functions to static inline functions and place them in a header
file.
By default all locking code remains out-of-line. An architecture can
specify

#define __always_inline__spin_lock

in arch/<whatever>/include/asm/spinlock.h to force inlining of a locking
function.

defconfig cross compile tested for alpha, arm, x86, x86_64, ia64, m68k,
m68knommu, mips, powerpc, powerpc64, sparc64, s390, s390x.
