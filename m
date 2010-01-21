From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Lots of bugs with current->state = TASK_*INTERRUPTIBLE
Date: Thu, 21 Jan 2010 15:18:24 -0500
Message-ID: <1264105104.31321.298.camel@gandalf.stny.rr.com>
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>
	 <4B58A89A.8050405@caviumnetworks.com>
	 <1264102455.31321.293.camel@gandalf.stny.rr.com>
	 <4B58B1B3.6000502@caviumnetworks.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755163Ab0AUUS2@vger.kernel.org>
In-Reply-To: <4B58B1B3.6000502@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, Andy Whitcroft <apw@canonical.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 2010-01-21 at 11:57 -0800, David Daney wrote:

> >> Since the current CPU sees the memory accesses in order, what can be 
> >> happening on other CPUs that would require a full mb()?
> > 
> > Lets look at a hypothetical situation with:
> > 
> > 	add_wait_queue();
> > 	current->state = TASK_UNINTERRUPTIBLE;
> > 	smp_wmb();
> > 	if (!x)
> > 		schedule();
> > 
> > 
> > 
> > Then somewhere we probably have:
> > 
> > 	x = 1;
> > 	smp_wmb();
> > 	wake_up(queue);
> > 
> > 
> > 
> > 	   CPU 0			   CPU 1
> > 	------------			-----------
> > 	add_wait_queue();
> > 	(cpu pipeline sees a load
> > 	 of x ahead, and preloads it)
> 
> 
> This is what I thought.
> 
> My cpu (Cavium Octeon) does not have out of order reads, so my wmb() is 

Can you have reads that are out of order wrt writes? Because the above
does not have out of order reads. It just had a read that came before a
write. The above code could look like:

(hypothetical assembly language)

	ld r2, TASK_UNINTERRUPTIBLE
	st r2, (current->state)
	wmb
	ld r1, (x)
	cmp r1, 0

Is it possible for the CPU to do the load of r1 before storing r2? If
so, then the bug still exists.

-- Steve


> in fact a full mb() from the point of view of the current CPU.  So I 
> think I could weaken my bariers in set_current_state() and still get 
> correct operation.  However as you say...
> 
