Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:52482 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab2EYUQ5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 16:16:57 -0400
Date: Fri, 25 May 2012 16:16:51 -0400 (EDT)
Message-ID: <20120525.161651.2289094861181984680.davem@davemloft.net>
Subject: Re: [PATCH] update parisc to use generic strncpy_from_user()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1337954392.2932.36.camel@dabdike.int.hansenpartnership.com>
References: <1337954392.2932.36.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James.Bottomley@HansenPartnership.com
Cc: linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120525201651.q4iYwvBKlMKZe47YQlTEyqo_yurQisjS3DynGrhESOg@z>

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 25 May 2012 14:59:52 +0100

> I'll queue this patch in our git repo.  It seems to work fine for us,
> thanks, Dave!
> 
> Parisc people, I'm a bit worried about the #include <linux/sched.h> in
> asm/uaccess.h ... I'm sure that's going to lead to complications later.
> It's needed to get the dynamic TASK_SIZE, which expands through the task
> structure to fill in user_addr_max() ... I'm thinking though that the
> top of address space doesn't provide much protection on pa (since our
> stack grows up towards it anyway, so we could just replace that with
> ~0UL ... what do people think?

Do what I did on Sparc wrt. TASK_SIZE, that way you won't need to
include linux/sched.h

The only reason you need linux/sched.h is to get
test_tsk_thread_flag(), for your TASK_SIZE_OF().

But that's completely pointless for TASK_SIZE which only needs to look
at the current thread's settings.

Thus if you use test_thread_flag() for TASK_SIZE, instead of trying to
borrow TASK_SIZE_OF()'s implementation, you'll no longer have this
linux/sched.h dependency.
