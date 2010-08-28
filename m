Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42781 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab0H1O1t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Aug 2010 10:27:49 -0400
Message-ID: <20100828142456.590755447@chello.nl>
Date: Sat, 28 Aug 2010 16:16:54 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 17/20] mutex: Provide mutex_is_contended
References: <20100828141637.421594670@chello.nl>
Content-Disposition: inline; filename=mutex-is-contended.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20100828141654.kJ57UWLjIXe0-v8HOFN4z6mva4v8D6T4YfhEXeClhzA@z>

Usable for lock-breaks and such.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/mutex.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -118,6 +118,11 @@ static inline int mutex_is_locked(struct
 	return atomic_read(&lock->count) != 1;
 }
 
+static inline int mutex_is_contended(struct mutex *lock)
+{
+	return atomic_read(&lock->count) < 0;
+}
+
 /*
  * See kernel/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/mutex-design.txt.


