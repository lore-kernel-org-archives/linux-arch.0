From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: Lots of bugs with current->state = TASK_*INTERRUPTIBLE
Date: Thu, 21 Jan 2010 11:18:50 -0800
Message-ID: <4B58A89A.8050405@caviumnetworks.com>
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5743 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0AUTTW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2010 14:19:22 -0500
In-Reply-To: <1263932978.31321.53.camel@gandalf.stny.rr.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rostedt@goodmis.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, Andy Whitcroft <apw@canonical.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>

Steven Rostedt wrote:
> Peter Zijlstra and I were doing a look over of places that assign
> current->state = TASK_*INTERRUPTIBLE, by simply looking at places with:
> 
>  $ git grep -A1 'state[[:space:]]*=[[:space:]]*TASK_[^R]'
> 
> and it seems there are quite a few places that looks like bugs. To be on
> the safe side, everything outside of a run queue lock that sets the
> current state to something other than TASK_RUNNING (or dead) should be
> using set_current_state().
> 
> 	current->state = TASK_INTERRUPTIBLE;
> 	schedule();
> 
> is probably OK, but it would not hurt to be consistent. Here's a few
> examples of likely bugs:
> 
[...]

This may be a bit off topic, but exactly which type of barrier should 
set_current_state() be implying?

On MIPS, set_mb() (which is used by set_current_state()) has a full mb().

Some MIPS based processors have a much lighter weight wmb().  Could 
wmb() be used in place of mb() here?

If not, an explanation of the required memory ordering semantics here 
would be appreciated.

I know the documentation says:

     set_current_state() includes a barrier so that the write of
     current->state is correctly serialised wrt the caller's subsequent
     test of whether to actually sleep:

  	set_current_state(TASK_UNINTERRUPTIBLE);
  	if (do_i_need_to_sleep())
  		schedule();


Since the current CPU sees the memory accesses in order, what can be 
happening on other CPUs that would require a full mb()?


Thanks,
David Daney
