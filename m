From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 2/5] qrwlock x86: Enable x86 to use queue read/write
 lock
Date: Mon, 20 Jan 2014 11:16:30 -0500
Message-ID: <20140120111630.7ceb0aa5@gandalf.local.home>
References: <1389761047-47566-1-git-send-email-Waiman.Long@hp.com>
	<1389761047-47566-3-git-send-email-Waiman.Long@hp.com>
	<20140120160806.GI30183@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:50242 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751643AbaATQQd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jan 2014 11:16:33 -0500
In-Reply-To: <20140120160806.GI30183@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, "Aswin Chandramouleeswaran\"" <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>

On Mon, 20 Jan 2014 17:08:06 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jan 14, 2014 at 11:44:04PM -0500, Waiman Long wrote:
> > This patch makes the necessary changes at the x86 architecture specific
> > layer to enable the presence of the CONFIG_QUEUE_RWLOCK kernel option
> > to replace the read/write lock by the queue read/write lock.
> > 
> > It also enables the CONFIG_QUEUE_RWLOCK option by default for x86 which
> > will force the use of queue read/write lock. That will greatly improve
> > the fairness of read/write lock and eliminate live-lock situation
> > where one task may not get the lock for an indefinite period of time.
> > 
> > Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> > Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  arch/x86/Kconfig                      |    1 +
> >  arch/x86/include/asm/spinlock.h       |    2 ++
> >  arch/x86/include/asm/spinlock_types.h |    4 ++++
> >  3 files changed, 7 insertions(+), 0 deletions(-)
> 
> This patch doesn't have nearly enough -, you should rip out all traces
> of the old rwlock. There's no point in having it configurable, either
> qrwlock is good or not.

Although having something that switches back to the old method gives
more users the way to compare. Especially to catch any regressions.

Make one release with it configurable, then drop it.

-- Steve
