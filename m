From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v6 0/5] MCS Lock: MCS lock code cleanup and
 optimizations
Date: Wed, 20 Nov 2013 09:00:47 -0800
Message-ID: <1384966847.11046.457.camel@schen9-DESK>
References: <cover.1384885312.git.tim.c.chen@linux.intel.com>
	 <1384911446.11046.450.camel@schen9-DESK>
	 <20131120101957.GA19352@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131120101957.GA19352@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, H. Peter An
List-Id: linux-arch.vger.kernel.org

On Wed, 2013-11-20 at 10:19 +0000, Will Deacon wrote:
> Hi Tim,
> 
> On Wed, Nov 20, 2013 at 01:37:26AM +0000, Tim Chen wrote:
> > In this patch series, we separated out the MCS lock code which was
> > previously embedded in the mutex.c.  This allows for easier reuse of
> > MCS lock in other places like rwsem and qrwlock.  We also did some micro
> > optimizations and barrier cleanup.  
> > 
> > The original code has potential leaks between critical sections, which
> > was not a problem when MCS was embedded within the mutex but needs
> > to be corrected when allowing the MCS lock to be used by itself for
> > other locking purposes. 
> > 
> > Proper barriers are now embedded with the usage of smp_load_acquire() in
> > mcs_spin_lock() and smp_store_release() in mcs_spin_unlock.  See
> > http://marc.info/?l=linux-arch&m=138386254111507 for info on the
> > new smp_load_acquire() and smp_store_release() functions. 
> > 
> > This patches were previously part of the rwsem optimization patch series
> > but now we spearate them out.
> > 
> > We have also added hooks to allow for architecture specific 
> > implementation of the mcs_spin_lock and mcs_spin_unlock functions.
> > 
> > Will, do you want to take a crack at adding implementation for ARM
> > with wfe instruction?
> 
> Sure, I'll have a go this week. Thanks for keeping that as a consideration!
> 
> As an aside: what are you using to test this code, so that I can make sure I
> don't break it?
> 

I was testing it against my rwsem patches.  But any workload that 
exercises mutex should also use this code, as this is part of mutex.

Tim

> Will


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
