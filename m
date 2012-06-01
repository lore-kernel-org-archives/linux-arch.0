From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 05/20] hexagon: Do not call do_signal() with irqs
 disabled
Date: Fri, 1 Jun 2012 14:01:35 -0500
Message-ID: <20120601190135.GC23541@codeaurora.org>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
 <1337983476-22081-5-git-send-email-richard@nod.at>
 <20120601175459.GA23541@codeaurora.org>
 <20120601184212.GB20460@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30618 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933636Ab2FATBi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 15:01:38 -0400
Content-Disposition: inline
In-Reply-To: <20120601184212.GB20460@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Brown <davidb@codeaurora.org>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org

On Fri, Jun 01, 2012 at 11:42:12AM -0700, David Brown wrote:
> On Fri, Jun 01, 2012 at 12:54:59PM -0500, Richard Kuo wrote:
> > On Sat, May 26, 2012 at 12:04:21AM +0200, Richard Weinberger wrote:
> > > get_signal_to_deliver() calls try_to_freeze() which might sleep.
> > > 
> > > Cc: Richard Kuo <rkuo@codeaurora.org>
> > > Cc: linux-hexagon@vger.kernel.org
> > > Signed-off-by: Richard Weinberger <richard@nod.at>
> > > ---
> > >  arch/hexagon/kernel/signal.c |    3 +++
> > >  1 files changed, 3 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
> > > index 434866e..8403bfd 100644
> > > --- a/arch/hexagon/kernel/signal.c
> > > +++ b/arch/hexagon/kernel/signal.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/syscalls.h>
> > >  #include <linux/freezer.h>
> > >  #include <linux/tracehook.h>
> > > +#include <linux/irqflags.h>
> > >  #include <asm/registers.h>
> > >  #include <asm/thread_info.h>
> > >  #include <asm/unistd.h>
> > > @@ -267,6 +268,8 @@ no_restart:
> > >  
> > >  void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
> > >  {
> > > +	local_irq_enable();
> > > +
> > >  	if (thread_info_flags & _TIF_SIGPENDING)
> > >  		do_signal(regs);
> > >  
> > > -- 
> > > 1.7.7.3
> > 
> > Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> 
> Did you mean Acked-by?  Replying to an email with a Signed-off-by
> doesn't mean anything.  If you're pulling the patch into your own
> tree, add the SoB at that point.  If you want to reply that you've
> accepted a patch, just say so in English.
> 
> David

Doh, sorry, I really meant Acked-by.  Thanks for catching that.


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
