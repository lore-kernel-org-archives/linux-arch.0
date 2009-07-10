From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 0/2] cond_resched() optimization
Date: Fri, 10 Jul 2009 14:57:55 +0200
Message-ID: <20090710125755.559739294@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35431 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbZGJNEQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 09:04:16 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com, mingo@elte.hu

Matt suggested, whereupon Linus sayeth:

 "This looks like a good patch. Please make it so"

Compile and boot tested on x86_64 only.
