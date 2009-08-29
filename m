From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 0/8] Allow inlined spinlocks again V5
Date: Sat, 29 Aug 2009 12:21:15 +0200
Message-ID: <20090829102115.638224800@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.17.164]:48522 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZH2KV7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2009 06:21:59 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7TALu16024906
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 10:21:56 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7TALuI12429012
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 12:21:56 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7TALspG009996
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 12:21:56 +0200
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

Linus, Ingo, do you still have objections?

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

#define __spin_lock_is_small

in arch/<whatever>/include/asm/spinlock.h to force inlining of a locking
function.

defconfig cross compile tested for alpha, arm, x86, x86_64, ia64, m68k,
m68knommu, mips, powerpc, powerpc64, sparc64, s390, s390x.
