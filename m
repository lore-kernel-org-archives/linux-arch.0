From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 0/3] Allow inlined spinlocks again V4
Date: Fri, 14 Aug 2009 14:58:01 +0200
Message-ID: <20090814125801.881618121@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:39810 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbZHNM65 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2009 08:58:57 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n7ECwvNj025915
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 12:58:57 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7ECwv041720378
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 13:58:57 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7ECwufw026828
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 13:58:57 +0100
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>

This patch set allows to have inlined spinlocks again.

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

V2: rewritten from scratch - now also with readable code

V3: removed macro to generate out-of-line spinlock variants since that
    would break ctags. As requested by Arnd Bergmann.

V4: allow architectures to specify for each lock/unlock variant if
    it should be kept out-of-line or inlined.
