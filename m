From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH RFC 1/2] qrwlock: A queue read/write lock implementation
Date: 18 Jul 2013 08:55:01 -0400
Message-ID: <20130718125501.2620.qmail@science.horizon.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:20276 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757881Ab3GRMzD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2013 08:55:03 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman.Long@hp.com
Cc: JBeulich@novell.com, linix-kernel@vger.kernel.org, linux@horizon.com, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

In the interest of more useful Kconfig help, could I recommend the
following text:

config QUEUE_RWLOCK
	bool "Generic queue read/write lock"
	depends on ARCH_QUEUE_RWLOCK
	help
	  Use an alternative reader-writer lock (rwlock) implementation,
	  optimized for larger NUMA systems.  These locks use more memory,
	  but perform better under high contention.  (Specifically, readers
	  waiting for a writer to release the lock will be queued rather
	  than all spinning on the same cache line.)

	  The kernel will operate correctly either way; this only
	  affects performance.

	  For common desktop and server systems systems with only one
	  or two CPU sockets, the performance benefits are not worth
	  the additional memory; say N here.

My goal is to give someone stumbling across this question for the first
time in "make oldconfig" the information htey need to answer it.


That said, I think Ingo's idea for simplfying the waiting reader side
is excellent and should be tried before bifurcating the implementation.

Looking at the lock system, it *seems* like that patch to __read_lock_failed
is literally the *only* thing that needs changing, since the write
lock/unlock is all done with relative add/sub anyway.  But I keep thinking
"there must have been a reason why it wasn't done that way in the first
place".
