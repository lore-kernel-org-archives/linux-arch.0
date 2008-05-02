From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/10] Add generic helpers for arch IPI function calls
Date: Fri, 02 May 2008 14:59:29 +0200
Message-ID: <1209733169.13978.157.camel@twins>
References: <1209453990-7735-1-git-send-email-jens.axboe@oracle.com>
	 <1209453990-7735-2-git-send-email-jens.axboe@oracle.com>
	 <20080429135936.GC12390@linux.vnet.ibm.com>
	 <20080430112934.GA23203@linux.vnet.ibm.com>
	 <20080430113456.GY12774@kernel.dk>
	 <20080430121712.GR11126@linux.vnet.ibm.com>
	 <20080430123717.GC12774@kernel.dk>
	 <20080502020241.GA26088@linux.vnet.ibm.com>
	 <20080502021233.GC11844@wotan.suse.de>
	 <20080502122955.GB15522@linux.vnet.ibm.com>
	 <20080502124205.GA23680@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935036AbYEBNAi@vger.kernel.org>
In-Reply-To: <20080502124205.GA23680@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu
List-Id: linux-arch.vger.kernel.org

On Fri, 2008-05-02 at 05:42 -0700, Paul E. McKenney wrote:

> And here is one scenario that makes me doubt that my imagination is
> faulty:
> 
> 1.	CPU 0 disables irqs.
> 
> 2.	CPU 1 disables irqs.
> 
> 3.	CPU 0 invokes smp_call_function().  But CPU 1 will never respond
> 	because its irqs are disabled.
> 
> 4.	CPU 1 invokes smp_call_function().  But CPU 0 will never respond
> 	because its irqs are disabled.
> 
> Looks like inherent deadlock to me, requiring that smp_call_function()
> be invoked with irqs enabled.
> 
> So, what am I missing here?

The wish to do it anyway ;-)

I can imagine some situations where I'd like to try anyway and fall back
to a slower path when failing.

With the initial design we would simply allocate data, stick it on the
queue and call the ipi (when needed).

This is perfectly deadlock free when wait=0 and it just returns -ENOMEM
on allocation failure.

It it doesn't return -ENOMEM I know its been queued and will be
processed at some point, if it does fail, I can deal with it in another
way.

I know I'd like to do that and I suspect Nick has a few use cases up his
sleeve as well.
