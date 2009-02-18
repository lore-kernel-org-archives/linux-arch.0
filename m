From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove	single
	ipi fallback for smp_call_function_many())
Date: Tue, 17 Feb 2009 18:15:31 -0800
Message-ID: <1234923331.29823.2.camel@vayu>
References: <1234818201.30178.386.camel@laptop>
	 <20090216213205.GA9098@redhat.com> <1234820704.30178.396.camel@laptop>
	 <20090216220214.GA10093@redhat.com> <1234823097.30178.406.camel@laptop>
	 <20090216231946.GA12009@redhat.com> <1234862974.4744.31.camel@laptop>
	 <20090217101130.GA8660@wotan.suse.de> <1234866453.4744.58.camel@laptop>
	 <20090217112657.GE26402@wotan.suse.de>
	 <20090217155147.GE6761@linux.vnet.ibm.com>
Reply-To: Suresh Siddha <suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57576 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbZBRCQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Feb 2009 21:16:56 -0500
In-Reply-To: <20090217155147.GE6761@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Oleg Nesterov <oleg@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, 2009-02-17 at 07:51 -0800, Paul E. McKenney wrote:
> On Tue, Feb 17, 2009 at 12:26:57PM +0100, Nick Piggin wrote:
> > +	spin_lock(&q->lock);
> > +	list_replace_init(&q->list, &list);
> > +	spin_unlock(&q->lock);
> 
> OK, I'll bite...
> 
> How do we avoid deadlock in the case where a pair of CPUs send to each
> other concurrently?

Sender takes the lock with interrupts-disabled. That should prevent any
deadlock, right?
