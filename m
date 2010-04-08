From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 11/13] mutex: Provide mutex_is_contended
Date: Thu, 08 Apr 2010 21:17:48 +0200
Message-ID: <20100408192723.072839778@chello.nl>
References: <20100408191737.296180458@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:47323 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933404Ab0DHTae (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 15:30:34 -0400
Content-Disposition: inline; filename=mutex-is-contended.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>

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
