From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] qrwlock: Fix bug in interrupt handling code
Date: Thu, 9 Apr 2015 22:14:05 +0200
Message-ID: <20150409201405.GU21418@twins.programming.kicks-ass.net>
References: <1428610075-38957-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55482 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253AbbDIUOZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2015 16:14:25 -0400
Content-Disposition: inline
In-Reply-To: <1428610075-38957-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Thu, Apr 09, 2015 at 04:07:55PM -0400, Waiman Long wrote:
> The qrwlock is fair in the process context, but becoming unfair when
> in the interrupt context to support use cases like the tasklist_lock.
> However, the unfair code in the interrupt context has problem that
> may cause deadlock.
> 
> The fast path increments the reader count. In the interrupt context,
> the reader in the slowpath will wait until the writer release the
> lock. However, if other readers have the lock and the writer is just
> in the waiting mode. It will never get the write lock because the
> that interrupt context reader has increment the count. This will
> cause deadlock.
> 
> This patch fixes this problem by checking the state of the
> reader/writer count retrieved at the fast path. If the writer
> is in waiting mode, the reader will get the lock immediately and
> return. Otherwise, it will wait until the writer release the lock
> like before.

A little word on how you found this issue would be nice.

I'll have a look at the actual patch tomorrow, my brain is properly
fried (as demonstrated by my last email to you ;-).
