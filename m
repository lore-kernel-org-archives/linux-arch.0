From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 17/20] mutex: Provide mutex_is_contended
Date: Mon, 18 Oct 2010 13:24:50 +0200
Message-ID: <20101018112951.178962037@chello.nl>
References: <20101018112433.556591568@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:60282 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab0JRLfr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2010 07:35:47 -0400
Content-Disposition: inline; filename=mutex-is-contended.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

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
