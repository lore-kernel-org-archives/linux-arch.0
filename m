From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 11/14] powerpc: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 20:27:42 +1000
Message-ID: <20100423102742.GC5683@laptop>
References: <20100422160613.723698029@suse.de>
 <20100422161224.465958039@suse.de>
 <alpine.DEB.2.00.1004221442590.25350@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51910 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab0DWK1s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2010 06:27:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1004221442590.25350@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Thu, Apr 22, 2010 at 02:44:22PM -0700, David Rientjes wrote:
> On Fri, 23 Apr 2010, npiggin@suse.de wrote:
> 
> > As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> > oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> > simply killing current.
> > 
> > Cc: linuxppc-dev@ozlabs.org
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > ---
> > Index: linux-2.6/arch/powerpc/mm/fault.c
> > ===================================================================
> > --- linux-2.6.orig/arch/powerpc/mm/fault.c
> > +++ linux-2.6/arch/powerpc/mm/fault.c
> > @@ -359,15 +359,10 @@ bad_area_nosemaphore:
> >   */
> >  out_of_memory:
> >  	up_read(&mm->mmap_sem);
> > -	if (is_global_init(current)) {
> > -		yield();
> > -		down_read(&mm->mmap_sem);
> > -		goto survive;
> > -	}
> > -	printk("VM: killing process %s\n", current->comm);
> > -	if (user_mode(regs))
> > -		do_group_exit(SIGKILL);
> > -	return SIGKILL;
> > +	if (!user_mode(regs))
> > +		return SIGKILL;
> > +	pagefault_out_of_memory();
> > +	return 0;
> 
> Do we really want to return 0 and indicate that the fault was handled?  It 
> seems more consistent to do
> 
> 	if (user_mode(regs))
> 		pagefault_out_of_memory();
> 	return SIGKILL;

Well we don't necessarily want to kill current.
pagefault_out_of_memory() could elect to send a SIGKILL if wants to, but
if it decides current should not be terminated, then we have to just
retry the page fault.
