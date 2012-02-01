From: Peter Zijlstra <peterz@infradead.org>
Subject: on memory barriers and cachelines
Date: Wed, 01 Feb 2012 10:33:58 +0100
Message-ID: <1328088838.2760.21.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55387 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab2BAJeM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2012 04:34:12 -0500
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RsWZv-0004cD-Ix
	for linux-arch@vger.kernel.org; Wed, 01 Feb 2012 09:34:11 +0000
Received: from 178-85-86-190.dynamic.upc.nl ([178.85.86.190] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1RsWZv-000881-AD
	for linux-arch@vger.kernel.org; Wed, 01 Feb 2012 09:34:11 +0000
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

Hi all,

So I was talking to Paul yesterday and he mentioned how the SRCU sync
primitive has to use extra synchronize_sched() calls in order to avoid
smp_rmb() calls in the srcu_read_{un,}lock() calls.

Now memory barriers are usually explained as observable order between
two (or more) unrelated variables, as Documentation/memory-barriers.txt
does in great detail.

What I couldn't find in there though, is what happens when both
variables are on the same cacheline. The "The effects of the CPU cache"
and "Cache coherency" sections are closest but leave me wanting on this
point.

Can we get some implicit behaviour from being on the same cacheline? Or
can this memory access queue still totally wreck the game?
