From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 02/14] avr32: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 20:23:42 +1000
Message-ID: <20100423102341.GB5683@laptop>
References: <20100422160613.723698029@suse.de>
 <20100422161222.953856396@suse.de>
 <alpine.DEB.2.00.1004221345350.25350@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51808 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213Ab0DWKXq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2010 06:23:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1004221345350.25350@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>

On Thu, Apr 22, 2010 at 01:45:56PM -0700, David Rientjes wrote:
> On Fri, 23 Apr 2010, npiggin@suse.de wrote:
> 
> > As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> > oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> > simply killing current.
> > 
> > Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > ---
> > Index: linux-2.6/arch/avr32/mm/fault.c
> > ===================================================================
> > --- linux-2.6.orig/arch/avr32/mm/fault.c
> > +++ linux-2.6/arch/avr32/mm/fault.c
> > @@ -211,15 +211,10 @@ no_context:
> >  	 */
> >  out_of_memory:
> >  	up_read(&mm->mmap_sem);
> > -	if (is_global_init(current)) {
> > -		yield();
> > -		down_read(&mm->mmap_sem);
> > -		goto survive;
> > -	}
> > -	printk("VM: Killing process %s\n", tsk->comm);
> > -	if (user_mode(regs))
> > -		do_group_exit(SIGKILL);
> > -	goto no_context;
> > +	pagefault_out_of_memory();
> > +	if (!user_mode(regs))
> > +		goto no_context;
> 
> We want to test for !user_mode(regs) before calling 
> pagefault_out_of_memory().

Thanks for the careful review. We do indeed.
