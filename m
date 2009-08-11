From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 0/4] Allow inlined spinlocks again V2
Date: Tue, 11 Aug 2009 14:47:56 +0200
Message-ID: <20090811124756.873490673@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:48387 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZHKMtu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2009 08:49:50 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate5.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7BCnCXM495480
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 12:49:12 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7BCnCMu1552402
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 13:49:12 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7BCnBIl012484
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 13:49:12 +0100
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

This patch set allows to have inlined spinlocks again.

V2: rewritten from scratch - now with readable code

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
Dependent on CONFIG_SPINLOCK_INLINE generate out-of-line or inlined
locking functions.

The patches should be self explaining.
