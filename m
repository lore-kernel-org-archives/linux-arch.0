Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58728 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732Ab2EZIXi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 May 2012 04:23:38 -0400
Message-ID: <1338020615.3087.0.camel@dabdike.int.hansenpartnership.com>
Subject: Re: [PATCH] update parisc to use generic strncpy_from_user()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 26 May 2012 09:23:35 +0100
In-Reply-To: <20120525.161651.2289094861181984680.davem@davemloft.net>
References: <1337954392.2932.36.camel@dabdike.int.hansenpartnership.com>
	 <20120525.161651.2289094861181984680.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120526082335.UN7H_MMzDcejuvavjdgytfSQL-ZuFMlRa9gkYEk6P0w@z>

On Fri, 2012-05-25 at 16:16 -0400, David Miller wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Fri, 25 May 2012 14:59:52 +0100
> 
> > I'll queue this patch in our git repo.  It seems to work fine for us,
> > thanks, Dave!
> > 
> > Parisc people, I'm a bit worried about the #include <linux/sched.h> in
> > asm/uaccess.h ... I'm sure that's going to lead to complications later.
> > It's needed to get the dynamic TASK_SIZE, which expands through the task
> > structure to fill in user_addr_max() ... I'm thinking though that the
> > top of address space doesn't provide much protection on pa (since our
> > stack grows up towards it anyway, so we could just replace that with
> > ~0UL ... what do people think?
> 
> Do what I did on Sparc wrt. TASK_SIZE, that way you won't need to
> include linux/sched.h

Yes, we have all the machinery for a variable task_size, but we never
use it.

> The only reason you need linux/sched.h is to get
> test_tsk_thread_flag(), for your TASK_SIZE_OF().
> 
> But that's completely pointless for TASK_SIZE which only needs to look
> at the current thread's settings.
> 
> Thus if you use test_thread_flag() for TASK_SIZE, instead of trying to
> borrow TASK_SIZE_OF()'s implementation, you'll no longer have this
> linux/sched.h dependency.

Right, so we have thread_info in %cr30, but we still seem to be using a
vestigial struct thread_struct as well as a struct thread_info (so we
don't have all the info at the right level).  I'll code user_max_addr as

(segment_eq(get_fs(), USER_DS) ? TMP_TASK_SIZE : ~0UL)

And do TMP_TASK_SIZE as

(test_tsk_thread_flag(tsk,TIF_32BIT) ? DEFAULT_TASK_SIZE_32 :
DEFAULT_TASK_SIZE)

until we can get this sorted out properly (i.e. by removing task_size
from struct thread_struct)

James


