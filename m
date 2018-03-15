Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeCOISt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 04:18:49 -0400
Date: Thu, 15 Mar 2018 09:18:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Message-ID: <20180315081845.GS4064@hirez.programming.kicks-ass.net>
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net>
 <1521059931.11552.51.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521059931.11552.51.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180315081845.QUJVfSCRdb9Hx_lhmZvDfVrEdj-NvO46pcE93r-7k6A@z>

On Wed, Mar 14, 2018 at 08:38:53PM +0000, Alexey Brodkin wrote:
> > int sys_cmpxchg(u32 __user *user_ptr, u32 old, u32 new)
> > {
> > 	u32 val;
> > 	int ret;
> > 
> > again:
> > 	ret = 0;
> > 
> > 	preempt_disable();
> > 	val = get_user(user_ptr);
> > 	if (val == old)
> > 		ret = put_user(new, user_ptr);
> > 	preempt_enable();
> > 
> > 	if (ret == -EFAULT) {
> > 		struct page *page;
> > 		ret = get_user_pages_fast((unsigned long)user_ptr, 1, 1, &page);
> > 		if (ret < 0)
> > 			return ret;
> > 		put_page(page);
> > 		goto again;
> 
> I guess this jump we need to do only once, right?

Typically, yes. It is theoretically possible for the page to get
paged-out right after we do put_page() and before we do get/put_user(),
But if that happens the machine likely has bigger problems than having
to do this loop again.

FWIW, look at kernel/futex.c for working examples of this pattern, the
above was written purely from memory and could contain a fail or two ;-)

Also, it might make sense to stuff this implementation in some lib/ file
somewhere and make all platforms that need it use the same code, afaict
there really isn't anything platform specific to it.
