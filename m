From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 0/5] MCS Lock: MCS lock code cleanup and optimizations
Date: Wed, 20 Nov 2013 04:50:23 -0800
Message-ID: <20131120125023.GC4138@linux.vnet.ibm.com>
References: <cover.1384885312.git.tim.c.chen@linux.intel.com>
 <1384911446.11046.450.camel@schen9-DESK>
 <20131120101957.GA19352@mudshark.cambridge.arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131120101957.GA19352@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 20, 2013 at 10:19:57AM +0000, Will Deacon wrote:
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

+1 to that!  In fact, it would be nice to have the test code in-tree,
especially if it can test a wide variety of locks.  (/me needs to look
at what test code for locks might already be in tree, for that matter...)

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
